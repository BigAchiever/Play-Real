import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, String teamCode) {
  // function to copy TeamCode
  Clipboard.setData(ClipboardData(text: teamCode));
  // showError(context, "TeamCode Copied to Clipboard");
}
