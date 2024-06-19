Map<String,String> LoginData = Map();
class LoginDataStore{
  void Setusername(String username){
    LoginData.addAll({"username":username});
  }

  void SetPassword(String password){
    LoginData.addAll({"password":password});
  }

}