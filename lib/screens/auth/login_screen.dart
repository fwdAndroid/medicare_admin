import 'package:flutter/material.dart';
import 'package:medicare_admin/model/user_model.dart';
import 'package:medicare_admin/screens/auth/forgot_password.dart';
import 'package:medicare_admin/screens/database/auth_methods.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/app_colors.dart';
import 'package:medicare_admin/utils/app_style.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/utils/input_text.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  bool passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      // Check if the user exists in the admin collection
      UserModel user = await AuthMethods().getUserDetails();
      if (user.isAdmin) {
        // User is an admin, navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // User is not an admin, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('You are not authorized to access this website.')),
        );
      }
    } else {
      // Show error message returned from the authentication method
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral,
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Log in",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
          ),
          const SizedBox(height: 41),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: _emailController,
            labelText: "example@gmail.com",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          TextFormField(
            controller: _passwordController,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              focusedBorder: AppStyles.focusedBorder,
              disabledBorder: AppStyles.focusBorder,
              enabledBorder: AppStyles.focusBorder,
              errorBorder: AppStyles.focusErrorBorder,
              focusedErrorBorder: AppStyles.focusErrorBorder,
              hintText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 30),
          _isLoading
              ? CircularProgressIndicator()
              : SaveButton(
                  color: mainBtnColor,
                  title: "Login",
                  onTap: signIn,
                ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: SizedBox(
                width: 154,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ForgotPassword()));
                  },
                  child: Text(
                    "Forgot Password",
                    style: GoogleFonts.dmSans(
                        color: mainBtnColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
