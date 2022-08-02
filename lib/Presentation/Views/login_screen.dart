// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_final_fields
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../Configurations/Colors.dart';
import '../../Infrastructure/Providers/user_provider.dart';
import '../../Infrastructure/Services/auth_services.dart';
import '../../Infrastructure/Services/user_services.dart';
import '../../Configurations/res.dart';
import '../Widgets/appbutton.dart';
import '../Widgets/auth_textfield_widget.dart';
import 'CreateAccount.dart';
import 'home_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  File? _file;
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  bool isLoading = false;

  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 30.0,
  );
  bool isLoadingspin = true;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "LoginScreen");
  }

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: SpinKitWave(
        size: 30,
        color: MyAppColors.appColor,
      ),
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 17)),
                InkWell(
                  onTap: () {
                    Get.to(CreateAccount());
                  },
                  child: Text(" Create Account",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.appColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: 17)),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
        backgroundColor: MyAppColors.bgcolor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),

                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Login",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Enter your email and password to continue",
                              style: GoogleFonts.roboto(
                                  // fontFamily: 'Gilroy',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: authtextfieldWidget(
                          headingtext: "Email",
                          onPwdTap: () {
                            setState(() {
                              isvisible = !isvisible;
                            });
                          },
                          visible: isvisible,
                          isPasswordField: true,
                          suffixIcon2: Icons.visibility_off,
                          suffixIcon: Res.emailicon,
                          maxlength: 20,
                          keyboardtype: TextInputType.text,
                          authcontroller: _emailController,
                          showImage: false,
                          showsuffix: false,
                          showpassoricon: false,
                          suffixImage: Res.personicon,
                          text: "JohnDoe@gmail.com",
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return "Please Enter Valid Email Address";
                            } else if (value.length <= 2)
                              return "Please Enter more than 2 words";
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: authtextfieldWidget(
                            headingtext: "Password",
                            onPwdTap: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                            visible: isvisible,
                            isPasswordField: true,
                            suffixIcon2: Icons.visibility_off,
                            suffixIcon: Res.emailicon,
                            maxlength: 20,
                            keyboardtype: TextInputType.text,
                            authcontroller: _passwordController,
                            showImage: false,
                            showsuffix: false,
                            showpassoricon: true,
                            suffixImage: Res.personicon,
                            text: "JohnDoe@gmail.com",
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please Enter more than 6 digit password";
                              } else if (value.length < 6)
                                return "Please Enter atleast 6 password";
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                AppButton(
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _loginUser(context);
                    // SharedPreferences sharedPreferences =
                    //     await SharedPreferences.getInstance();
                    // sharedPreferences.setString("token", _emailController.text);
                    //   Get.to(const Bottomnavigation());
                  },
                  containerheight: 55,
                  text: "Login",
                ),
                const SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          //Get.to(ForgotPassword());
                        },
                        child: Text("Forgot Password?",
                            style: GoogleFonts.roboto(
                                // fontFamily: 'Gilroy',
                                color: MyAppColors.appColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginUser(BuildContext context) async {
    makeLoadingTrue();
    try {
      ///This will allow user to register in firebase
      return await authServices
          .loginUser(
              email: _emailController.text, password: _passwordController.text)
          .whenComplete(() => makeLoadingFalse())
          .then((firebaseUser) async {
        userServices
            .fetchUserRecord(firebaseUser.uid.toString())
            .first
            .then((userData) async {
          print(userData.toJson('docID'));
          Provider.of<UserProvider>(context, listen: false)
              .saveUserDetails(userData);
          //  await UserLoginStateHandler.saveUserLoggedInSharedPreference(true);
          //  Get.to(HomeView());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeView()));
          return Fluttertoast.showToast(msg: "Login Successfully");
        });
      });
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('ALert!'),
            content: Text(e.message.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  makeLoadingFalse();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        //message to show toast
        toastLength: Toast.LENGTH_LONG,
        //duration for message to show
        gravity: ToastGravity.CENTER,
        //where you want to show, top, bottom
        timeInSecForIosWeb: 1,
        //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.red,
        //message text color
        fontSize: 16.0 //message font size
        );
  }
}

