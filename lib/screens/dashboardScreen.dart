import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'patient_list_screen.dart';
import 'addPatient_screen.dart';
import 'loginpage.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;
  DashboardScreen({required this.userId});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 1; // Set the initial index to Dashboard (index 1)
  final List<Map<String, dynamic>> _hospitalData = [
    {
      'hospital': 'Amrita Institute of Medical Sciences and Research Centre',
      'location': 'Amrita Lane',
      'cases': 350,
      'flu': 100,
      'covid': 200,
      'dengue': 50,
      'fever': 30,
      'active': 120,
      'recovered': 200,
      'deaths': 30,
      'beds': '15/200',
      'risk': 'High'
    },
    {
      'hospital': 'City Hospital',
      'location': 'M.G.Road',
      'cases': 150,
      'flu': 50,
      'covid': 80,
      'dengue': 20,
      'fever': 10,
      'active': 40,
      'recovered': 100,
      'deaths': 10,
      'beds': '30/100',
      'risk': 'Medium'
    },
    {
      'hospital': 'Cochin Hospital',
      'location': 'M.G.Road',
      'cases': 200,
      'flu': 70,
      'covid': 90,
      'dengue': 40,
      'fever': 15,
      'active': 50,
      'recovered': 130,
      'deaths': 20,
      'beds': '50/150',
      'risk': 'High'
    },
    {
      'hospital': 'Ernakulam Medical Centre',
      'location': 'Palarivattom',
      'cases': 100,
      'flu': 30,
      'covid': 50,
      'dengue': 10,
      'fever': 5,
      'active': 20,
      'recovered': 60,
      'deaths': 5,
      'beds': '15/80',
      'risk': 'Low'
    },
    {
      "hospital": "Aster Medcity",
      "location": "Cheranalloor",
      "cases": 420,
      "flu": 130,
      "covid": 180,
      "dengue": 60,
      "fever": 50,
      "active": 150,
      "recovered": 240,
      "deaths": 30,
      "beds": "20/250",
      "risk": "High"
    },
    {
      "hospital": "Lisie Hospital",
      "location": "Kaloor",
      "cases": 300,
      "flu": 90,
      "covid": 120,
      "dengue": 40,
      "fever": 50,
      "active": 90,
      "recovered": 180,
      "deaths": 30,
      "beds": "10/180",
      "risk": "Medium"
    },
    {
      "hospital": "Rajagiri Hospital",
      "location": "Aluva",
      "cases": 500,
      "flu": 150,
      "covid": 250,
      "dengue": 60,
      "fever": 40,
      "active": 200,
      "recovered": 270,
      "deaths": 30,
      "beds": "25/300",
      "risk": "High"
    },
    {
      "hospital": "Medical Trust Hospital",
      "location": "MG Road",
      "cases": 350,
      "flu": 100,
      "covid": 160,
      "dengue": 50,
      "fever": 40,
      "active": 120,
      "recovered": 200,
      "deaths": 30,
      "beds": "15/220",
      "risk": "Medium"
    },
    {
      "hospital": "Sunrise Hospital",
      "location": "Kakkanad",
      "cases": 280,
      "flu": 80,
      "covid": 130,
      "dengue": 30,
      "fever": 40,
      "active": 100,
      "recovered": 150,
      "deaths": 30,
      "beds": "10/150",
      "risk": "Medium"
    },
    {
      "hospital": "Specialist Hospital",
      "location": "Kadavanthra",
      "cases": 310,
      "flu": 90,
      "covid": 140,
      "dengue": 40,
      "fever": 40,
      "active": 110,
      "recovered": 170,
      "deaths": 30,
      "beds": "12/190",
      "risk": "Medium"
    },
    {
      "hospital": "PVS Memorial Hospital",
      "location": "Kaloor",
      "cases": 290,
      "flu": 85,
      "covid": 120,
      "dengue": 35,
      "fever": 50,
      "active": 90,
      "recovered": 170,
      "deaths": 30,
      "beds": "14/180",
      "risk": "Medium"
    },
    {
      "hospital": "Renai Medicity",
      "location": "Palarivattom",
      "cases": 450,
      "flu": 140,
      "covid": 220,
      "dengue": 60,
      "fever": 30,
      "active": 160,
      "recovered": 260,
      "deaths": 30,
      "beds": "18/230",
      "risk": "High"
    },
    {
      "hospital": "VPS Lakeshore Hospital",
      "location": "Nettoor",
      "cases": 370,
      "flu": 110,
      "covid": 170,
      "dengue": 50,
      "fever": 40,
      "active": 130,
      "recovered": 210,
      "deaths": 30,
      "beds": "20/210",
      "risk": "High"
    },
    {
      "hospital": "KIMS Hospital",
      "location": "Kumbalam",
      "cases": 330,
      "flu": 95,
      "covid": 150,
      "dengue": 45,
      "fever": 40,
      "active": 110,
      "recovered": 190,
      "deaths": 30,
      "beds": "17/200",
      "risk": "Medium"
    }
  ];

  List<Map<String, dynamic>> _filteredHospitalData = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredHospitalData = _hospitalData;
    _searchController.addListener(_filterData);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterData);
    _searchController.dispose();
    super.dispose();
  }

  // Filter hospital data based on search query
  void _filterData() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHospitalData = _hospitalData.where((hospital) {
        return hospital['hospital'].toLowerCase().contains(query) ||
            hospital['location'].toLowerCase().contains(query);
      }).toList();
    });
  }

  //navigation path
  void _navigateToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PatientListScreen(userId: widget.userId))); //home
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardScreen(userId: widget.userId)),
    );
  }

  void _navigateToAddPatient() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPatientScreen(userId: widget.userId)),
    );

    if (result == true) {
      // Refresh the patient list (or any other state update logic you need)
    }
  }

  void _exitApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pie Chart
              Center(
                child: SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sections: _generatePieChartSections(),
                      centerSpaceRadius: 50,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Legend
              Center(child: _buildLegend()),
              SizedBox(height: 30),
              // Hospital Data Heading
              Text(
                'Hospital-Wise Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by Hospital or Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Hospital Data Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Hospital Name',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Location',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Total Cases',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Flu',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('COVID-19',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Dengue',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fever',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Active Cases',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Recovered',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Deaths',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Beds Available',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Risk Level',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold))),
                  ],
                  rows: _filteredHospitalData.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['hospital'])),
                      DataCell(Text(data['location'])),
                      DataCell(Text(data['cases'].toString())),
                      DataCell(Text(data['flu'].toString())),
                      DataCell(Text(data['covid'].toString())),
                      DataCell(Text(data['dengue'].toString())),
                      DataCell(Text(data['fever'].toString())),
                      DataCell(Text(data['active'].toString())),
                      DataCell(Text(data['recovered'].toString())),
                      DataCell(Text(data['deaths'].toString())),
                      DataCell(Text(data['beds'])),
                      DataCell(Text(data['risk'])),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: _currentIndex == 1 ? Colors.white : Colors.white70,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Track the selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on tap
          });

          // Navigate to the corresponding screen based on the selected index
          switch (index) {
            case 0:
              _navigateToHome();
              break;
            case 1:
              _navigateToDashboard();
              break;
            case 2:
              _navigateToAddPatient();
              break;
            case 3:
              _exitApp();
              break;
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Patient',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    // Sum the values for the selected hospital data (filtered data)
    double totalFlu = 0;
    double totalCovid = 0;
    double totalDengue = 0;
    double totalFever = 0;

    for (var hospital in _filteredHospitalData) {
      totalFlu += hospital['flu'];
      totalCovid += hospital['covid'];
      totalDengue += hospital['dengue'];
      totalFever += hospital['fever']; // Include fever data
    }

    double totalCases = totalFlu +
        totalCovid +
        totalDengue +
        totalFever; // Include fever in total cases

    // Calculate the percentage for each disease
    double fluPercentage = (totalCases > 0) ? (totalFlu / totalCases) * 100 : 0;
    double covidPercentage =
        (totalCases > 0) ? (totalCovid / totalCases) * 100 : 0;
    double denguePercentage =
        (totalCases > 0) ? (totalDengue / totalCases) * 100 : 0;
    double feverPercentage =
        (totalCases > 0) ? (totalFever / totalCases) * 100 : 0;

    // Return the sections for the pie chart
    return [
      PieChartSectionData(
        color: Colors.teal,
        value: fluPercentage,
        title: '${fluPercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: covidPercentage,
        title: '${covidPercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: denguePercentage,
        title: '${denguePercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red, // Fever data color
        value: feverPercentage,
        title: '${feverPercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _buildLegend() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(Colors.teal, 'Flu'),
          _buildLegendItem(Colors.yellow, 'COVID-19'),
          _buildLegendItem(Colors.orange, 'Dengue'),
          _buildLegendItem(Colors.red, 'Fever'), // Added fever in legend
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
