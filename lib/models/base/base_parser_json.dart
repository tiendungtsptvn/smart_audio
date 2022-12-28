


import '../api/user_info.dart';

mixin GPParserJson {
  static Map<Type, Function> _mapFactories<T>() {
    return <Type, Function>{
      T: (Map<String, dynamic> x) => _mapFactoryValue<T>(x),
    };
  }

  static dynamic _mapFactoryValue<T>(Map<String, dynamic> x) {
    // parse all items here
    switch (T) {
      case UserInfo:
        return UserInfo.fromJson(x);
      case String:
        return x as String;
      default:
        throw Exception("ApiResponseExtension _mapFactoryValue error!!!");
    }
  }

  static T parseJson<T>(Map<String, dynamic> x) {
    Map<Type, Function> factories = _mapFactories<T>();
    return factories[T]?.call(x);
  }
}
