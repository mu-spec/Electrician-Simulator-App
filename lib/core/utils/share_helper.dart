import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

/// Shares [text] through the system share sheet in an iPad-safe way.
///
/// On iPads the share sheet is presented as a popover and requires a
/// `sharePositionOrigin`; without one the call throws and nothing is
/// shared. On iPhones and Android the origin is ignored, so existing
/// behavior on those platforms is unchanged.
///
/// The origin is derived from the calling [context]'s render box, which
/// anchors the iPad popover to the screen area that triggered the share.
Future<void> shareText(
  BuildContext context, {
  required String text,
  String? subject,
}) async {
  final box = context.findRenderObject() as RenderBox?;
  final Rect? sharePositionOrigin =
      (box != null && box.hasSize && box.size.isFinite)
          ? box.localToGlobal(Offset.zero) & box.size
          : null;
  await Share.share(
    text,
    subject: subject,
    sharePositionOrigin: sharePositionOrigin,
  );
}
