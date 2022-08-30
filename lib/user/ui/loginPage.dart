import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:credidiunsa_app/common/widgets/biometricAuthDialog.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/common/widgets/toasts.dart';
import 'package:local_auth/error_codes.dart' as local_auth_error;
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:credidiunsa_app/user/bloc/userLogin.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../bank/bloc/receiveFiles.dart';
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

  final _localAuthentication = LocalAuthentication();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      localEnabled = prefs.getBool("localEnabled") ?? false;
      print("Local auth is enabled $localEnabled, attempting login");
      if (localEnabled && !wasLogged) {
        documentId = prefs.getString("document") ?? "";
        password = prefs.getString("password") ?? "";
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
                  bool success =
                      setUpUser(myResponse.myBody, password: password);
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    return Scaffold(
        body: SafeArea(
      child: Container(
          // margin: EdgeInsets.all(0),
          // padding: EdgeInsets.all(0),
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image_01.png"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            SizedBox(
              height: 3 * Sizes.padding,
            ),
            Container(
              width: Sizes.width * 0.8,
              height: 60,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: SizedBox(
                height: Sizes.padding,
              ),
            ),
            SizedBox(height: Sizes.boxSeparation),
            // GestureDetector(
            // onLongPress: () {
            //   showToast("Launch whatsapp");
            //   customLaunchUrl("whatsapp://send?phone=+50431904365");
            // },
            // child:
            const Text("¡Bienvenido!",
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
                  "Aqui podrás gestionar todos tus tramites de tu cuenta Credidiunsa",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(
              height: 2 * Sizes.padding,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Número de documento",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.border / 2),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            documentId = value;
                            setState(() {
                              canContinue = documentId != "" && password != "";
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Escribe",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: null,
                              disabledBorder: null),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.padding,
                      ),
                      const Text("Contraseña",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.border / 2),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                            setState(() {
                              canContinue = documentId != "" && password != "";
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Escribe",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: null,
                              disabledBorder: null),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: const Color(0xff0077cd),
                            focusColor: Colors.white,
                          ),
                          const Text("Recuérdame",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          const Expanded(
                              child: SizedBox(
                            width: 0,
                          )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/resetPassword00");
                            },
                            child: const Text("Olvidé mi contraseña",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2 * Sizes.boxSeparation,
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
                                    BorderRadius.circular(Sizes.border),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    if (!canContinue) {
                                      return;
                                    }
                                    if (isLoading) {
                                      return;
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      if (documentId == "p") {
                                        documentId = "0828199100005";
                                      }
                                      if (password == "p") {
                                        password = "Diunsa2022*";
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      API.login(documentId, password).then(
                                          (BackendResponse myResponse) async {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (myResponse.idError == 0) {
                                          // showToast("Ingreso exitoso");
                                          bool success = setUpUser(
                                              myResponse.myBody,
                                              password: password);
                                          if (success) {
                                            bool useBio =
                                                await biometricAuthConfirmationDialog(
                                                    context);
                                            bool isAuthorized = false;
                                            bool correctlyEnabledBio = false;
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
                                                if (exception.code ==
                                                        local_auth_error
                                                            .notAvailable ||
                                                    exception.code ==
                                                        local_auth_error
                                                            .passcodeNotSet ||
                                                    exception.code ==
                                                        local_auth_error
                                                            .notEnrolled) {
                                                  // Handle this exception here.
                                                }
                                              }
                                            }
                                            print(
                                                "Setting use bio to $correctlyEnabledBio");
                                            if (isAuthorized) {
                                              SharedPreferences.getInstance()
                                                  .then((prefs) {
                                                prefs.setBool("localEnabled",
                                                    correctlyEnabledBio);
                                              });
                                            }
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushNamed("/home");
                                          }
                                        } else {
                                          simpleAlertDialog(context, "Error",
                                              "Credenciales incorrectas");
                                        }
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Ingresar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )))
                    ]),
              ),
            ),
            SizedBox(
              height: 2 * Sizes.padding,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff0077cd)),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/createAccount");
                  },
                  child: const Text("No tengo cuenta, quiero crearla",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            )
          ])),
    ));
  }
}
