// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';

import '../../common/widgets/grayWarningLabel.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String newPassword = "";
  String confirmPassword = "";
  bool obscure1 = true;
  bool obscure2 = true;
  bool min8charactersWarning = true;
  bool oneCapitalWarning = true;
  bool oneDigitWarning = true;
  bool differentPasswordsWarning = false;
  bool canContinue = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: Sizes.height * 0.18,
            padding: EdgeInsets.all(Sizes.padding),
            decoration: BoxDecoration(
                color: const Color(0xff0077cd),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.border),
                    bottomRight: Radius.circular(Sizes.border))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Restablecer",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text("tus credenciales de ingreso",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            height: 5 * Sizes.boxSeparation,
          ),
          Container(
            width: double.infinity,
            height: Sizes.height * 0.82 - 8 * Sizes.boxSeparation,
            padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    bool confirm = true;
                    // print("Appbar back $confirm");
                    if (confirm) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 1.5 * Sizes.padding,
                    width: 1.5 * Sizes.padding,
                    decoration: BoxDecoration(
                        color: const Color(0xff0077CD),
                        borderRadius: BorderRadius.all(
                            Radius.circular(1.5 * Sizes.padding / 2))),
                    child: Icon(
                      Icons.arrow_back,
                      size: 1.5 * Sizes.padding,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5 * Sizes.boxSeparation,
                ),
                const Text(
                  "Ingresa tu nueva contraseña",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 5 * Sizes.boxSeparation,
                ),
                const Text("Nueva contraseña",
                    style: TextStyle(color: Color(0xff0077cd), fontSize: 16)),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Sizes.border / 2),
                  ),
                  child: TextField(
                    obscureText: obscure1,
                    onChanged: (value) {
                      newPassword = value;
                      setState(() {
                        min8charactersWarning = newPassword.length < 8;
                        oneCapitalWarning =
                            newPassword == newPassword.toUpperCase() ||
                                newPassword == newPassword.toLowerCase();
                        oneDigitWarning = newPassword ==
                            newPassword
                                .replaceAll("0", "")
                                .replaceAll("1", "")
                                .replaceAll("2", "")
                                .replaceAll("3", "")
                                .replaceAll("4", "")
                                .replaceAll("5", "")
                                .replaceAll("6", "")
                                .replaceAll("7", "")
                                .replaceAll("8", "")
                                .replaceAll("9", "");
                        differentPasswordsWarning =
                            newPassword != confirmPassword;
                        canContinue = !differentPasswordsWarning &&
                            !min8charactersWarning &&
                            !oneCapitalWarning &&
                            !oneDigitWarning;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure1 = !obscure1;
                            });
                          },
                          child: obscure1
                              ? Image.asset("assets/icons/obscured.png")
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: Color.fromARGB(255, 138, 138, 138),
                                ),
                        ),
                        border: InputBorder.none,
                        hintText: "Escribe",
                        // hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xff0077CD)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        disabledBorder: null),
                  ),
                ),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                const Text("Confirma tu contraseña",
                    style: TextStyle(color: Color(0xff0077cd), fontSize: 16)),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Sizes.border / 2),
                  ),
                  child: TextField(
                    obscureText: obscure2,
                    onChanged: (value) {
                      confirmPassword = value;
                      if (newPassword == confirmPassword) {
                        FocusScope.of(context).unfocus();
                      }
                      setState(() {
                        differentPasswordsWarning =
                            newPassword != confirmPassword;
                        canContinue = !differentPasswordsWarning &&
                            !min8charactersWarning &&
                            !oneCapitalWarning &&
                            !oneDigitWarning;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure2 = !obscure2;
                            });
                          },
                          child: obscure2
                              ? Image.asset("assets/icons/obscured.png")
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: Color.fromARGB(255, 138, 138, 138),
                                ),
                        ),
                        border: InputBorder.none,
                        hintText: "Escribe",
                        // hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Color(0xff0077CD)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        disabledBorder: null),
                  ),
                ),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                grayWarningLabel(
                  "8 carácteres",
                  min8charactersWarning,
                ),
                grayWarningLabel("1 mayúscula", oneCapitalWarning),
                grayWarningLabel("1 dígito", oneDigitWarning),
                grayWarningLabel(
                    "Contraseñas no coinciden", differentPasswordsWarning,
                    disappearWarning: true),
                Expanded(
                  child: SizedBox(
                    height: 3 * Sizes.boxSeparation,
                  ),
                ),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.padding),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: canContinue
                              ? const Color(0xff0077CD)
                              : const Color(0xff7b8084),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (!canContinue) {
                                return;
                              }
                              if (loading) {
                                return;
                              }
                              setState(() {
                                loading = true;
                              });
                              API
                                  .resetPassword(notLoggedDocument, newPassword)
                                  .then((res) {
                                setState(() {
                                  loading = false;
                                });
                                if (res.idError == 0) {
                                  simpleAlertDialog(context, "¡Felicitaciones!",
                                          "Tus credenciales se han restablecido con éxito.",
                                          buttonLabel: "Ingresar")
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                  // showToast("Contraseña actualizada correctamente",
                                  //     type: 0);
                                } else {
                                  // showToast("No se pudo actualizar", type: 1);
                                  simpleAlertDialog(
                                      context, "¡Lo sentimos!", res.message);
                                }
                              });
                            },
                            child: const Text(
                              "Actualizar contraseña",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))),
              ],
            ),
          ),
          SizedBox(
            height: 3 * Sizes.boxSeparation,
          )
        ],
      ),
    );
  }

  Widget paymentButton(BuildContext context, String name) {
    return Container(
      margin: EdgeInsets.all(Sizes.padding / 2),
      height: Sizes.height / 10,
      width: Sizes.width / 3.2,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/demo/$name"))),
    );
  }
}
