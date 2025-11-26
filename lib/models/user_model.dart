class UserModel {
  final String id;
  final String? email;
  final String? fname;
  final String? lname;
  final String? phone;
  final String? profileImage;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    this.email,
    this.fname,
    this.lname,
    this.phone,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  String? get name {
    if (fname != null && lname != null) {
      return '$fname $lname';
    } else if (fname != null) {
      return fname;
    } else if (lname != null) {
      return lname;
    }
    return null;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      email: json['email'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'profileImage': profileImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}


