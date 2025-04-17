import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/models/message.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    final currentUser = _auth.currentUser;

    return _fireStore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != currentUser?.uid)
          .map((doc) => doc.data())
          .toList()
          .cast<Map<String, dynamic>>();
    });
  }

  // send Message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
      senderID: currentUserID, 
      senderEmail: currentUserEmail, 
      receiverID: receiverID, 
      message: message, 
      timestamp: timestamp
    );

    // construct chat room ID for two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoonID = ids.join('_');

    // add new message to db
    await _fireStore.collection("chat_room").doc(chatRoonID).collection('messages').add(newMessage.toMap());
  }

  // get Message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoonID = ids.join('_');

    return _fireStore.collection("chat_room").doc(chatRoonID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}