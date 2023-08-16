class LoginModel {
  final String? hspTpCd;
  final String? stfNo;
  final String? password;

  LoginModel({this.hspTpCd, this.stfNo, this.password});


  LoginModel copywith({String? hspTpCd, String? stfNo, String? password}) {
    return LoginModel(
        hspTpCd: hspTpCd ?? this.hspTpCd,
        stfNo: stfNo ?? this.stfNo,
        password: this.password ?? password);
  }
}
