import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/toasts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String documentId = "";
  String password = "";
  bool rememberMe = false;

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
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
            const Text("¡Bienvenido!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
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
                        child: TextField(
                          onChanged: (value) {
                            documentId = value;
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
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
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
                                  .pushNamed("/resetPassword01");
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
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.padding),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff7b8084),
                            borderRadius: BorderRadius.circular(Sizes.border),
                          ),
                          child: TextButton(
                              onPressed: () {
                                API
                                    .login(documentId, password)
                                    .then((BackendResponse myResponse) {
                                  if (myResponse.status == 200) {
                                    showToast("Login successful");
                                  } else {
                                    showToast("Login unsuccessful", type: 1);
                                  }
                                  print(myResponse.myBody);
                                });
                                Navigator.of(context).pushNamed("/home");
                              },
                              child: const Text(
                                "Ingresar",
                                style: TextStyle(
                                    color: Color(0xffb8b8b8), fontSize: 18),
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
