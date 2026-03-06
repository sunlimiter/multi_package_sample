import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '{{name}}_contract.dart';
import '{{name}}_cubit.dart';

class {{name.pascalCase()}}Screen extends HookWidget {
  const {{name.pascalCase()}}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<{{name.pascalCase()}}Cubit>();
    
    useEffect(() {
      _cubit.onIntent(const {{name.pascalCase()}}Intent.initial());
      
      final subscription = _cubit.effectStream.listen((effect) {
        effect.when(
          showError: (message) {
             Fluttertoast.showToast(msg: message);
          },
        );
      });
      return subscription.cancel;
    }, [_cubit]);
    
    final state = useBlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(_cubit);

    return Scaffold(
      appBar: AppBar(title: const Text('{{name.pascalCase()}}')),
      body: Center(
        child: state.isLoading 
            ? const CircularProgressIndicator()
            : const Text('{{name.pascalCase()}} Screen'),
      ),
    );
  }
}
