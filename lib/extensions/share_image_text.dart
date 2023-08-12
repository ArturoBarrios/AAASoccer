import 'package:share_plus/share_plus.dart';

import '../commands/images_command.dart';

/// Extension for checking if string valid url.
extension ShareImageText on String {
  Future<void> _shareWithImageAndText({final String? imageKey}) async {
    final signedUrl = await ImagesCommand().getImage(imageKey ?? '');

    if (signedUrl['data']['signedUrl'] == null) {
      await _shareWithText();
      return;
    }

    final filePath =
        await ImagesCommand().downloadImage(signedUrl['data']['signedUrl']);

    await Share.shareXFiles(
        [filePath]
            .map((path) => XFile(path ?? '', mimeType: 'image/png'))
            .toList(),
        text: this);
  }

  Future<void> _shareWithText() async {
    await Share.share(this);
  }

  Future<void> share({final String? imageKey}) async {
    if (imageKey == null) {
      await _shareWithText();
    } else {
      await _shareWithImageAndText(imageKey: imageKey);
    }
  }
}
