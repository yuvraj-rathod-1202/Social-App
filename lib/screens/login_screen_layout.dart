import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:social_app/resources/auth_methods.dart";
import "package:social_app/responsive/mobile_screen_layout.dart";
import "package:social_app/responsive/responsive_layout_screen.dart";
import "package:social_app/responsive/web_screen_layout.dart";
import "package:social_app/screens/signup_screen_layout.dart";
import "package:social_app/utils/colors.dart";
import "package:social_app/utils/utils.dart";
import "package:social_app/widgets/text_field_layout.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void navigateToSignUp() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );

    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webscreenlayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
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
                onTap: loginUser,
                child: Container(
                  child:
                      _isLoading
                          ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                          : const Text('Log in'),
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
                    onTap: navigateToSignUp,
                    child: Container(
                      child: const Text(
                        "Sign up.",
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
