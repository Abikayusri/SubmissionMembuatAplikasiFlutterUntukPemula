import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/auth/register_page.dart';
import 'package:submission_flutter_untuk_pemula/utils/snackbar_extension.dart';

import '../dashboard/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  static const String defaultUsername = "Abikayusri";
  static const String defaultPassword = "Admin123!";

  static String? registeredUsername;
  static String? registeredPassword;

  // Controllers as instance variables
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login(String inputUsername, String inputPassword) {
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

  void _navigateToRegister() async {
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
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    // Responsive padding
    final horizontalPadding = isWeb
        ? (screenWidth * 0.2).clamp(20.0, 200.0)
        : 16.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top spacer - flexible
                    Flexible(
                      flex: 1,
                      child: SizedBox(height: screenHeight * 0.05),
                    ),

                    // Welcome text
                    Text(
                      'Selamat Datang di Login Page',
                      style: TextStyle(
                        fontSize: isWeb ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Spacing after title
                    SizedBox(height: screenHeight * 0.08),

                    // Login form
                    _buildLoginForm(
                      usernameController,
                      passwordController,
                      isWeb,
                    ),

                    // Bottom spacer - flexible
                    Flexible(
                      flex: 1,
                      child: SizedBox(height: screenHeight * 0.05),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(
    TextEditingController usernameController,
    TextEditingController passwordController,
    bool isWeb,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Username field
        _buildInputField(
          label: 'Username',
          controller: usernameController,
          hintText: 'Default: Abikayusri',
          isWeb: isWeb,
        ),

        SizedBox(height: screenHeight * 0.03),

        // Password field
        _buildInputField(
          label: 'Password',
          controller: passwordController,
          hintText: 'Default: Admin123!',
          isPassword: true,
          isWeb: isWeb,
        ),

        SizedBox(height: screenHeight * 0.06),

        // Login button
        _buildLoginButton(usernameController, passwordController, isWeb),

        SizedBox(height: screenHeight * 0.03),

        // Register link
        _buildRegisterLink(isWeb),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    required bool isWeb,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isWeb ? 18 : 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(fontSize: isWeb ? 16 : 14),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.teal, width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: isWeb ? 14 : 12,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isWeb ? 16 : 12,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(
    TextEditingController usernameController,
    TextEditingController passwordController,
    bool isWeb,
  ) {
    return SizedBox(
      height: isWeb ? 56 : 48,
      child: ElevatedButton(
        onPressed: () => _login(
          usernameController.text.trim(),
          passwordController.text.trim(),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: isWeb ? 18 : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink(bool isWeb) {
    return Center(
      child: TextButton(
        onPressed: () => _navigateToRegister(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 24 : 16,
            vertical: isWeb ? 16 : 12,
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Belum punya akun? ',
                style: TextStyle(
                  fontSize: isWeb ? 16 : 14,
                  color: Colors.grey.shade600,
                ),
              ),
              TextSpan(
                text: 'Daftar di sini!',
                style: TextStyle(
                  fontSize: isWeb ? 16 : 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
