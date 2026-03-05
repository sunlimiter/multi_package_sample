import 'package:common/common.dart';
import 'package:flutter/material.dart';

class {{name.pascalCase()}}Screen extends HookWidget {
  const {{name.pascalCase()}}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
      body: const Center(
        child: Text('{{name.pascalCase()}} Screen'),
      ),
    );
  }
}
