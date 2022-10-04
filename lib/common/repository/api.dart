// ignore_for_file: constant_identifier_names, avoid_print, unused_element

import 'dart:convert';
import 'package:http/http.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';

// URL desarrollo: https://desarrollo.epik.com.co:5025/
// URL produccion: https://diunsa.epik.com.co:7013/

const String SERVER_URL = "https://desarrollo.epik.com.co:5025/";
const String API_PATH = "api/";
const bool DEBUG = true;

class BackendResponse {
  int status = 0;
  int idError = 0;
  String message = "";
  Map<String, dynamic> myBody = {};
  BackendResponse(
      {this.status = 0,
      this.myBody = const {},
      this.idError = 0,
      this.message = ""}) {
    try {
      idError = myBody["IdError"] ?? 0;
      message = myBody["Mensaje"] ?? "";
    } catch (err) {
      print("Unable to assign error and message automatically");
    }
  }
  @override
  String toString() {
    return "[RES $status] $myBody";
  }
}

Map<String, String> getHeader() {
  if (jwt != "") {
    return {"Authorization": "Bearer $jwt", "Content-Type": "application/json"};
  }
  if (auxJwt != "") {
    return {
      "Authorization": "Bearer $auxJwt",
      "Content-Type": "application/json"
    };
  }
  return {"Content-Type": "application/json"};
}

class API {
  static Future<BackendResponse> _doGet(String path,
      {bool debug = false}) async {
    String url = SERVER_URL + API_PATH + path;

    Response myResponse = await get(Uri.parse(url), headers: getHeader())
        .timeout(const Duration(seconds: 12), onTimeout: () {
      return Response("{}", 999);
    }).catchError((err) {
      return Response("{}", 666);
    });

    if (debug) {
      print("Response: ${myResponse.statusCode}. Body: ${myResponse.body}");
    }
    Map<String, dynamic> objectResponse = {};
    int auxStatus = myResponse.statusCode;
    try {
      objectResponse = json.decode(myResponse.body);
    } catch (err) {
      print("Unable to format cause $err");
      auxStatus = 666;
    }

    return BackendResponse(status: auxStatus, myBody: objectResponse);
  }

  static Future<BackendResponse> _doPostOrPut(
      String path, Map<String, dynamic> body,
      {bool debug = false, bool isPost = true}) async {
    String url = SERVER_URL + API_PATH + path;
    Response myResponse;
    if (isPost) {
      if (debug) {
        print("POST: $url, Body: $body");
      }
      myResponse = await post(Uri.parse(url),
              body: json.encode(body), headers: getHeader())
          .timeout(const Duration(seconds: 12), onTimeout: () {
        return Response("{}", 999);
      }).catchError((err) {
        print("Error is $err");
        return Response("{}", 666);
      });
    } else {
      myResponse = await put(Uri.parse(url),
              body: json.encode(body), headers: getHeader())
          .timeout(const Duration(seconds: 12), onTimeout: () {
        return Response("{}", 999);
      }).catchError((err) {
        print("Error is $err");
        return Response("{}", 666);
      });
    }

    if (debug) {
      print("Response: ${myResponse.statusCode}. Body: ${myResponse.body}");
    }
    Map<String, dynamic> objectResponse = {};
    int auxStatus = myResponse.statusCode;
    try {
      objectResponse = json.decode(myResponse.body);
    } catch (err) {
      print("Unable to format cause $err");
      auxStatus = 666;
    }

    return BackendResponse(status: auxStatus, myBody: objectResponse);
  }

  static Future<BackendResponse> _doPost(
    String path,
    Map<String, dynamic> body, {
    bool debug = false,
  }) async {
    return await _doPostOrPut(path, body, debug: debug, isPost: true);
  }

  static Future<BackendResponse> _doPut(
    String path,
    Map<String, dynamic> body, {
    bool debug = false,
  }) async {
    return await _doPostOrPut(path, body, debug: debug, isPost: false);
  }

  static Future<BackendResponse> login(
      String documentId, String password) async {
    Map<String, String> myBody = {"Usuario": documentId, "Clave": password};
    if (DEBUG) {
      print("loging with $myBody");
    }
    return await _doPost("auth/token", myBody, debug: DEBUG);
  }

  static Future<BackendResponse> register(User myUser) async {
    return await _doPost("usuario/registrar", myUser.toBackendMap(),
        debug: DEBUG);
  }

  static Future<BackendResponse> update(User myUser) async {
    print("Updating with data ${myUser.toBackendMap()}");
    return await _doPost("usuario/actualizar", myUser.toBackendMap(),
        debug: DEBUG);
  }

  static Future<BackendResponse> singleUpdate(String param, int type) async {
    print("Updating single param: $param");
    Map<String, dynamic> myBody = {};
    if (type == 0) {
      myBody["Correo"] = param;
      myBody["Celular"] = "";
    } else {
      myBody["Correo"] = "";
      myBody["Celular"] = param;
    }
    return await _doPost("usuario/actualizar", myBody, debug: DEBUG);
  }

