import 'dart:convert';
import 'package:http/http.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';

const String SERVER_URL = "https://desarrollo.epik.com.co:5025/";
const String API_PATH = "api/";
const bool DEBUG = true;

class BackendResponse {
  int status = 0;
  Map<String, dynamic> myBody = {};
  BackendResponse({this.status = 0, this.myBody = const {}});
  @override
  String toString() {
    return "[RES $status] $myBody";
  }
}

Map<String, String> getHeader() {
  if (jwt == "") {
    return {"Content-Type": "application/json"};
  }
  return {"Authorization": "Bearer $jwt", "Content-Type": "application/json"};
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
        print("POST: $url");
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

  static Future<BackendResponse> updatePassword(
      String oldPassword, String newPassword) async {
    return await _doPost("clave/cambiar-clave/",
        {"ClaveActual": oldPassword, "ClaveNueva": newPassword},
        debug: DEBUG);
  }

  static Future<BackendResponse> getMovements(String userId) async {
    print("Requesting for id $userId");
    return await _doPost(
        "historial-movimientos", {"NumeroIdentificacion": userId},
        debug: DEBUG);
  }
}
