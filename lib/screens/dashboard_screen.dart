import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../data/models/apis/UIResponse.dart';
import '../../data/models/prediction_dashboard_response.dart';
import '../../data/repositories/user_repository_impl.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  const DashboardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<UIResponse<List<PredictionModel>>> _predictionsFuture;
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _predictionsFuture = _userRepository.fetchPredictions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white), // <-- Makes back arrow white
        title: const Text(
          'Predictions Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<UIResponse<List<PredictionModel>>>(
        future: _predictionsFuture,
        builder: (context, snapshot) {
          // 1) Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2) Error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // 3) Check if UIResponse has an error
          else if (snapshot.data == null || snapshot.data!.error != null) {
            return Center(
              child: Text('Error: ${snapshot.data?.error ?? "Unknown error"}'),
            );
          }
          // 4) Success
          else {
            final predictions = snapshot.data!.data ?? [];
            if (predictions.isEmpty) {
              return const Center(child: Text("No predictions found."));
            }

            // Calculate metrics
            final diseaseCounts = _groupByPredictedDisease(predictions);
            final dateCounts = _groupPredictionsByDate(predictions);
            final diagnosisCounts = _groupByDiagnosis(predictions);
            final doctorCounts = _groupByDoctor(predictions);
            final patientCounts = _groupByPatient(predictions);
            final avgTimeToPrediction =
                _calculateAverageTimeToPrediction(predictions);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1) High-level Stats
                  _buildStatsCard(predictions.length, avgTimeToPrediction),
                  const SizedBox(height: 16),

                  // 2) Pie Chart: Distribution of Predicted Diseases
                  _buildChartCard(
                    title: 'Distribution of Predicted Diseases',
                    child: SizedBox(
                      height: 300,
                      child: _buildDiseasePieChart(diseaseCounts),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3) Bar Chart: Predictions Over Time (Daily)
                  _buildChartCard(
                    title: 'Predictions Over Time (Daily)',
                    child: SizedBox(
                      height: 300,
                      child: _buildPredictionsOverTimeBarChart(dateCounts),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4) Bar Chart: Most Common Diagnoses
                  _buildChartCard(
                    title: 'Most Common Diagnoses',
                    child: SizedBox(
                      height: 300,
                      child: _buildDiagnosisBarChart(diagnosisCounts),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 5) Breakdown by Doctor
                  _buildChartCard(
                    title: 'Breakdown by Doctor',
                    child: SizedBox(
                      height: 300,
                      child: _buildDoctorBarChart(doctorCounts),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 6) Breakdown by Patient
                  _buildChartCard(
                    title: 'Breakdown by Patient',
                    child: SizedBox(
                      height: 300,
                      child: _buildPatientBarChart(patientCounts),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Data Grouping
  // ---------------------------------------------------------------------

  /// Group predictions by predictedDisease
  Map<String, int> _groupByPredictedDisease(List<PredictionModel> predictions) {
    final Map<String, int> counts = {};
    for (final pred in predictions) {
      counts[pred.predictedDisease] = (counts[pred.predictedDisease] ?? 0) + 1;
    }
    return counts;
  }

  /// Group predictions by date (YYYY-MM-DD)
  Map<String, int> _groupPredictionsByDate(List<PredictionModel> predictions) {
    final Map<String, int> dateCounts = {};
    for (final pred in predictions) {
      final dateString =
          '${pred.predictionDate.year}-${pred.predictionDate.month.toString().padLeft(2, '0')}-${pred.predictionDate.day.toString().padLeft(2, '0')}';
      dateCounts[dateString] = (dateCounts[dateString] ?? 0) + 1;
    }
    return dateCounts;
  }

  /// Group predictions by the *actual* diagnosis from consultation
  Map<String, int> _groupByDiagnosis(List<PredictionModel> predictions) {
    final Map<String, int> diagCounts = {};
    for (final pred in predictions) {
      diagCounts[pred.consultation.diagnosis] =
          (diagCounts[pred.consultation.diagnosis] ?? 0) + 1;
    }
    return diagCounts;
  }

  /// Group predictions by doctor (username)
  Map<String, int> _groupByDoctor(List<PredictionModel> predictions) {
    final Map<String, int> docCounts = {};
    for (final pred in predictions) {
      docCounts[pred.doctor.username] =
          (docCounts[pred.doctor.username] ?? 0) + 1;
    }
    return docCounts;
  }

  /// Group predictions by patient (patientName)
  Map<String, int> _groupByPatient(List<PredictionModel> predictions) {
    final Map<String, int> patientCounts = {};
    for (final pred in predictions) {
      patientCounts[pred.patient.patientName] =
          (patientCounts[pred.patient.patientName] ?? 0) + 1;
    }
    return patientCounts;
  }

  /// Calculate average time (in hours) from consultation to prediction
  double _calculateAverageTimeToPrediction(List<PredictionModel> predictions) {
    if (predictions.isEmpty) return 0.0;
    double totalHours = 0.0;
    for (final pred in predictions) {
      final diff = pred.predictionDate
          .difference(pred.consultation.consultationDate)
          .inMinutes;
      totalHours += (diff / 60.0);
    }
    return totalHours / predictions.length;
  }

  // ---------------------------------------------------------------------
  // Widgets
  // ---------------------------------------------------------------------

  /// Shows total predictions and average time-to-predict in a card
  Widget _buildStatsCard(int totalPredictions, double avgTimeToPred) {
    return Card(
      color: Colors.teal.shade50,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left: total predictions
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Predictions',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalPredictions',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            // Right: average time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Avg Time-to-Predict (hrs)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    avgTimeToPred.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Wraps a chart in a card with a title
  Widget _buildChartCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  /// (1) Pie Chart: Distribution of Predicted Diseases
  Widget _buildDiseasePieChart(Map<String, int> dataMap) {
    final total = dataMap.values.fold(0, (sum, val) => sum + val);
    final sections = <PieChartSectionData>[];

    int colorIndex = 0;
    dataMap.forEach((disease, count) {
      final percentage = (count / total) * 100;
      sections.add(
        PieChartSectionData(
          value: count.toDouble(),
          title: '${disease}\n${percentage.toStringAsFixed(1)}%',
          radius: 60,
          color: Colors.primaries[colorIndex % Colors.primaries.length],
          showTitle: true,
          titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      );
      colorIndex++;
    });

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  /// (2) Bar Chart: Predictions Over Time (Daily)
  Widget _buildPredictionsOverTimeBarChart(Map<String, int> dataMap) {
    final sortedKeys = dataMap.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < sortedKeys.length; i++) {
      final date = sortedKeys[i];
      final count = dataMap[date]!.toDouble();

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: count,
              width: 12,
              color: Colors.teal,
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= sortedKeys.length) {
                  return const SizedBox.shrink();
                }
                // Show only MM-DD
                return Text(
                  sortedKeys[idx].substring(5),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// (3) Bar Chart: Most Common Diagnoses
  Widget _buildDiagnosisBarChart(Map<String, int> dataMap) {
    final keys = dataMap.keys.toList();
    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < keys.length; i++) {
      final diagnosis = keys[i];
      final count = dataMap[diagnosis]!.toDouble();
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: count,
              width: 12,
              color: Colors.deepOrangeAccent,
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= keys.length) return const SizedBox();
                // Shorten label if needed
                final label = keys[idx].length > 6
                    ? '${keys[idx].substring(0, 6)}..'
                    : keys[idx];
                return Text(label, style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
      ),
    );
  }

  /// (4) Bar Chart: Breakdown by Doctor
  Widget _buildDoctorBarChart(Map<String, int> dataMap) {
    final doctors = dataMap.keys.toList();
    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < doctors.length; i++) {
      final docName = doctors[i];
      final count = dataMap[docName]!.toDouble();
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: count, width: 12, color: Colors.pinkAccent),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= doctors.length) return const SizedBox();
                final shortName = doctors[idx].length > 5
                    ? '${doctors[idx].substring(0, 5)}..'
                    : doctors[idx];
                return Text(shortName, style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
      ),
    );
  }

  /// (5) Bar Chart: Breakdown by Patient
  Widget _buildPatientBarChart(Map<String, int> dataMap) {
    final patients = dataMap.keys.toList();
    final barGroups = <BarChartGroupData>[];
    for (int i = 0; i < patients.length; i++) {
      final patient = patients[i];
      final count = dataMap[patient]!.toDouble();
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(toY: count, width: 12, color: Colors.blueAccent),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= patients.length) return const SizedBox();
                final short = patients[idx].length > 5
                    ? '${patients[idx].substring(0, 5)}..'
                    : patients[idx];
                return Text(short, style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
      ),
    );
  }
}
