import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/utils/error_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Username dan Password tidak boleh kosong!'),
      //     backgroundColor: Colors.red,
      //   ),
      // );

      context.showErrorSnackBar('Username dan Password tidak boleh kosong!');
      return;
    }

    if (password.length < 6) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Password minimal 6 karakter!'),
      //     backgroundColor: Colors.red,
      //   ),
      // );

      context.showErrorSnackBar('Password minimal 6 karakter!');
      return;
    }

    Navigator.pop(context, {'username': username, 'password': password});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Buat Akun Baru',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 50),

              Align(alignment: Alignment.centerLeft, child: Text('Username')),
              SizedBox(height: 8),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan username',
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
                  hintText: 'Masukkan password (min. 6 karakter)',
                ),
              ),

              SizedBox(height: 48),

              MaterialButton(
                minWidth: double.infinity,
                onPressed: _register,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