  static Future<BackendResponse> updatePassword(
      String oldPassword, String newPassword) async {
    return await _doPost("clave/cambiar-clave/",
        {"ClaveActual": oldPassword, "ClaveNueva": newPassword},
        debug: DEBUG);
  }

  static Future<BackendResponse> resetPassword(
      String userDocument, String newPassword) async {
    return await _doPost(
        "clave/restaurar", {"Usuario": userDocument, "Clave": newPassword},
        debug: DEBUG);
  }

  static Future<BackendResponse> getMovements(String userId) async {
    print("Requesting for id $userId");
    return await _doGet(
        "historial-movimientos", // {"NumeroIdentificacion": userId},
        debug: DEBUG);
  }

  static Future<BackendResponse> getAccountStatus() async {
    print("Requesting estado cuenta");
    return await _doGet("archivo/reporte-estado-cuenta", debug: DEBUG);
  }

  static Future<BackendResponse> getCatalog() async {
    print("Requesting catalog");
    return await _doGet("catalogo/lista", debug: DEBUG);
  }

  static Future<BackendResponse> getConstanciaSaldo(
      String instituteName, int cityId) async {
    print("Requesting constancia saldo");
    return await _doPost("archivo/reporte-constancia-saldo",
        {"Institucion": instituteName, "IdCiudad": cityId},
        debug: DEBUG);
  }

  static Future<BackendResponse> getReferenciaCredito(
      String instituteName, int cityId) async {
    print("Requesting reporte-constancia-referencia-credito");
    return await _doPost("archivo/reporte-constancia-referencia-credito",
        {"Institucion": instituteName, "IdCiudad": cityId},
        debug: DEBUG);
  }

  static Future<BackendResponse> getConsolidacionDeuda(
      String instituteName, int cityId) async {
    print("Requesting reporte-constancia-consolidacion-deuda");
    return await _doPost("archivo/reporte-constancia-consolidacion-deuda",
        {"Institucion": instituteName, "IdCiudad": cityId},
        debug: DEBUG);
  }

  static Future<BackendResponse> getContact() async {
    print("Requesting contact");
    return await _doGet("contacto/lista", debug: DEBUG);
  }

  static Future<BackendResponse> getCuota() async {
    print("Requesting cuota");
    return await _doGet("detalle-cuenta/consultar", debug: DEBUG);
  }

  static Future<BackendResponse> getTermsOfUse() async {
    print("Requesting terms of use");
    return await _doGet("politica-producto/consulta", debug: DEBUG);
  }

  static Future<BackendResponse> getPrivacy() async {
    print("Requesting terms of use");
    return await _doGet("politica-privacidad/consulta", debug: DEBUG);
  }

  static Future<BackendResponse> getPaymentMethods() async {
    print("Requesting payment methods");
    return _doGet("medio-pago/lista", debug: DEBUG);
  }

  static Future<BackendResponse> getPromos() async {
    print("Requesting promos");
    return await _doGet("promocion-noveda/lista", debug: DEBUG);
  }

  static Future<BackendResponse> updateProfilePicture(
      String base64Image) async {
    print("Requesting update profile pic");
    return await _doPost(
        "usuario/actualizar-foto-perfil", {"FotoPerfil": base64Image},
        debug: DEBUG);
  }

  static Future<BackendResponse> cancelAcount(String base64Image) async {
    return await _doPost("usuario/estado", {"IdEstado": false}, debug: DEBUG);
  }

  static Future<BackendResponse> restaurationMethods(String docId) async {
    print("Requesting restauration methods");
    return await _doPost("olvide-clave/consultar", {"Usuario": docId},
        debug: DEBUG);
  }

  static Future<BackendResponse> generateOTPOlvidePass(
      String docId, int idMedio) async {
    print("Requesting generate OTP olvide");
    return await _doPost(
        "olvide-clave/generar-otp", {"Usuario": docId, "IdMedio": idMedio},
        debug: DEBUG);
  }

  static Future<BackendResponse> validateOTPForgotPass(
      String docId, String otp) async {
    print("Requesting validar OTP olvide");
    return await _doPost(
        "olvide-clave/validar-otp", {"Usuario": docId, "OTP": otp},
        debug: DEBUG);
  }

  static Future<BackendResponse> generateOTPForUpdate(String param,
      {int type = 0}) async {
    // type 0 email update
    // type 1 phone update
    String updateLabel = type == 0 ? "Correo" : "Celular";
    print("Requesting generate OTP for update");
    return await _doPost("actualizar-datos/generar-otp", {updateLabel: param},
        debug: DEBUG);
  }

  static Future<BackendResponse> validateOTPForUpdate(String otp) async {
    print("Requesting validate OTP for update");
    return await _doPost("actualizar-datos/validar-otp", {"OTP": otp},
        debug: DEBUG);
  }

  static Future<BackendResponse> getVideos() async {
    print("Req videos");

    return await _doGet("video/lista", debug: DEBUG);
  }
}
