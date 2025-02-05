class User {
  String? id;
  String name;
  String email;
  String password;

  User({  
    required this.name,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password
  };
}

class UserLoginDTO {
  String password;
  String email;

  UserLoginDTO({
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password
  };
}