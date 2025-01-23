// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// // Import the file where UserRepositoryImpl is defined
// import '../../data/repositories/user_repository_impl.dart';
// import '../../data/models/user_model.dart';
// import '../../data/models/apis/UIResponse.dart';
// import 'patient_list_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _logger = Logger();

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Use UserRepositoryImpl
//   final UserRepositoryImpl _userRepository = UserRepositoryImpl();

//   bool isLoading = false;
//   String? errorMessage;

//   void _login() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     final username = _usernameController.text.trim();
//     final password = _passwordController.text.trim();

//     if (username.isEmpty || password.isEmpty) {
//       setState(() {
//         errorMessage = 'Please enter both username and password';
//         isLoading = false;
//       });
//       return;
//     }

//     final UIResponse<User> response =
//         await _userRepository.login(username, password);
//     setState(() => isLoading = false);

//     // Check UIResponse
//     if (response.isSuccess && response.data != null) {
//       final User user = response.data!;
//       _logger.i('Login successful. User ID: ${user.userId}');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PatientListScreen(userId: user.userId),
//         ),
//       );
//     } else {
//       setState(() {
//         errorMessage = response.error ?? 'Invalid login credentials';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Please enter the username and password given by authorities",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: const Icon(Icons.lock),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               if (errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: Text(
//                     errorMessage!,
//                     style: const TextStyle(color: Colors.red, fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../data/models/user_model.dart';
import '../../data/models/apis/UIResponse.dart';
import 'patient_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _logger = Logger();
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool _obscurePassword = true; // For show/hide password
  bool _rememberMe = false; // Example checkbox
  String? errorMessage;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both username and password.';
        isLoading = false;
      });
      return;
    }

    // Attempt login
    final UIResponse<User> response =
        await _userRepository.login(username, password);

    if (!mounted) return; // Safeguard if widget is disposed
    setState(() => isLoading = false);

    if (response.isSuccess && response.data != null) {
      final User user = response.data!;
      _logger.i('Login successful. User ID: ${user.userId}');

      // If needed, handle "Remember me" logic (e.g., store username in prefs)
      // if (_rememberMe) { ... }

      // Navigate to next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PatientListScreen(userId: user.userId),
        ),
      );
    } else {
      setState(() {
        errorMessage = response.error ?? 'Invalid login credentials';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend body behind the app bar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // Gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Title / Branding
                const SizedBox(height: 80),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[50],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Please enter your credentials to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 40),

                // Login Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Username Field
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Field with show/hide icon
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(() {
                                _obscurePassword = !_obscurePassword;
                              }),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Optional "Remember Me" row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text('Remember me'),
                              ],
                            ),
                            // You can add a "Forgot Password?" link if desired
                            TextButton(
                              onPressed: () {
                                // Navigate or do nothing
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ],
                        ),

                        // Error message
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        // Login Button or Loading indicator
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),

                // Extra spacing
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
