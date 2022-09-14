import 'package:credidiunsa_app/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/model/sesion.dart';

bool setUpUser(Map<String, dynamic> userResponse,
    {String password = "", bool rememberMe = false}) {
  try {
    currentUser = User.fromBackendResponse(userResponse);
    jwt = userResponse["JWT"] ?? "";
    expiration = userResponse["Expiracion"] ?? 0;
    errorMessage = userResponse["Mensaje"] ?? "";
    
    try {
      ultimaConexion =
          DateTime.tryParse(userResponse["ultimaConexion"]) ?? DateTime.now();
      print("Last session is $ultimaConexion");
    } catch (err) {
      print("Did not received last session");
    }
    SharedPreferences.getInstance().then((prefs) {
      print("Saving ${currentUser.identification}, $password, $jwt");
      prefs.setString("jwt", jwt);
      prefs.setDouble("expiration", expiration);
      prefs.setString("document", currentUser.identification);
      prefs.setString("password", password);
      prefs.setBool("remmemberme", rememberMe);
      print("Remember me set to $rememberMe");
    });
  } catch (error) {
    print("Error setting up user $error");
    return false;
  }
  return true;
}
