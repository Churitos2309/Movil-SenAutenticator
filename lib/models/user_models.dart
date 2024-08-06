class User {
  String id;
  String username;
  String email;
  String password;
  List<Face> faces;

  User({required this.id, required this.username, required this.email, required this.password, required this.faces});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      faces: (json['faces'] as List).map((face) => Face.fromJson(face)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'faces': faces.map((face) => face.toJson()).toList(),
    };
  }
}

class Face {
  String id;
  String userId;
  String faceImage;

  Face({required this.id, required this.userId, required this.faceImage});

  factory Face.fromJson(Map<String, dynamic> json) {
    return Face(
      id: json['_id'],
      userId: json['userId'],
      faceImage: json['faceImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'faceImage': faceImage,
    };
  }
}