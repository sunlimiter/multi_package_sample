import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../localization/message_localizations.dart';

class MessageScreen extends HookWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.message_title ?? 'Message')),
      body: Center(
        child: Text(AppLocalizations.of(context)?.message_screen ?? 'Message Screen'),
      ),
    );
  }
}
