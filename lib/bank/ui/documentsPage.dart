// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/bank/bloc/receiveFiles.dart';
import 'package:credidiunsa_app/bank/bloc/getCities.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import '../model/city.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  _DocumentsPageState createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  TextEditingController titleControl = TextEditingController();
  int currentType = -1;
  String instituteName = "";
  int? cityId;
  bool isLoading = false;
  bool ready = false;
  bool warningIdDocument = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getCities().then((value) {
      print("Received ${myCities.length} cities in init");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xffE8E8E8),
        // padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: Sizes.padding * 1.2,
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: Sizes.padding * 1.2,
                    width: Sizes.padding * 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(0.6 * Sizes.padding)),
                        color: Colors.white),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff0077CD),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                child: const Text("Documentos",
                    style: TextStyle(
                        color: Color(0xff0077CD),
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ),
              SizedBox(
                height: Sizes.padding,
              ),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              carousel(),
              SizedBox(
                height: 4 * Sizes.boxSeparation,
              ),
              currentType >= 1 ? form() : Container(),
              Expanded(
                child: SizedBox(
                  height: 5 * Sizes.boxSeparation,
                ),
              ),
              isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff0077CD)),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ready
                            ? const Color(0xff0077CD)
                            : const Color(0xff7A8084),
                        borderRadius: BorderRadius.circular(Sizes.border),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (isLoading) {
                              return;
                            }
                            if (!ready) {
                              _formKey.currentState!.validate();
                              setState(() {
                                warningIdDocument =
                                    cityId == null || cityId == 0;
                              });
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            switch (currentType) {
                              case 0:
                                API.getAccountStatus().then((myResponse) {
                                  if (myResponse.idError == 0) {
                                    displayFile(myResponse);
                                  } else {
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                        myResponse.message);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                break;
                              case 1:
                                API
                                    .getConstanciaSaldo(instituteName, cityId!)
                                    .then((myResponse) {
                                  if (myResponse.idError == 0) {
                                    displayFile(myResponse);
                                  } else {
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                        myResponse.message);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                break;
                              case 2:
                                API
                                    .getReferenciaCredito(
                                        instituteName, cityId!)
                                    .then((myResponse) {
                                  if (myResponse.idError == 0) {
                                    displayFile(myResponse);
                                  } else {
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                        myResponse.message);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                break;
                              case 3:
                                API
                                    .getConsolidacionDeuda(
                                        instituteName, cityId!)
                                    .then((myResponse) {
                                  if (myResponse.idError == 0) {
                                    displayFile(myResponse);
                                  } else {
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                        myResponse.message);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                break;
                              default:
                                API.getAccountStatus().then((myResponse) {
                                  if (myResponse.idError == 0) {
                                    displayFile(myResponse);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                        myResponse.message);
                                  }
                                });
                            }
                          },
                          child: const Text(
                            "Generar documento",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
              SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Institución a la que va dirigido",
              style: TextStyle(color: Color(0xff0077cd))),
          SizedBox(
            height: Sizes.boxSeparation,
          ),
          TextFormField(
            controller: titleControl,
            validator: (value) {
              if (value!.isEmpty) {
                return "¡Este campo es obligatorio!";
              }
              return null;
            },
            onChanged: (newName) {
              instituteName = newName;
              print("Set new name to $instituteName");
              setState(() {
                ready =
                    (instituteName != "") && (cityId != null) && (cityId != -1);
              });
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: "",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff0077CD)),
                  borderRadius: BorderRadius.circular(4),
                ),
                disabledBorder: null),
          ),
          SizedBox(
            height: 1.5 * Sizes.boxSeparation,
          ),
          const Text("Ciudad", style: TextStyle(color: Color(0xff0077cd))),
          SizedBox(
            height: Sizes.boxSeparation,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.border / 2),
            ),
            child: DropdownButton<int>(
              icon: Icon(Icons.keyboard_arrow_down_outlined),
              iconEnabledColor: const Color(0xff0077cd),
              value: cityId,
              hint: const Text(""),
              underline: Container(),
              isExpanded: true,
              items: myCities
                  .map((city) => DropdownMenuItem<int>(
                      value: city.id, child: Text(city.description)))
                  .toList(),
              onChanged: (value) {
                print("Set city to $value");
                setState(() {
                  cityId = value;
                  ready = (instituteName != "") &&
                      (cityId != null) &&
                      (cityId != -1);
                });
              },
            ),
          ),
          warningIdDocument
              ? SizedBox(
                  height: Sizes.boxSeparation,
                )
              : const SizedBox(
                  height: 0,
                ),
          warningIdDocument
              ? Text(
                  "¡Este campo es obligatorio!",
                  style: TextStyle(color: Colors.red, fontSize: Sizes.font12),
                )
              : const SizedBox(
                  height: 0,
                ),
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

  Widget carousel() {
    return SizedBox(
      height: Sizes.tileHeightCard + 3* Sizes.boxSeparation,
      width: Sizes.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: Sizes.padding - 7),
          reportButton(0),
          SizedBox(width: Sizes.padding - 20),
          reportButton(1),
          SizedBox(width: Sizes.padding - 20),
          reportButton(2),
          SizedBox(width: Sizes.padding - 20),
          reportButton(3),
          SizedBox(width: Sizes.padding - 10),
        ],
      ),
    );
  }

  Widget reportButton(int type) {
    String text = "Descargar histórico";
    bool amSelected = type == currentType;
    String extraWord = amSelected ? "White" : "";
    String iconPath = "assets/icons/downloadIcon.png";
    switch (type) {
      case 0:
        text = "Descargar histórico";
        iconPath = "assets/icons/downloadIcon$extraWord.png";
        break;
      case 1:
        text = "Constancia saldo cero";
        iconPath = "assets/icons/paperIcon$extraWord.png";
        break;
      case 2:
        text = "Referencia comercial";
        iconPath = "assets/icons/papersIcon$extraWord.png";
        break;
      case 3:
        text = "Consolidación deuda";
        iconPath = "assets/icons/paperIcon$extraWord.png";
        break;
      default:
        text = "Descargar histórico";
        iconPath = "assets/icons/downloadIcon$extraWord.png";
    }
    return GestureDetector(
      onTap: () {
        switch (type) {
          case 0:
            ready = true;
            cityId = null;
            titleControl.text = "";
            break;
          case 1:
            ready = false;
            cityId = null;
            titleControl.text = "";
            break;
          case 2:
            ready = false;
            cityId = null;
            titleControl.text = "";
            break;
          case 3:
            ready = false;
            cityId = null;
            titleControl.text = "";
            break;
          default:
            ready = false;
        }
        setState(() {
          currentType = type;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: Sizes.tileHeightCard + 2 * Sizes.boxSeparation,
          width: Sizes.width / 3,
          margin: EdgeInsets.only(right: 2 * Sizes.boxSeparation),
          padding: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[850]!.withOpacity(0.1),
                  offset: const Offset(5, 5),
                  blurRadius: 5,
                )
              ],
              color: amSelected ? const Color(0xffFF6A1B) : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.boxSeparation),
              )),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Sizes.tileHeightSmall,
                  width: Sizes.tileHeightSmall,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(iconPath))),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: amSelected ? Colors.white : const Color(0xffFF6A1B),
                    fontSize: Sizes.font10,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
