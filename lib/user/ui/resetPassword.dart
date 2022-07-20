import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String newPassword = "";
  String confirmPassword = "";
  bool min8charactersWarning = true;
  bool oneCapitalWarning = true;
  bool oneDigitWarning = true;
  bool differentPasswordsWarning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xffE8E8E8),
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            const Text("Restablecer",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            // SizedBox(
            //   height: Sizes.boxSeparation,
            // ),
            const Text("tus credenciales de ingreso",
                style: TextStyle(
                    color: Color(0xff0077CD),
                    fontWeight: FontWeight.normal,
                    fontSize: 18)),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            const Text(
              "Ingresa tu contraseña nueva",
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
              padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Sizes.border / 2),
              ),
              child: TextField(
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
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Escribe",
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    focusedBorder: null,
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
              padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Sizes.border / 2),
              ),
              child: TextField(
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {
                    differentPasswordsWarning = newPassword != confirmPassword;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Escribe",
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    focusedBorder: null,
                    disabledBorder: null),
              ),
            ),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            warningLabel("8 carácteres", min8charactersWarning),
            warningLabel("1 mayúscula", oneCapitalWarning),
            warningLabel("1 dígito", oneDigitWarning),
            warningLabel("Contraseñas no coinciden", differentPasswordsWarning,
                disappearWarning: true),
            Expanded(
              child: SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff7b8084),
                  borderRadius: BorderRadius.circular(Sizes.border),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    child: const Text(
                      "Actualizar contraseña",
                      style: TextStyle(color: Color(0xffb8b8b8), fontSize: 18),
                    ))),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            )
          ],
        ),
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

  Widget warningLabel(String label, bool activeWarning,
      {bool disappearWarning = false}) {
    return (disappearWarning && !activeWarning)
        ? Container()
        : Container(
            width: Sizes.width,
            height: Sizes.height / 20,
            padding: EdgeInsets.only(bottom: Sizes.boxSeparation),
            child: Row(
              children: [
                Icon(
                  activeWarning ? Icons.warning_rounded : Icons.check_circle,
                  color: activeWarning ? Colors.red : const Color(0xff4DB21C),
                ),
                SizedBox(
                  width: Sizes.boxSeparation,
                ),
                Text(label,
                    style: TextStyle(
                        color: activeWarning
                            ? Colors.red
                            : const Color(0xff4DB21C),
                        fontSize: 18)),
              ],
            ),
          );
  }
}
