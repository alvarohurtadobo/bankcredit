// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:credidiunsa_app/user/ui/splash.dart';
import 'package:credidiunsa_app/bank/ui/contact.dart';
import 'package:credidiunsa_app/user/ui/profile.dart';
import 'package:credidiunsa_app/bank/ui/politics.dart';
import 'package:credidiunsa_app/user/ui/homePage.dart';
import 'package:credidiunsa_app/user/ui/loginPage.dart';
import 'package:credidiunsa_app/bank/ui/promotions.dart';
import 'package:credidiunsa_app/bank/ui/documentsPage.dart';
import 'package:credidiunsa_app/user/ui/resetPassword.dart';
import 'package:credidiunsa_app/bank/ui/accountDetails.dart';
import 'package:credidiunsa_app/bank/ui/paymentMethods.dart';
import 'package:credidiunsa_app/user/ui/createAccountPage.dart';
import 'package:credidiunsa_app/user/ui/updateProfilePage.dart';
import 'package:credidiunsa_app/user/ui/resetPassword01Page.dart';
import 'package:credidiunsa_app/user/ui/resetPassword00Page.dart';
import 'package:credidiunsa_app/user/ui/resetPassword02Page.dart';
import 'package:credidiunsa_app/user/ui/validateProfileUpdate.dart';
import 'package:credidiunsa_app/user/ui/updateProfilePicturePage.dart';
import 'package:credidiunsa_app/user/ui/confirmProfilePicturePage.dart';
import 'package:credidiunsa_app/common/ui/biometric_authentication.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'bank/ui/privacy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xff0077cd)));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences.setMockInitialValues({});
    return MaterialApp(
        title: 'CrediDiunsa App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        // locale: Locale('es', 'ES'),
        // supportedLocales: const [Locale('es', 'ES')],
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/resetPassword00': (context) => const ResetPassword00Page(),
          '/resetPassword01': (context) => const ResetPassword01Page(),
          '/resetPassword02': (context) => const ResetPassword02Page(),
          '/createAccount': (context) => const CreateAccountPage(),
          '/home': (context) => const HomePage(),
          '/politics': (context) => const PoliticsPage(),
          '/privacy': (context) => const PrivacyPage(),
          '/contact': (context) => const ContactPage(),
          '/promotions': (context) => const PromotionsPage(),
          '/profile': (context) => const ProfilePage(),
          '/payment': (context) => const PaymentMethodsPage(),
          '/accountDetails': (context) => const AccountDetailsPage(),
          '/resetPassword': (context) => const ResetPasswordPage(),
          '/biometric': (context) => const BiometricAuthentication(
              appBarTitle: "Ingresar con face/touch id"),
          '/updateProfilePicture': (context) =>
              const UpdateProfilePicturePage(),
          '/confirmProfilePicture': (context) =>
              const ConfirmProfilePicturePage(),
          '/updateEmail': (context) => const UpdateProfilePage(type: 0),
          '/updatePhone': (context) => const UpdateProfilePage(type: 1),
          '/validateEmailUpdate': (context) =>
              const ValidateProfileUpdatePage(type: 0),
          '/validatePhoneUpdate': (context) =>
              const ValidateProfileUpdatePage(type: 1),
          '/documents': (context) => const DocumentsPage(),
        });
  }
}
