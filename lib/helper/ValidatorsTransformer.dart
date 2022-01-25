import 'dart:async';

mixin ValidatorsTransformer {

  static final RegExp _NameRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static bool isValidName(String Name) {
    return Name.length>4;
  }

  static bool isValidPassword(String password) {
    return password.length > 4;
  }

  final validateName =
  StreamTransformer<String, bool>.fromHandlers(handleData: (Name, sink) {
    if (isValidName(Name)) {
      sink.add(true);
    } else {
      sink.add(false);
    }
  });

  final validateRequireField =
  StreamTransformer<String, bool>.fromHandlers(handleData: (Name, sink) {
    if (Name.isNotEmpty) {
      sink.add(true);
    } else {
      sink.add(false);
    }
  });


  final validatePassword = StreamTransformer<String, bool>.fromHandlers(
      handleData: (password, sink) {
        if (isValidPassword(password)) {
          sink.add(true);
        } else {
          sink.add(false);
        }
      });
}