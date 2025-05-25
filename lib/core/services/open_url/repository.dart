import 'package:app_skeleton/core/utils/result.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlRepository {
  const OpenUrlRepository();

  Future<Result<bool, void>> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return const ResultData(true);
    }
    return const ResultData(false);
  }
}
