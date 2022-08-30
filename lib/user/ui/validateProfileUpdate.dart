import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

String TEST_CODE = "1234";

class ValidateProfileUpdatePage extends StatefulWidget {
  final int type;
  const ValidateProfileUpdatePage({Key? key, this.type = 0}) : super(key: key);

  @override
  _ValidateProfileUpdatePageState createState() =>
      _ValidateProfileUpdatePageState();
}

class _ValidateProfileUpdatePageState extends State<ValidateProfileUpdatePage> {
  String digitA = "";
  String digitB = "";
  String digitC = "";
  String digitD = "";
  String code = "";
  bool canContinue = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = currentUser.email;
    phoneController.text = currentUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar(context),
      body: Container(
        color: const Color(0xffF2F2F2),
        padding: EdgeInsets.all(Sizes.padding),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text(
                    "Para actualizar tus datos, es necesario que validemos tu identidad. Te hemos enviado un código"),
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
                              final res = await API.validateOTPForUpdate(code);

                              setState(() {
                                isLoading = false;
                              });
                              if (res.idError == 0) {
                                final secondRes = await API.singleUpdate(
                                    updateParam, widget.type);
                                if (secondRes.idError == 0) {
                                  await simpleAlertDialog(
                                      context,
                                      "Felicitaciones",
                                      "Tus datos personales han sido modificados con éxito");
                                } else {
                                  await simpleAlertDialog(
                                      context,
                                      "¡Lo sentimos!",
                                      "Nuestro sistema está experimentando una falla técnica. Inténtalo de nuevo");
                                }
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else {
                                await simpleAlertDialog(
                                    context, "Error", res.message);
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
