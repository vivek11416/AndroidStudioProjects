import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final String email;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
