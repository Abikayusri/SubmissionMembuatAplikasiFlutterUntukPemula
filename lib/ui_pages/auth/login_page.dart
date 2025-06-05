import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selamat Datang di Login Page'),

              SizedBox(height: 100),

              Text('Username'),
              SizedBox(height: 8),
              Text('Kotaknya'),

              SizedBox(height: 24),

              Text('Username'),
              SizedBox(height: 8),
              Text('Kotaknya'),
              SizedBox(height: 48),

              MaterialButton(
                minWidth: double.infinity,
                onPressed: () {},
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Login'),
              ),

              SizedBox(height: 24),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
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
