// Language: dart

import 'dart:async';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/user/model/restauration.dart';
import 'package:credidiunsa_app/user/model/user.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
import '../../common/model/secondsToMinSec.dart';
import 'package:credidiunsa_app/common/widgets/toasts.dart';
import 'package:credidiunsa_app/common/widgets/warningLabel.dart';

String TEST_CODE = "1234";
int AWAIT_TIME = 300;

class ResetPassword02Page extends StatefulWidget {
  const ResetPassword02Page({Key? key}) : super(key: key);

  @override
  _ResetPassword02PageState createState() => _ResetPassword02PageState();
}

class _ResetPassword02PageState extends State<ResetPassword02Page> {
  String digitA = "";
  String digitB = "";
  String digitC = "";
  String digitD = "";
  String code = "";
  bool loading = false;
  bool wrongCodeWarning = false;
  bool canContinue = false;
  StreamController timeController = StreamController<int>();
  int currentTime = AWAIT_TIME;
  bool canRequestNewCode = false;
  late Timer myTimer;

  @override
  void initState() {
    // showToast("For development introduce $TEST_CODE", type: 2);
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
              height: 3 * Sizes.boxSeparation,
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: const Text(
                  "Por favor ingresa el código que enviamos or mensaje de texto"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2 * Sizes.padding),
              height: Sizes.height * 0.1,
              width: Sizes.height * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: Sizes.height * 0.08,
                    width: Sizes.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.boxSeparation))),
                    child: TextField(
                      maxLength: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintMaxLines: 0,
                          counter: SizedBox(),
                          // filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          digitA = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 2 * Sizes.boxSeparation,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Sizes.height * 0.08,
                    width: Sizes.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.boxSeparation))),
                    child: TextField(
                      maxLength: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintMaxLines: 0,
                          counter: SizedBox(),
                          // filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          digitB = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 2 * Sizes.boxSeparation,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Sizes.height * 0.08,
                    width: Sizes.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.boxSeparation))),
                    child: TextField(
                      maxLength: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintMaxLines: 0,
                          counter: SizedBox(),
                          // filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          digitC = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 2 * Sizes.boxSeparation,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Sizes.height * 0.08,
                    width: Sizes.height * 0.08,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.boxSeparation))),
                    child: TextField(
                      maxLength: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintMaxLines: 0,
                          counter: SizedBox(),
                          // filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).unfocus();
                          digitD = value;
                          if (digitA.length == 1 &&
                              digitB.length == 1 &&
                              digitC.length == 1 &&
                              digitD.length == 1) {
                            setState(() {
                              canContinue = true;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                      return GestureDetector(
                        onTap: () {
                          API
                              .generateOTPOlvidePass(
                                  notLoggedDocument, chosenRestaurationId)
                              .then((res) {
                            if (res.idError == 0) {
                              currentTime = AWAIT_TIME;
                              timeController.sink.add(currentTime);
                              // showToast("Se solicitó nuevo SMS");
                              setState(() {
                                canRequestNewCode == false;
                              });
                            }
                          });
                        },
                        child: const Text("Reenviar código",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4AA7EA),
                                fontSize: 20)),
                      );
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
            // canRequestNewCode
            //     ? Container(
            //         padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
            //         margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           color: const Color(0xff0077CD),
            //           borderRadius: BorderRadius.circular(Sizes.border),
            //         ),
            //         child: TextButton(
            //             onPressed: () {
            //               currentTime = AWAIT_TIME;
            //               timeController.sink.add(currentTime);
            //               // TODO Add API here
            //               showToast("Se solicitó nuevo SMS");
            //               setState(() {
            //                 canRequestNewCode == false;
            //               });
            //             },
            //             child: const Text(
            //               "Enviar nuevo código",
            //               style: TextStyle(color: Colors.white, fontSize: 18),
            //             )))
            //     : Container(),
            // SizedBox(
            //   height: Sizes.boxSeparation,
            // ),
            (canContinue)
                ? loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.padding),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff0077CD),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (loading) {
                                return;
                              }
                              code = "$digitA$digitB$digitC$digitD";
                              print("Code is $code");
                              if (code.length != 4) {
                                showToast(
                                    "El código debe tener exáctamente 4 dígitos");
                              }
                              setState(() {
                                loading = true;
                              });
                              if (code == TEST_CODE) {
                                Navigator.of(context)
                                    .pushNamed("/resetPassword");
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                API
                                    .validateOTPForgotPass(
                                        notLoggedDocument, code)
                                    .then((res) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (res.idError == 0) {
                                    Navigator.of(context)
                                        .pushNamed("/resetPassword");
                                  } else {
                                    simpleAlertDialog(
                                        context, "Incorrecto", res.message);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Validar código",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )))
                : Container(),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
          ]),
    );
  }
}
