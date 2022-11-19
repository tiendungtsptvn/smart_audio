

import '../api/code_response.dart';
import '../api/login_response.dart';
import '../api/request_email_response.dart';
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
      case RequestEmailResponse:
        return RequestEmailResponse.fromJson(x);
      case LoginResponse:
        return LoginResponse.fromJson(x);
      case UserInfo:
        return UserInfo.fromJson(x);
      case String:
        return x as String;
      case CodeResponse:
        return CodeResponse.fromJson(x);
      default:
        throw Exception("ApiResponseExtension _mapFactoryValue error!!!");
    }
  }

  static T parseJson<T>(Map<String, dynamic> x) {
    Map<Type, Function> _factories = _mapFactories<T>();
    return _factories[T]?.call(x);
  }
}
