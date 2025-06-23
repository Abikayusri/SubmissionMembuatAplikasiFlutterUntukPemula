import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/utils/snackbar_extension.dart';

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
      context.showErrorSnackBar('Username dan Password tidak boleh kosong!');
      return;
    }

    if (password.length < 6) {
      context.showErrorSnackBar('Password minimal 6 karakter!');
      return;
    }

    Navigator.pop(context, {'username': username, 'password': password});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    // Responsive padding
    final horizontalPadding = isWeb
        ? (screenWidth * 0.2).clamp(20.0, 200.0)
        : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
          style: TextStyle(
            fontSize: isWeb ? 20 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight, // AppBar height
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top spacer - flexible
                    Flexible(
                      flex: 1,
                      child: SizedBox(height: screenHeight * 0.03),
                    ),

                    // Title
                    Text(
                      'Buat Akun Baru',
                      style: TextStyle(
                        fontSize: isWeb ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Spacing after title
                    SizedBox(height: screenHeight * 0.06),

                    // Register form
                    _buildRegisterForm(isWeb, screenHeight),

                    // Bottom spacer - flexible
                    Flexible(
                      flex: 1,
                      child: SizedBox(height: screenHeight * 0.03),
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

  Widget _buildRegisterForm(bool isWeb, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Username field
        _buildInputField(
          label: 'Username',
          controller: usernameController,
          hintText: 'Masukkan username',
          isWeb: isWeb,
        ),

        SizedBox(height: screenHeight * 0.03),

        // Password field
        _buildInputField(
          label: 'Password',
          controller: passwordController,
          hintText: 'Masukkan password (min. 6 karakter)',
          isPassword: true,
          isWeb: isWeb,
        ),

        SizedBox(height: screenHeight * 0.06),

        // Register button
        _buildRegisterButton(isWeb),

        SizedBox(height: screenHeight * 0.02),

        // Info text
        _buildInfoText(isWeb),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
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
            prefixIcon: Icon(
              isPassword ? Icons.lock_outline : Icons.person_outline,
              color: Colors.grey.shade600,
              size: isWeb ? 24 : 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(bool isWeb) {
    return SizedBox(
      height: isWeb ? 56 : 48,
      child: ElevatedButton(
        onPressed: _register,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Colors.teal.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: isWeb ? 20 : 18),
            const SizedBox(width: 8),
            Text(
              'Register',
              style: TextStyle(
                fontSize: isWeb ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(bool isWeb) {
    return Container(
      padding: EdgeInsets.all(isWeb ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade600,
            size: isWeb ? 20 : 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Setelah berhasil register, Anda akan kembali ke halaman login',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: isWeb ? 14 : 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
