// Language: dart

import 'dart:async';
import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../common/model/secondsToMinSec.dart';
import 'package:credidiunsa_app/common/widgets/toasts.dart';
import 'package:credidiunsa_app/common/widgets/warningLabel.dart';

String TEST_CODE = "1234";
int AWAIT_TIME = 6;

class ResetPassword02Page extends StatefulWidget {
  const ResetPassword02Page({Key? key}) : super(key: key);

  @override
  _ResetPassword02PageState createState() => _ResetPassword02PageState();
}

class _ResetPassword02PageState extends State<ResetPassword02Page> {
  String currentCode = "";
  bool wrongCodeWarning = false;
  bool canContinue = false;
  StreamController timeController = StreamController<int>();
  int currentTime = AWAIT_TIME;
  bool canRequestNewCode = false;
  late Timer myTimer;

  @override
  void initState() {
    showToast("For development introduce $TEST_CODE", type: 2);
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime > 0) {
        currentTime--;
        timeController.sink.add(currentTime);
      }
      if (!canRequestNewCode && currentTime == 0) {
        setState(() {
          canRequestNewCode = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timeController.close();
    myTimer.cancel();
    super.dispose();
    timeController.sink.add(currentTime);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              height: Sizes.boxSeparation,
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: const Text(
                  "Por favor ingresa el código que enviamos or mensaje de texto"),
            ),
            Padding(
                padding: EdgeInsets.all(Sizes.padding),
                child: PinFieldAutoFill(
                    // decoration: // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
                    // currentCode: // prefill with a code
                    onCodeSubmitted: (value) {
                      print("SUBMIT");
                      setState(() {
                        wrongCodeWarning = currentCode != TEST_CODE;
                      });
                      if (currentCode == TEST_CODE) {
                        Navigator.of(context).pushNamed("/resetPassword");
                      } else {}
                    }, //code submitted callback
                    onCodeChanged: (value) {
                      if (value != null && value != "") {
                        currentCode = value;
                        if (currentCode.length == 4) {
                          setState(() {
                            canContinue = true;
                          });
                        }
                      }
                      print("Current value is: $currentCode");
                    }, //code changed callback
                    codeLength: 4 //code length, default 6
                    )),
            SizedBox(
              height: 1 * Sizes.boxSeparation,
            ),
            warningLabel(
                "¡El código ingresado no es correcto!", wrongCodeWarning,
                disappearWarning: true),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            StreamBuilder<dynamic>(
                stream: timeController.stream,
                builder: (context, snapshop) {
                  if (snapshop.hasData) {
                    int newTime = snapshop.data ?? 0;
                    if (newTime == 0) {
                      return const Text("Reenviar",
                          style: TextStyle(
                              color: Color(0xffA3A8AC), fontSize: 20));
                    } else {
                      return Text("Reenviar en ${convertToSecMin(newTime)}",
                          style: const TextStyle(
                              color: Color(0xffA3A8AC), fontSize: 20));
                    }
                  }
                  return Container();
                }),
            Expanded(
              child: SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
            ),
            canRequestNewCode
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff0077CD),
                      borderRadius: BorderRadius.circular(Sizes.border),
                    ),
                    child: TextButton(
                        onPressed: () {
                          currentTime = AWAIT_TIME;
                          timeController.sink.add(currentTime);
                          // TODO Add API here
                          showToast("Se solicitó nuevo SMS");
                          setState(() {
                            canRequestNewCode == false;
                          });
                        },
                        child: const Text(
                          "Enviar nuevo código",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
                : Container(),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            (canContinue)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff0077CD),
                      borderRadius: BorderRadius.circular(Sizes.border),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/resetPassword");
                        },
                        child: const Text(
                          "Validar código",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
                : Container(),
            SizedBox(
              height: 1 * Sizes.boxSeparation,
            ),
          ]),
    );
  }
}
