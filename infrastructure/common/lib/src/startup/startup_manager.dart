import 'app_initializer.dart';

class StartupManager {
  static final Map<Type, AppInitializer> _map = {};

  static void register(AppInitializer initializer) {
    _map[initializer.runtimeType] = initializer;
  }

  static Future<void> init() async {
    final visited = <Type>{};

    Future<void> dfs(Type type) async {
      if (visited.contains(type)) return;

      final initializer = _map[type];
      if (initializer == null) return;

      for (final dep in initializer.dependencies) {
        await dfs(dep);
      }

      await initializer.initialize();
      visited.add(type);
    }

    for (final type in _map.keys) {
      await dfs(type);
    }
  }
}
