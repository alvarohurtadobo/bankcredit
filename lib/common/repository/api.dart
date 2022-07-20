import 'dart:convert';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:http/http.dart';

const String SERVER_URL = "https://desarrollo.epik.com.co:5025/";
const String API_PATH = "api/";
const bool DEBUG = true;

class BackendResponse {
  int status = 0;
  Map myBody = {};
  BackendResponse({this.status = 0, this.myBody = const {}});
  @override
  String toString() {
    return "[RES $status] $myBody";
  }
}

class API {
  static Future<BackendResponse> _doGet(String path,
      {bool debug = false}) async {
    String url = SERVER_URL + API_PATH + path;

    Response myResponse =
        await get(Uri.parse(url), headers: {"Content-Type": "application/json"})
            .timeout(const Duration(seconds: 12), onTimeout: () {
      return Response("{}", 999);
    }).catchError((err) {
      return Response("{}", 666);
    });

    Map objectResponse = json.decode(myResponse.body);

    return BackendResponse(
        status: myResponse.statusCode, myBody: objectResponse);
  }

  static Future<BackendResponse> _doPostOrPut(
      String path, Map<String, dynamic> body,
      {bool debug = false, bool isPost = true}) async {
    String url = SERVER_URL + API_PATH + path;
    Response myResponse;
    if (isPost) {
      if (debug) {
        print("POST");
      }
      myResponse = await post(Uri.parse(url),
              body: body, headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 12), onTimeout: () {
        return Response("{}", 999);
      }).catchError((err) {
        return Response("{}", 666);
      });
    } else {
      myResponse = await put(Uri.parse(url),
              body: body, headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 12), onTimeout: () {
        return Response("{}", 999);
      }).catchError((err) {
        return Response("{}", 666);
      });
    }

    Map objectResponse = json.decode(myResponse.body);

    return BackendResponse(
        status: myResponse.statusCode, myBody: objectResponse);
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
    return _doPost("auth/token", myBody, debug: DEBUG);
  }

  static Future<BackendResponse> register(User myUser) async {
    return _doPost("usuario/registrar", myUser.toBackendMap(), debug: DEBUG);
  }

  static Future<BackendResponse> update(User myUser) async {
    return _doPost("usuario/actualizar", myUser.toBackendMap(), debug: DEBUG);
  }

  static Future<BackendResponse> updatePassword(
      String oldPassword, String newPassword) async {
    return _doPost("clave/cambiar-clave/",
        {"ClaveActual": oldPassword, "ClaveNueva": newPassword},
        debug: DEBUG);
  }
}
