enum UserRoleType { admin, user }

class UserRole {
  final int id;
  final String userId;
  final UserRoleType role;

  UserRole({
    required this.id,
    required this.userId,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json['id'],
        userId: json['user_id'],
        role: UserRoleType.values.firstWhere((e) => e.name == json['role']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'role': role.name,
      };
}
