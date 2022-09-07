// Language: dart

import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/user/model/restauration.dart';
import 'package:credidiunsa_app/user/model/user.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

import '../model/documentType.dart';

class ResetPassword00Page extends StatefulWidget {
  const ResetPassword00Page({Key? key}) : super(key: key);

  @override
  _ResetPassword00PageState createState() => _ResetPassword00PageState();
}

class _ResetPassword00PageState extends State<ResetPassword00Page> {
  int? idIdentification;
  bool loading = false;
  bool canContinue = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Sizes.setSizes(_width, _height);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingresa la información",
                    style: TextStyle(
                      fontSize: Sizes.font8,
                    )),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                const Text("Tipo de documento",
                    style: TextStyle(color: Color(0xff0077cd))),
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
                  child: DropdownButton<int>(
                    value: idIdentification,
                    hint: const Text("Selecciona"),
                    underline: Container(),
                    isExpanded: true,
                    items: myDocumentTypes
                        .map((type) => DropdownMenuItem<int>(
                            value: type.id, child: Text(type.name)))
                        .toList(),
                    onChanged: (value) {
                      print("Set value to $value");
                      setState(() {
                        idIdentification = value;
                        canContinue = notLoggedDocument != "" &&
                            idIdentification != null &&
                            idIdentification != 0;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Número de documento",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    if (value.length != 13) {
                      return "El número de identificación debe contener al menos 13 dígitos";
                    }
                    return null;
                  },
                  maxLength: 13,
                  onChanged: (value) {
                    notLoggedDocument = value;
                    setState(() {
                      canContinue = notLoggedDocument != "" &&
                          idIdentification != null &&
                          idIdentification != 0;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      // counter: Container(),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            height: Sizes.boxSeparation,
          )),
          (!canContinue)
              ? Container()
              : loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
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
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            // TODO REMOVE ON PRODUCTION
                            if (notLoggedDocument == "ppppppppppppp") {
                              notLoggedDocument = "0828199100005";
                            }
                            API
                                .restaurationMethods(notLoggedDocument)
                                .then((res) {
                              setState(() {
                                loading = false;
                              });
                              if (res.idError == 0) {
                                myRestaurations = res.myBody["Lista"]
                                    .map<Restauration>((res) =>
                                        Restauration.fromBackendResponse(res))
                                    .toList();
                                Navigator.of(context)
                                    .pushNamed("/resetPassword01");
                              } else {
                                simpleAlertDialog(context, "Error",
                                    "No se encontró el documento introducido");
                              }
                            });
                          },
                          child: const Text(
                            "Continuar",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
          SizedBox(
            height: 3 * Sizes.boxSeparation,
          )
        ]),
      ),
    );
  }
}
