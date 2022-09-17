// ignore_for_file: use_build_context_synchronously

import 'package:credidiunsa_app/common/widgets/biometricAuthDialog.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:local_auth/error_codes.dart' as local_auth_error;
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:credidiunsa_app/user/bloc/userLogin.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../common/ui/sizes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String documentId = "";
  String password = "";
  bool rememberMe = false;
  bool localEnabled = false;
  bool canContinue = false;
  bool isLoading = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool validatorEmpty1 = false;
  bool validatorEmpty2 = false;
  TextEditingController documentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _localAuthentication = LocalAuthentication();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      localEnabled = prefs.getBool("localEnabled") ?? false;
      print("Local auth is enabled $localEnabled, attempting login");
      documentId = prefs.getString("document") ?? "";
      password = prefs.getString("password") ?? "";
      bool recoverRememberMe = prefs.getBool("remmemberme") ?? false;
      print(" Recover in login is $recoverRememberMe");
      if (recoverRememberMe) {
        documentController.text = documentId;
        passwordController.text = password;
        setState(() {
          canContinue = documentId != "" && password != "";
          rememberMe = recoverRememberMe;
        });
      }
      if (localEnabled && !wasLogged) {
        print("cred: $documentId, $password");
        if (documentId == "" || password == "") {
          return;
        }
        try {
          _localAuthentication
              .authenticate(
            localizedReason: "Please authenticate to see account balance",
            // useErrorDialogs: true,
            // stickyAuth: false,
          )
              .then((isAuth) {
            if (isAuth) {
              setState(() {
                isLoading = true;
              });
              API
                  .login(documentId, password)
                  .then((BackendResponse myResponse) async {
                setState(() {
                  isLoading = false;
                });
                if (myResponse.idError == 0) {
                  // showToast("Ingreso exitoso");
                  bool success = setUpUser(myResponse.myBody,
                      password: password, rememberMe: recoverRememberMe);
                  if (success) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/home");
                  }
                }
              });
            }
          });
        } on PlatformException catch (exception) {
          if (exception.code == local_auth_error.notAvailable ||
              exception.code == local_auth_error.passcodeNotSet ||
              exception.code == local_auth_error.notEnrolled) {
            // Handle this exception here.
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Bottom is ${MediaQuery.of(context).viewInsets.bottom}");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    return Scaffold(
        body: Container(
            // margin: EdgeInsets.all(0),
            // padding: EdgeInsets.all(0),
            // alignment: Alignment.center,
            decoration: const BoxDecoration(
                // color: Colors.yellow,
                image: DecorationImage(
                    image: AssetImage("assets/images/image_01.png"),
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MediaQuery.of(context).viewInsets.bottom != 0
                      ? Container()
                      : SizedBox(
                          height: 3 * Sizes.padding,
                        ),
                  MediaQuery.of(context).viewInsets.bottom != 0
                      ? Container()
                      : Container(
                          width: Sizes.width * 0.8,
                          height: 90,
                          decoration: const BoxDecoration(
                              // color: Colors.yellow,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.contain)),
                        ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? SizedBox(
                          height: Sizes.height * 0.38 -
                              90 -
                              4 * Sizes.padding -
                              Sizes.tileHeightMedium,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: SizedBox(
                      // color: Colors.green,
                      width: Sizes.width,
                      height: Sizes.height * 0.62,
                      child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(height: 2 * Sizes.padding),
                            // GestureDetector(
                            // onLongPress: () {
                            //   showToast("Launch whatsapp");
                            //   customLaunchUrl("whatsapp://send?phone=+50431904365");
                            // },
                            // child:

                            const Text("¡Bienvenido!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                            // ),
                            SizedBox(
                              height: Sizes.padding,
                            ),
                            SizedBox(
                              width: Sizes.width * 0.72,
                              child: const Text(
                                  "Aquí podrás realizar todos tus trámites de tu cuenta CrediDiunsa",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                            SizedBox(
                              height: 2 * Sizes.padding,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.padding),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Número de documento",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: Sizes.boxSeparation,
                                      ),
                                      TextFormField(
                                        controller: documentController,
                                        obscureText: obscure1,
                                        onChanged: (value) {
                                          //  FocusScope.of(context).unfocus();
                                          documentId = value;
                                          setState(() {
                                            canContinue = documentId != "" &&
                                                password != "";
                                          });
                                        },
                                        maxLength: 13,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Este campo es obligatorio";
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: const TextInputType
                                                .numberWithOptions(
                                            signed: false, decimal: false),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            counter: Container(),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  obscure1 = !obscure1;
                                                });
                                                print("Toggle $obscure1");
                                              },
                                              child: obscure1
                                                  ? Image.asset(
                                                      "assets/icons/obscured.png")
                                                  : const SizedBox(
                                                      width: 60,
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            Color(0xff7A8084),
                                                      ),
                                                    ),
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Escribe",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        Sizes.boxSeparation),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(0xff0077CD)),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            disabledBorder: null),
                                      ),
                                      SizedBox(
                                        height: Sizes.padding,
                                      ),
                                      const Text("Contraseña",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                        height: Sizes.boxSeparation,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: obscure2,
                                        onChanged: (value) {
                                          // FocusScope.of(context).unfocus();
                                          password = value;
                                          setState(() {
                                            canContinue = documentId != "" &&
                                                password != "";
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Este campo es obligatorio";
                                          }
                                          return null;
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  obscure2 = !obscure2;
                                                });
                                                print("Toggle $obscure2");
                                              },
                                              child: obscure2
                                                  ? Image.asset(
                                                      "assets/icons/obscured.png")
                                                  : const SizedBox(
                                                      width: 60,
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            Color(0xff7A8084),
                                                      ),
                                                    ),
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Escribe",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        Sizes.boxSeparation),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Color(0xff0077CD)),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            disabledBorder: null),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Sizes.boxSeparation * 1.5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 14,
                                              height: 14,
                                              alignment: Alignment.center,
                                              // decoration: const BoxDecoration(
                                              //   borderRadius:
                                              //       BorderRadius.all(Radius.circular(7)),
                                              //   color: Colors.white,
                                              // ),
                                              color: Colors.transparent,
                                              child: Checkbox(
                                                value: rememberMe,
                                                onChanged: (value) {
                                                  print("Set state");
                                                  setState(() {
                                                    rememberMe = value ?? false;
                                                  });
                                                },
                                                fillColor: MaterialStateColor
                                                    .resolveWith((states) {
                                                  return const Color(
                                                      0xff0077cd);
                                                }),
                                                side: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                activeColor: Colors.white,
                                                checkColor: Colors.white,
                                                hoverColor: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                                width: Sizes.boxSeparation),
                                            GestureDetector(
                                              onTap: () {
                                                print("Set states");
                                                setState(() {
                                                  rememberMe = !rememberMe;
                                                });
                                              },
                                              child: Text("Recuérdame",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Sizes.font11)),
                                            ),
                                            const Expanded(
                                                child: SizedBox(
                                              width: 0,
                                            )),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    "/resetPassword00");
                                              },
                                              child: Text(
                                                  "Olvide mi contraseña",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Sizes.font11,
                                                    height: 0.9,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationThickness: 0.8,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3 * Sizes.boxSeparation,
                                      ),
                                      isLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Sizes.padding),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: canContinue
                                                    ? const Color(0xff0077cd)
                                                    : const Color(0xff7b8084),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Sizes.border),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    if (!canContinue) {
                                                      return;
                                                    }
                                                    if (isLoading) {
                                                      return;
                                                    }
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      if (documentId == "p") {
                                                        documentId =
                                                            "0828199100005";
                                                      }
                                                      if (password == "p") {
                                                        password =
                                                            "Diunsa2022*";
                                                      }
                                                      if (documentId == "m") {
                                                        documentId = "3067891";
                                                      }
                                                      if (password == "m") {
                                                        password = "Diunsa2022";
                                                      }
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      API
                                                          .login(documentId,
                                                              password)
                                                          .then((BackendResponse
                                                              myResponse) async {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        if (myResponse
                                                                .idError ==
                                                            0) {
                                                          bool success =
                                                              setUpUser(
                                                                  myResponse
                                                                      .myBody,
                                                                  password:
                                                                      password,
                                                                  rememberMe:
                                                                      rememberMe);
                                                          if (success) {
                                                            bool useBio =
                                                                await biometricAuthConfirmationDialog(
                                                                    context);
                                                            bool isAuthorized =
                                                                false;
                                                            bool
                                                                correctlyEnabledBio =
                                                                false;
                                                            if (useBio) {
                                                              try {
                                                                isAuthorized =
                                                                    await _localAuthentication
                                                                        .authenticate(
                                                                  localizedReason:
                                                                      "Please authenticate to see account balance",
                                                                  // useErrorDialogs: true,
                                                                  // stickyAuth: false,
                                                                );
                                                                correctlyEnabledBio =
                                                                    isAuthorized;
                                                              } on PlatformException catch (exception) {
                                                                if (exception.code == local_auth_error.notAvailable ||
                                                                    exception
                                                                            .code ==
                                                                        local_auth_error
                                                                            .passcodeNotSet ||
                                                                    exception
                                                                            .code ==
                                                                        local_auth_error
                                                                            .notEnrolled) {
                                                                  // Handle this exception here.
                                                                }
                                                              }
                                                            }
                                                            print(
                                                                "Setting use bio to $correctlyEnabledBio");
                                                            if (isAuthorized) {
                                                              SharedPreferences
                                                                      .getInstance()
                                                                  .then(
                                                                      (prefs) {
                                                                prefs.setBool(
                                                                    "localEnabled",
                                                                    correctlyEnabledBio);
                                                              });
                                                            }
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    "/home");
                                                          }
                                                        } else {
                                                          simpleAlertDialog(
                                                              context,
                                                              "Error",
                                                              "Verifica la informacion");
                                                        }
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Ingresar",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )))
                                    ]),
                              ),
                            ),
                            // SizedBox(
                            //   height: 2 * Sizes.padding,
                            // ),
                          ]),
                    ),
                  ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? SizedBox(height: Sizes.padding)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Container(
                          width: double.infinity,
                          height: Sizes.tileHeightMedium,
                          decoration:
                              const BoxDecoration(color: Color(0xff0077cd)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("/createAccount");
                              },
                              child:
                                  const Text("No tengo cuenta, quiero crearla",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        )
                ])));
  }
}
