import 'package:flutter/material.dart';
import 'package:intrn/data/repositories/authentication_repository.dart';
import 'package:intrn/data/services/chat_service.dart';
import 'package:intrn/pages/chat_page/chat_room_page.dart';
import 'package:intrn/widgets/user_tile.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final ChatService _chatService = ChatService();
  final AuthenticationRepository _authService = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 24,),
          Expanded(child: _buildUserList()),
        ]
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong."));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData == null || userData.isEmpty) {
      return const SizedBox(); // หรือ widget แสดงข้อความว่าไม่มีข้อมูล
    }
    
    return UserTile(
      userData: userData,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatRoomPage(
              receiverFirstname: userData['firstName'] ?? '',
              receiverLastname: userData['lastName'] ?? '',
              receiverID: userData['uid'],
            ),
          ),
        );
      },
    );
  }
}
