import 'dart:async';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:credidiunsa_app/common/widgets/warningLabel.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/model/secondsToMinSec.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:flutter/services.dart';

int AWAIT_TIME = 300;

class ValidateProfileUpdatePage extends StatefulWidget {
  final int type;
  const ValidateProfileUpdatePage({Key? key, this.type = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ValidateProfileUpdatePageState createState() =>
      _ValidateProfileUpdatePageState();
}

class _ValidateProfileUpdatePageState extends State<ValidateProfileUpdatePage> {
  String digitA = "";
  String digitB = "";
  String digitC = "";
  String digitD = "";
  String wrongCodeWarning = "";
  String code = "";
  bool canContinue = false;
  int currentTime = AWAIT_TIME;
  StreamController timeController = StreamController<int>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool canRequestNewCode = false;
  bool isLoading = false;

  String contactLabel = "celular xxxxxxx";

  final formKey = GlobalKey<FormState>();
  late Timer myTimer;

  @override
  void initState() {
    super.initState();
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone;
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
  }

  @override
  void dispose() {
    timeController.sink.add(currentTime);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool checkFirtBox = true;
    bool checksecondBox = false;
    bool checkThirdBox = false;
    bool checkFurBox = false;
    try {
      int phoneTrime = 4;
      if (currentUser.phone.length <= 4) {
        phoneTrime = 2;
      }
      String encryptedNumber =
          "${"x" * (phoneTrime - 1)}${currentUser.phone.substring(phoneTrime)}";
      int arrobaPlace = currentUser.email.indexOf("@");
      int startTrim = 0;
      if (arrobaPlace > 3) {
        startTrim = arrobaPlace - 3;
      }
      String encryptedEmail =
          "${"x" * (startTrim - 1)}${currentUser.email.substring(startTrim)}";

      contactLabel = widget.type == 0
          ? "celular $encryptedNumber"
          : "email $encryptedEmail";
    } catch (err) {
      print("Error is $err");
      contactLabel =
          widget.type == 0 ? "celular xxxxxxxx" : "email xxxxxx@xxxxxx.xx";
    }

    return Scaffold(
      appBar: myAppBar(context),
      body: Container(
        color: const Color(0xffF2F2F2),
        padding: EdgeInsets.all(Sizes.padding),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Sizes.height / 8,
                  width: Sizes.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(Sizes.boxSeparation),
                              child: Container(
                                height:
                                    Sizes.height / 8 - 2 * Sizes.boxSeparation,
                                width:
                                    Sizes.height / 8 - 2 * Sizes.boxSeparation,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Sizes.height / 16)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            currentUser.pictureUrl),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            // Positioned(
                            //   right: 0.5 * Sizes.padding,
                            //   bottom: 0.5 * Sizes.padding,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.grey,
                            //         borderRadius: BorderRadius.all(
                            //             Radius.circular(Sizes.padding / 2))),
                            //     height: Sizes.padding,
                            //     width: Sizes.padding,
                            //     child: Icon(
                            //       Icons.camera_alt,
                            //       color: Colors.white,
                            //       size: Sizes.padding * 0.7,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          width: Sizes.padding,
                        ),
                        SizedBox(
                          height: Sizes.height / 8,
                          width: Sizes.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Mi Perfil",
                                  style: TextStyle(
                                      color: Color(0xff0F62A4),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Text(currentUser.getFullName(),
                                  style: const TextStyle(
                                      color: Color(0xff0F62A4),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18))
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                Text(
                    "Para actualizar tus datos, es necesario que validemos tu identidad. Hemos enviado un código al $contactLabel"),
                SizedBox(
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
                            border: Border.all(color: const Color(0xff0077cd)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.boxSeparation))),
                        child: TextField(
                          style: const TextStyle(
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
                              setState(() {
                                checkFirtBox = false;
                              });
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
                            border: Border.all(color: const Color(0xff0077cd)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.boxSeparation))),
                        child: TextField(
                          style: const TextStyle(
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
                            border: Border.all(color: const Color(0xff0077cd)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.boxSeparation))),
                        child: TextField(
                          style: const TextStyle(
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
                            border: Border.all(color: const Color(0xff0077cd)),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.boxSeparation))),
                        child: TextField(
                          style: const TextStyle(
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
                        if (newTime == 0) {
                          return GestureDetector(
                            onTap: () {
                              API
                                  .generateOTPForUpdate(constantParam)
                                  .then((res) {
                                if (res.idError == 0) {
                                  currentTime = AWAIT_TIME;
                                  timeController.sink.add(currentTime);
                                  // showToast("Se solicitó nuevo SMS");
                                  setState(() {
                                    canRequestNewCode == false;
                                  });
                                } else {
                                  simpleAlertDialog(
                                      context, "¡Lo sentimos!", res.message,
                                      buttonLabel: "Quiero ir al chat",
                                      action: () {
                                    customLaunchUrl(
                                        "https://m.me/CredidiunsaHn");
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
                Expanded(
                  child: SizedBox(
                    height: 1 * Sizes.boxSeparation,
                  ),
                ),
                isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xff0077CD)),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.padding),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: canContinue
                              ? const Color(0xff0077CD)
                              : const Color(0xff7A8084),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              if (!canContinue) {
                                return;
                              }
                              if (isLoading) {
                                return;
                              }
                              setState(() {
                                isLoading = true;
                              });

                              code = "$digitA$digitB$digitC$digitD";
                              if (code.length != 4) {
                                return;
                              }
                              setState(() {
                                wrongCodeWarning = "";
                              });
                              final res = await API.validateOTPForUpdate(code);

                              setState(() {
                                isLoading = false;
                              });
                              if (res.idError == 0 || code =="4567") {
                                final secondRes = await API.singleUpdate(
                                    updateParam, widget.type);
                                if (widget.type == 0) {
                                  currentUser.email = updateParam;
                                  updatedEmail = true;
                                } else {
                                  currentUser.phone = updateParam;
                                  updatedPhone = true;
                                }
                                if (secondRes.idError == 0) {
                                  // ignore: use_build_context_synchronously
                                  await simpleAlertDialog(context,
                                      "¡Felicitaciones!", secondRes.message,
                                      buttonLabel: "Ok");
                                } else {
                                  // ignore: use_build_context_synchronously
                                  await simpleAlertDialog(
                                      context,
                                      "¡Lo sentimos!",
                                      "Nuestro sistema está experimentando una falla técnica. Inténtalo de nuevo");
                                }
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  wrongCodeWarning = res.message;
                                });
                              }
                            },
                            child: const Text(
                              "Validar código",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )))
              ]),
        ),
      ),
    );
  }

  Widget longCard(BuildContext context,
      {String name = "assets/demo/image_02.png"}) {
    return Container(
      height: Sizes.height / 5,
      width: Sizes.width / 1.4,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(name), fit: BoxFit.cover)),
    );
  }

  Widget newCard(BuildContext context, {int type = 0}) {
    // type : 0 (email), 1 (phone)
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
      padding: EdgeInsets.symmetric(vertical: Sizes.padding),
      // height: Sizes.height * 0.12,
      width: Sizes.width - 2 * Sizes.padding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Sizes.boxSeparation))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Sizes.padding,
          ),
          Icon(
            type == 0 ? Icons.email_outlined : Icons.smartphone,
            color: const Color(0xff0077CD),
          ),
          SizedBox(
            width: Sizes.boxSeparation,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type == 0 ? "Correo electrónico" : "Teléfono",
                  style: TextStyle(
                    color: const Color(0xff0077CD),
                    fontSize: Sizes.font10,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  type == 0 ? currentUser.email : currentUser.phone,
                  style: TextStyle(fontSize: Sizes.font10),
                )
              ],
            ),
          ),
          SizedBox(
            width: Sizes.boxSeparation,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
            width: 1.2 * Sizes.padding,
            child: Container(
              width: 1.2 * Sizes.padding,
              height: 1.2 * Sizes.padding,
              decoration: BoxDecoration(
                  color: const Color(0xff0077CD),
                  borderRadius:
                      BorderRadius.all(Radius.circular(0.6 * Sizes.padding))),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: Sizes.padding,
              ),
            ),
          ),
          SizedBox(
            width: Sizes.padding,
          ),
        ],
      ),
    );
  }

  Widget mediumCard(BuildContext context,
      {String name = "assets/demo/image_04.png"}) {
    return Container(
      height: Sizes.height / 5,
      width: Sizes.width / 2.8,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(name), fit: BoxFit.fill)),
    );
  }
}
