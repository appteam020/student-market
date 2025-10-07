// To represent a user's profile
class Profile {
  final int id;
  final String fullName;
  final String email;
  final String? profileImage;
  final String? userId;

  Profile({required this.id, required this.fullName, required this.email, required this.profileImage, required this.userId});

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      fullName: map['full_name'] ?? 'Unknown User',
      email: map['email'] ?? 'Unknown Email',
      profileImage: map['image'],
      userId: map['user_id'],
    );
  }
}

// To represent a full conversation with the user's profile
class Conversation {
  final Profile partner;
  final String lastMessage;
  final dynamic lastAttachment; // Can be Map or null
  final DateTime lastMessageTime;
  final String lastMessageSenderId;

  Conversation({
    required this.partner,
    required this.lastMessage,
    this.lastAttachment,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
  });
}
