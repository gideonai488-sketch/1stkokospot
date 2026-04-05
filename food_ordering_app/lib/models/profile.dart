class Profile {
  final String userId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;

  Profile({
    required this.userId,
    this.fullName,
    this.email,
    this.phone,
    this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json['user_id'],
        fullName: json['full_name'],
        email: json['email'],
        phone: json['phone'],
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'avatar_url': avatarUrl,
      };
}
