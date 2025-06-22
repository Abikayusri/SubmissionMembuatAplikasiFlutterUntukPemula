import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/register_page.dart';
import 'package:submission_flutter_untuk_pemula/utils/snackbar_extension.dart';

import '../dashboard/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String defaultUsername = "Abikayusri";
  static const String defaultPassword = "Admin123!";

  static String? registeredUsername;
  static String? registeredPassword;

  void _login(
    BuildContext context,
    String inputUsername,
    String inputPassword,
  ) {
    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      context.showErrorSnackBar('Username dan Password tidak boleh kosong!');
      return;
    }

    bool isDefaultLogin =
        (inputUsername == defaultUsername && inputPassword == defaultPassword);
    bool isRegisteredLogin =
        (registeredUsername != null && registeredPassword != null) &&
        (inputUsername == registeredUsername &&
            inputPassword == registeredPassword);

    if (isDefaultLogin || isRegisteredLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: inputUsername),
        ),
      );
    } else {
      context.showErrorSnackBar('Username atau Password salah!');
    }
  }

  void _navigateToRegister(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );

    if (result != null && result is Map<String, String>) {
      registeredUsername = result['username'];
      registeredPassword = result['password'];

      context.showSuccessSnackBar('Registrasi berhasil! Silakan login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat Datang di Login Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 100),

              Align(alignment: Alignment.centerLeft, child: Text('Username')),
              SizedBox(height: 8),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Default: Abikayusri',
                ),
              ),

              SizedBox(height: 24),

              Align(alignment: Alignment.centerLeft, child: Text('Password')),
              SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Default: Admin123!',
                ),
              ),

              SizedBox(height: 48),

              MaterialButton(
                minWidth: double.infinity,
                onPressed: () => _login(
                  context,
                  usernameController.text.trim(),
                  passwordController.text.trim(),
                ),
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Login'),
              ),

              SizedBox(height: 24),

              TextButton(
                onPressed: () => _navigateToRegister(context),
                child: Text(
                  'Daftar di sini!',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
