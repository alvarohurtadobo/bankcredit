// Language: dart

// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'package:flutter/services.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
import '../../common/model/secondsToMinSec.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/user/model/restauration.dart';
import 'package:credidiunsa_app/common/widgets/warningLabel.dart';

int AWAIT_TIME = 180;

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
  String wrongCodeWarning = "";
  bool canContinue = false;
  StreamController timeController = StreamController<int>();
  int currentTime = AWAIT_TIME;
  bool canRequestNewCode = false;
  late Timer myTimer;
  int initialTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  void initState() {
    initialTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      currentTime = AWAIT_TIME - (currentTimestamp - initialTimestamp);
      if (currentTime >= 0) {
        timeController.sink.add(currentTime);
      } else {
        timeController.sink.add(0);
        if (!canRequestNewCode) {
          setState(() {
            canRequestNewCode = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timeController.close();
    myTimer.cancel();
    super.dispose();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(Sizes.padding),
                    child: GestureDetector(
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
                    )),
                Padding(
                  padding: EdgeInsets.all(Sizes.padding),
                  child: const Text(
                      "  Por favor ingresa el código que enviamos por mensaje de texto  "),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2 * Sizes.padding),
              height: Sizes.height * 0.1,
              width: Sizes.height * 0.8,
              child: Column(children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: Sizes.height * 0.08,
                          width: Sizes.height * 0.08,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 35,
                              color: Color(0xff0077cd),
                            ),
                            maxLength: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xff0077cd)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintMaxLines: 0,
                                counter: const SizedBox(),
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
                            style: const TextStyle(
                              fontSize: 35,
                              color: Color(0xff0077cd),
                            ),
                            maxLength: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xff0077CD)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintMaxLines: 0,
                                counter: const SizedBox(),
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
                            style: const TextStyle(
                              fontSize: 35,
                              color: Color(0xff0077cd),
                            ),
                            maxLength: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xff0077CD)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintMaxLines: 0,
                                counter: const SizedBox(),
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
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.boxSeparation))),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 35,
                              color: Color(0xff0077cd),
                            ),
                            maxLength: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xff0077CD)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintMaxLines: 0,
                                counter: const SizedBox(),
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
                    Positioned(
                      top: Sizes.height * 0.08 - 8,
                      child: Container(
                          height: Sizes.height * 0.019,
                          width: Sizes.height,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 250, 250, 250))),
                    )
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: 1 * Sizes.boxSeparation,
            ),
            Container(
              padding: EdgeInsets.all(Sizes.padding),
              alignment: Alignment.center,
              child: warningLabel(wrongCodeWarning, wrongCodeWarning != "",
                  disappearWarning: true, center: true),
            ),
            SizedBox(
              height: 3 * Sizes.boxSeparation,
            ),
            StreamBuilder<dynamic>(
                stream: timeController.stream,
                builder: (context, snapshop) {
                  if (snapshop.hasData) {
                    int newTime = snapshop.data ?? 0;
                    
                    if (newTime <= 0) {
                      return GestureDetector(
                        onTap: () {
                          API
                              .generateOTPOlvidePass(
                                  notLoggedDocument, chosenRestaurationId)
                              .then((res) {
                            if (res.idError == 0) {
                              initialTimestamp =
                                  DateTime.now().millisecondsSinceEpoch ~/ 1000;
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
            // ignore: todo
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
                                return;
                              }
                              setState(() {
                                wrongCodeWarning = "";
                              });
                              setState(() {
                                loading = true;
                              });
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
                                  setState(() {
                                    wrongCodeWarning = res.message;
                                  });
                                }
                              });
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
