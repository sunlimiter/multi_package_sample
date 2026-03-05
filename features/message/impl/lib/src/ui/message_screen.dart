import 'package:common/common.dart';
import 'package:flutter/material.dart';

class MessageScreen extends HookWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message')),
      body: const Center(
        child: Text('Message Screen'),
      ),
    );
  }
}
