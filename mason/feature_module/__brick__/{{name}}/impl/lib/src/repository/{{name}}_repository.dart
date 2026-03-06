import 'package:common/common.dart';

@injectable
class {{name.pascalCase()}}Repository {
  final HttpClient _httpClient;

  {{name.pascalCase()}}Repository(this._httpClient);

  // Implement data fetching methods here
  // Future<dynamic> fetchData() async {
  //   var result = await _httpClient.get('/api/endpoint');
  //   if (result.ok) {
  //     return result.result;
  //   } else {
  //     throw Exception(result.error?.message ?? 'Request failed');
  //   }
  // }
}
