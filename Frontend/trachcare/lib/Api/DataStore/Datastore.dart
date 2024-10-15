Map<String,String> LoginData = {};
class LoginDataStore{
  void Setusername(String username){
    LoginData.addAll({"username":username});
  }

  void SetPassword(String password){
    LoginData.addAll({"password":password});
  }
}

var patient_id ;
var Doctor_id;
var username;



