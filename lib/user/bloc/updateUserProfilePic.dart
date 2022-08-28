import 'dart:async';

import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/user/model/user.dart';

Future<bool> updateUserProfilePicture(String base64Image) async {
  BackendResponse myRes = await API.updateProfilePicture(base64Image);
  if (myRes.idError == 0) {
    currentUser.pictureUrl = myRes.message;
    return true;
  }
  return false;
}
