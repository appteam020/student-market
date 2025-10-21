class ProfileModel {
  final String? fullName;
  final String? email;
  final String? createdAt;
  final String? token;
  final String? profileImage;
  final String? onesignalId;

  ProfileModel({this.fullName, this.email, this.createdAt, this.token, this.profileImage, this.onesignalId});

  ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['full_name'] ?? "",
      email: json['email'] ?? "",
      createdAt: json['created_at'] ?? "",
      token: json['user_id'] ?? "",
      profileImage: json['image'] ?? "",
      onesignalId: json['onesignal_id'] ?? "",
    );
  }

  Map<String, String?> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'created_at': createdAt,
      'token': token,
      'profile_image': profileImage,
      'onesignal_id': onesignalId,
    };
  }
}
