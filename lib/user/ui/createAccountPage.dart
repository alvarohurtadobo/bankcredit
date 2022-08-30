// Language: dart

import 'package:credidiunsa_app/common/model/regEx.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/common/widgets/toasts.dart';
import 'package:credidiunsa_app/user/model/user.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';

import '../model/documentType.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool acceptTerms = false;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Sizes.setSizes(_width, _height);
    print("Types length are ${myDocumentTypes.length}");

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: Sizes.height * 0.18,
                padding: EdgeInsets.all(Sizes.padding),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/image_02.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("¡Crea tu cuenta!",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("Ingresa la información",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
              Positioned(
                  top: Sizes.padding,
                  left: Sizes.padding,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: Sizes.padding * 1.6,
                          height: Sizes.padding * 1.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.padding * 1.6 / 2))),
                          child: Icon(
                            Icons.arrow_back,
                            size: 1.5 * Sizes.padding,
                            color: const Color(0xff0077cd),
                          )))),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
            color: const Color(0xfff2f2f2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                Center(
                  child: Container(
                    width: Sizes.width * 0.6,
                    height: 40,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                const Text("Primer Apellido",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    // currentUser.setLastNames(newName);
                    currentUser.firstSurname = newName;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Segundo Apellido",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    currentUser.secondSurname = newName;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Primer nombre",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    // currentUser.setNames(newName);
                    currentUser.firstName = newName;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Segundo nombre",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    // currentUser.setNames(newName);
                    currentUser.secondName = newName;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
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
                    value: currentUser.idIdentification,
                    hint: const Text("Seleccione"),
                    underline: Container(),
                    isExpanded: true,
                    items: myDocumentTypes
                        .map((type) => DropdownMenuItem<int>(
                            value: type.id, child: Text(type.name)))
                        .toList(),
                    onChanged: (value) {
                      print("Set value to $value");
                      setState(() {
                        currentUser.idIdentification = value;
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
                    return null;
                  },
                  onChanged: (value) {
                    currentUser.identification = value;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Correo electrónico",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  validator: (value) {
                    if (!isGoodEmail(value ?? "")) {
                      return "Introduzca un correo válido";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    currentUser.email = value;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Teléfono",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    currentUser.email = value;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      focusedBorder: null,
                      disabledBorder: null),
                ),
                // SizedBox(
                //   height: 1.5 * Sizes.boxSeparation,
                // ),
                // const Text("Contraseña",
                //     style: TextStyle(color: Color(0xff0077cd))),
                // SizedBox(
                //   height: Sizes.boxSeparation,
                // ),
                // TextFormField(
                //   obscureText: true,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Este campo es obligatorio";
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //     currentUser.email = value;
                //   },
                //   decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Colors.white,
                //       border: InputBorder.none,
                //       hintText: "",
                //       contentPadding:
                //           EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                //       focusedBorder: null,
                //       disabledBorder: null),
                // ),
                // SizedBox(
                //   height: 1.5 * Sizes.boxSeparation,
                // ),
                // const Text("Confirmar contraseña",
                //     style: TextStyle(color: Color(0xff0077cd))),
                // SizedBox(
                //   height: Sizes.boxSeparation,
                // ),
                // TextFormField(
                //   obscureText: true,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Este campo es obligatorio";
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Colors.white,
                //       border: InputBorder.none,
                //       hintText: "",
                //       contentPadding:
                //           EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                //       focusedBorder: null,
                //       disabledBorder: null),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          acceptTerms = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed("/resetPassword01");
                      },
                      child: const Text(
                          "Acepto condiciones y políticas de privacidad",
                          style: TextStyle(
                              color: Color(0xff0077cd),
                              fontSize: 14,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff0077CD),
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.padding),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff7b8084),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (!acceptTerms) {
                                // showToast("Debe aceptar las condiciones de uso",
                                //     type: 1);
                                return;
                              }
                              if (loading) {
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                API.register(currentUser).then((response) {
                                  setState(() {
                                    loading = false;
                                  });
                                  try {
                                    if (response.idError == 0) {
                                      simpleAlertDialog(context, "Exito",
                                              "Usuario creado exitósamente")
                                          .then((value) {
                                        Navigator.of(context).pop();
                                      });
                                    } else {
                                      simpleAlertDialog(context, "Error",
                                              response.message)
                                          .then((value) {
                                      });
                                    }
                                  } catch (err) {
                                    // showToast("Bad format from backend",
                                    //     type: 2);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Crear cuenta",
                              style: TextStyle(
                                  color: Color(0xffb8b8b8), fontSize: 18),
                            ))),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
