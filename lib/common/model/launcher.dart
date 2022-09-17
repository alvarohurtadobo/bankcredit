// ignore_for_file: avoid_print
import 'package:url_launcher/url_launcher.dart';

Future<bool> customLaunchUrl(String url) async {
  print("Launching $url");
  bool success =
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  if (!success) {
    // throw 'Could not launch $url';
    return false;
  }
  return success;
}
