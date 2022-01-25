part of 'log_bloc.dart';

 class LogState extends Equatable  {

  bool isNameInvalid=false;
   bool isPasswordInvalid=false;
  String Name="";
  String password= "";
  bool isshow=false;
  bool sub;

  bool get isFormValid => isNameInvalid && isPasswordInvalid;

  LogState({
 this.isNameInvalid=false,
      this.isPasswordInvalid=false,
      this.Name='',
      this.password='',
    this.isshow=false,
    this.sub=false
  });


  LogState copyWith(
      { bool isNameInvalid=false,
         bool isPasswordInvalid=false,
         String Name='',
         String password='',
        bool isshow=false,
        bool sub=false
      }) {
    return LogState(
      isNameInvalid: isNameInvalid ?? this.isNameInvalid,
      isPasswordInvalid: isPasswordInvalid ?? this.isPasswordInvalid,
     Name: Name ?? this.Name,
      password: password ?? this.password,
      isshow: isshow ?? this.isshow,
        sub: sub??this.sub
    );
  }

  @override
  List<Object> get props => [isNameInvalid, isPasswordInvalid, Name, password,isshow,sub];
}







 class LoginLoadingState extends LogState {


 }

class LoginFinishedState extends LogState {
   bool isSuccess;

  LoginFinishedState({required this.isSuccess}) ;

  @override
  List<Object> get props => [isSuccess];
}