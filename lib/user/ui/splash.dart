// Language: dart

import 'dart:async';
import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:credidiunsa_app/user/bloc/userLogin.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString("jwt") ?? "";
      String document = prefs.getString("document") ?? "";
      String password = prefs.getString("password") ?? "";
      bool recoverRememberMe = prefs.getBool("remmemberme") ?? false;
      print("Saved data is $document, $password, $recoverRememberMe,$jwt");
      if (jwt != "" && document != "" && password != "") {
        API.login(document, password).then((BackendResponse backendResponse) {
          if (backendResponse.status == 200) {
            setUpUser(backendResponse.myBody,
                password: password, rememberMe: recoverRememberMe);
            Timer(const Duration(seconds: 1), () {
              Navigator.of(context).pushReplacementNamed('/home');
            });
          } else {
            // Fluttertoast.showToast(msg: "Problem with login");
            Timer(const Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed('/login');
            });
          }
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    return Scaffold(
      body: Center(
        child: Container(
          width: Sizes.width * 0.8,
          height: Sizes.width * 0.8,
          // margin: EdgeInsets.all(Sizes.padding),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  fit: BoxFit.contain)),
        ),
      ),
    );
  }
}
