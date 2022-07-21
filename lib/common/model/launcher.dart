import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(String url) async {
  if (!await canLaunchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
