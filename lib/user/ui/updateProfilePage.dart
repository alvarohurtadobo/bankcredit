import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/model/regEx.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';

class UpdateProfilePage extends StatefulWidget {
  final int type;
  const UpdateProfilePage({Key? key, this.type = 0}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  bool changed = false;

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
                  height: Sizes.boxSeparation,
                ),
                widget.type == 0
                    ? SizedBox(
                        width: Sizes.width,
                        height: Sizes.height / 20,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 4.5,
                            ),
                            Icon(
                              Icons.email_outlined,
                              color: Color(0xff0F62A4),
                            ),
                            Text("Correo Electrónico",
                                style: TextStyle(
                                  color: Color(0xff0077cd),
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: Sizes.width,
                        height: Sizes.height / 20,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.smartphone,
                              color: Color(0xff0F62A4),
                            ),
                            Text("Teléfono",
                                style: TextStyle(
                                  color: Color(0xff0077cd),
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                widget.type == 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        child: TextFormField(
                          controller: emailController,
                          onChanged: (text) {
                            updateParam = text;
                            setState(() {
                              changed = text != currentUser.email;
                            });
                          },
                          validator: (value) {
                            if (!isGoodEmail(value ?? "")) {
                              return "Introduzca un correo válido";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xffB3B3B3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xff0077CD)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: null),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.boxSeparation),
                        child: TextFormField(
                          maxLength: 10,
                          controller: phoneController,
                          onChanged: (text) {
                            updateParam = text;
                            print("updated update param to $updateParam");
                            setState(() {
                              changed = text != currentUser.phone;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            try {
                              int.parse(value);
                            } catch (error) {
                              return "Introduzca un número válido";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xffB3B3B3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xff0077CD)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: null),
                        ),
                      ),
                const Expanded(
                    child: SizedBox(
                  height: 0,
                )),
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
                          color: changed
                              ? const Color(0xff0077CD)
                              : const Color(0xff7A8084),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (!changed) {
                                return;
                              }
                              if (isLoading) {
                                return;
                              }

                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                constantParam = widget.type == 1
                                    ? emailController.text
                                    : phoneController.text;
                                API
                                    .generateOTPForUpdate(constantParam,
                                        type: (widget.type + 1) % 2)
                                    .then((res) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (res.idError == 0) {
                                    if (widget.type == 0) {
                                      Navigator.of(context)
                                          .pushNamed("/validateEmailUpdate");
                                    } else {
                                      Navigator.of(context)
                                          .pushNamed("/validatePhoneUpdate");
                                    }
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
                              }
                            },
                            child: const Text(
                              "Modificar Información",
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
