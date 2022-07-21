import 'package:credidiunsa_app/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/model/sesion.dart';

bool setUpUser(Map<String, dynamic> userResponse, {String password = ""}) {
  try {
    currentUser = User.fromBackendResponse(userResponse);
    jwt = userResponse["JWT"];
    expiration = userResponse["Expiracion"];
    errorMessage = userResponse["Mensaje"];
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("jwt", jwt);
      prefs.setDouble("expiration", expiration);
      prefs.setString("document", currentUser.identification);
      prefs.setString("password", currentUser.password);
    });
  } catch (error) {
    print("Error setting up user $error");
    return false;
  }
  return true;
}
