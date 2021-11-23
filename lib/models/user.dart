class User {
  final String userName;
  final String password;
  
  User({
    required this.userName, 
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() =>
  {
    'userName': userName,
    'password': password
  };

}