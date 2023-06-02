
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
class UrlLauncherUtils {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


}
