import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:social_app/resources/auth_methods.dart";
import "package:social_app/responsive/mobile_screen_layout.dart";
import "package:social_app/responsive/responsive_layout_screen.dart";
import "package:social_app/responsive/web_screen_layout.dart";
import "package:social_app/screens/login_screen_layout.dart";
import "package:social_app/utils/colors.dart";
import "package:social_app/utils/utils.dart";
import "package:social_app/widgets/text_field_layout.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void navigateToLogin() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //username
              TextFieldInput(
                hintText: 'Enter Your Username',
                textInputType: TextInputType.text,
                textEditingController: _usernamecontroller,
              ),
              //bio
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter Your bio',
                textInputType: TextInputType.text,
                textEditingController: _biocontroller,
              ),
              const SizedBox(height: 24),
              //email
              TextFieldInput(
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailcontroller,
              ),
              //password
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordcontroller,
                isPass: true,
              ),
              const SizedBox(height: 24),
              //login button
              InkWell(
                onTap: () async {
                  setState(() {
                    _isloading = true;
                  });
                  String res = await AuthMethods().signupUser(
                    email: _emailcontroller.text,
                    password: _passwordcontroller.text,
                    username: _usernamecontroller.text,
                    bio: _biocontroller.text,
                  );
                  setState(() {
                    _isloading = false;
                  });
                  if (res != 'success') {
                    showSnackBar(res, context);
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder:
                            (context) => const ResponsiveLayout(
                              webscreenlayout: WebScreenLayout(),
                              mobileScreenLayout: MobileScreenLayout(),
                            ),
                      ),
                    );
                  }
                },
                child: Container(
                  child:
                      _isloading
                          ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                          : const Text('Sign Up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              //register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Log In.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
