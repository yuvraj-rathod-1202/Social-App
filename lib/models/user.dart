class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'uid': uid,
    'username': username,
    'bio': bio,
    'followers': followers,
    'following': following,
  };
}
