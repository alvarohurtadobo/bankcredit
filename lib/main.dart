import 'package:credidiunsa_app/bank/ui/accountDetails.dart';
import 'package:credidiunsa_app/bank/ui/contact.dart';
import 'package:credidiunsa_app/bank/ui/paymentMethods.dart';
import 'package:credidiunsa_app/bank/ui/politics.dart';
import 'package:credidiunsa_app/bank/ui/promotions.dart';
import 'package:credidiunsa_app/user/ui/createAccountPage.dart';
import 'package:credidiunsa_app/user/ui/housePage.dart';
import 'package:credidiunsa_app/user/ui/profile.dart';
import 'package:credidiunsa_app/user/ui/resetPassword01Page.dart';
import 'package:credidiunsa_app/user/ui/homePage.dart';
import 'package:credidiunsa_app/user/ui/resetPassword02Page.dart';
import 'package:credidiunsa_app/user/ui/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/resetPassword01': (context) => const ResetPassword01Page(),
          '/resetPassword02': (context) => const ResetPassword02Page(),
          '/createAccount': (context) => const CreateAccountPage(),
          '/house': (context) => const HousePage(),
          '/politics': (context) => const PoliticsPage(),
          '/contact': (context) => const ContactPage(),
          '/promotions': (context) => const PromotionsPage(),
          '/profile': (context) => const ProfilePage(),
          '/payment': (context) => const PaymentMethodsPage(),
          '/accountDetails': (context) => const AccountDetailsPage(),
        });
  }
}
