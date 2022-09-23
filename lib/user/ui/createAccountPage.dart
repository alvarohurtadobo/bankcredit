// Language: dart
// ignore_for_file: library_private_types_in_public_api, file_names, avoid_print, unused_import

import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:flutter/services.dart';

import '../../common/ui/sizes.dart';
import '../../common/widgets/warningLabel.dart';
import '../model/documentType.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/model/regEx.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool acceptTerms = false;
  bool loading = false;
  bool passwordsCorrect = false;
  String newPassword = "";
  String confirmPassword = "";
  bool obscure1 = true;
  bool obscure2 = true;
  bool min8charactersWarning = true;
  bool oneCapitalWarning = true;
  bool oneDigitWarning = true;
  bool differentPasswordsWarning = false;
  bool showAcceptTermsWarning = false;
  String usedDocumentLabel = "";
  bool identificationIdWarning = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);
    // print("Types length are ${myDocumentTypes.length}");

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
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    setState(() {
                      currentUser.firstSurname = newName;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xff0077CD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: null,
                  ),
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
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (newName) {
                    setState(() {
                      currentUser.secondSurname = newName;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  onChanged: (newName) {
                    setState(() {
                      currentUser.firstName = newName;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (newName) {
                    setState(() {
                      currentUser.secondName = newName;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                    iconEnabledColor: const Color(0xff0077cd),
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
                !identificationIdWarning
                    ? Container()
                    : SizedBox(
                        height: 1.5 * Sizes.boxSeparation,
                      ),
                !identificationIdWarning
                    ? Container()
                    : Text(
                        "Este campo es obligatorio ",
                        style: TextStyle(
                            color: Colors.red, fontSize: Sizes.font12),
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
                    if (value.length > 13) {
                      return "El número de documento debe contener menos de 13 dígitos";
                    }
                    // condicionales para el documento del cliente
                    if (value.length < 10) {
                      return "El número de documento debe contener mas de 10 dígitos";
                    }
                    return null;
                  },
                  // maxLength: 13,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  onChanged: (value) {
                    setState(() {
                      currentUser.identification = value;
                    });
                  },
                  decoration: InputDecoration(
                      // counter: Container(),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBorder: null),
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                const Text(
                  "El número de cédula, será tu usuario",
                  style: TextStyle(color: Color(0xff7A8084)),
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                usedDocumentLabel != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber,
                              color: Color(0xffB70909)),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamed("/resetPassword01");
                            },
                            child: Text(usedDocumentLabel,
                                style: const TextStyle(
                                    color: Color(0xffB70909), fontSize: 14)),
                          )
                        ],
                      )
                    : Container(),
                usedDocumentLabel != ""
                    ? SizedBox(
                        height: Sizes.boxSeparation,
                      )
                    : Container(),
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
                    setState(() {
                      currentUser.email = value;
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    if (value.length < 8) {
                      return "Este campo debe tener al menos 8 dígitos";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      currentUser.phone = value;
                    });
                  },
                  decoration: InputDecoration(
                      // counter: Container(),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Contraseña",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  obscureText: obscure1,
                  onChanged: (value) {
                    newPassword = value;
                    currentUser.password = newPassword;
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
                      differentPasswordsWarning =
                          newPassword != confirmPassword;
                      passwordsCorrect = !differentPasswordsWarning &&
                          !min8charactersWarning &&
                          !oneCapitalWarning &&
                          !oneDigitWarning;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure1 = !obscure1;
                          });
                          print("Toggle $obscure1");
                        },
                        child: obscure1
                            ? Image.asset("assets/icons/obscured.png")
                            : const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Color(0xff7A8084),
                                ),
                              ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBorder: null),
                ),
                SizedBox(
                  height: 1.5 * Sizes.boxSeparation,
                ),
                const Text("Confirmar contraseña",
                    style: TextStyle(color: Color(0xff0077cd))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                TextFormField(
                  obscureText: obscure2,
                  onChanged: (value) {
                    confirmPassword = value;

                    if (newPassword == confirmPassword) {
                      FocusScope.of(context).unfocus();
                    }
                    setState(() {
                      differentPasswordsWarning =
                          newPassword != confirmPassword;
                      passwordsCorrect = !differentPasswordsWarning &&
                          !min8charactersWarning &&
                          !oneCapitalWarning &&
                          !oneDigitWarning;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        child: obscure2
                            ? Image.asset("assets/icons/obscured.png")
                            : const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Color(0xff7A8084),
                                ),
                              ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xff0077CD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBorder: null),
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                warningLabel("8 carácteres", min8charactersWarning),
                warningLabel("1 mayúscula", oneCapitalWarning),
                warningLabel("1 dígito", oneDigitWarning),
                warningLabel(
                    "Contraseñas no coinciden", differentPasswordsWarning,
                    disappearWarning: true),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // eran 22
                      width: 15,
                      height: 14,
                      alignment: Alignment.center,
                      // decoration: const BoxDecoration(
                      //   borderRadius:
                      //       BorderRadius.all(Radius.circular(7)),
                      //   color: Colors.white,
                      // ),
                      color: Colors.white,
                      child: Checkbox(
                        value: acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            acceptTerms = value ?? false;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith((states) {
                          return const Color(0xff0077cd);
                        }),
                        side: const BorderSide(
                          color: Color(0xff0077CD),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        activeColor: Colors.white,
                        checkColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/privacy");
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
                showAcceptTermsWarning
                    ? SizedBox(
                        height: Sizes.boxSeparation,
                      )
                    : Container(),
                showAcceptTermsWarning
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber,
                              color: Color(0xffB70909)),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamed("/resetPassword01");
                            },
                            child: const Text("¡Este campo es obligatorio!",
                                style: TextStyle(
                                    color: Color(0xffB70909), fontSize: 14)),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: Sizes.padding,
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
                          color: (currentUser.canCreate() &&
                                  passwordsCorrect &&
                                  acceptTerms)
                              ? const Color(0xff0077CD)
                              : const Color(0xff7b8084),
                          borderRadius: BorderRadius.circular(Sizes.border),
                        ),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                usedDocumentLabel = "";
                              });
                              if (!acceptTerms) {
                                if (loading) {
                                  return;
                                }
                                setState(() {
                                  showAcceptTermsWarning = true;
                                });
                                return;
                              }
                              print("1");
                              if (currentUser.idIdentification == null) {
                                setState(() {
                                  identificationIdWarning = true;
                                });
                              }
                              print("2");
                              if (!currentUser.canCreate()) {
                                _formKey.currentState!.validate();
                                return;
                              }
                              print("3");
                              if (_formKey.currentState!.validate() &&
                                  passwordsCorrect) {
                                print(
                                    "Create with pass: ${currentUser.password}");
                                setState(() {
                                  loading = true;
                                });
                                API.register(currentUser).then((response) {
                                  setState(() {
                                    loading = false;
                                  });
                                  try {
                                    if (response.idError == 0) {
                                      currentUser = User.empty();
                                      simpleAlertDialog(context,
                                          "¡Felicitaciones!", response.message,
                                          buttonLabel: "Ingresar", action: () {
                                        // Navigator.of(context).pop();
                                        print("Login");
                                        API
                                            .login(currentUser.identification,
                                                currentUser.password)
                                            .then((res) {
                                          print("After login");
                                          if (res.idError == 0) {
                                            auxJwt = res.myBody["JWT"] ?? "";
                                            print("Aux JWT is $auxJwt");
                                          }
                                        });
                                      }).then((value) {
                                        Navigator.of(context).pop();
                                        print("Moving to pic $auxJwt");
                                        currentUser.reset();
                                        if (auxJwt != "") {
                                          Navigator.of(context).pushNamed(
                                              "/updateProfilePicture");
                                        }
                                      });
                                    } else {
                                      if (response.idError == 3) {
                                        setState(() {
                                          usedDocumentLabel = response.message;
                                        });
                                      } else {
                                        simpleAlertDialog(
                                                context,
                                                "¡Lo sentimos!",
                                                response.message)
                                            .then((value) {});
                                      }
                                    }
                                  } catch (err) {
                                    // showToast("Bad format from backend",
                                    //     type: 2);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Siguiente",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
