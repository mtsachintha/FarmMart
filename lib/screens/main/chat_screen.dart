import 'package:flutter/material.dart';
import 'package:farm_application/models/chat.dart';
import 'package:farm_application/colors.dart';

List<Chat> chatData = [
  Chat(
      name: "Laurent",
      message: "How about meeting tomorrow?",
      time: "20:18",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
  Chat(
      name: "Tracy",
      message: "I love that idea, it's great!",
      time: "19:22",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
  Chat(
      name: "Claire",
      message: "I wasn't aware of that. Let me check",
      time: "14:34",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
  Chat(
      name: "Joe",
      message: "Flutter just released 1.0 officially.",
      time: "11:05",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
  Chat(
      name: "Mark",
      message: "It totally makes sense to get some extra day-off.",
      time: "09:46",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
  Chat(
      name: "Williams",
      message: "It has been re-scheduled to next Saturday 7:30pm",
      time: "08:15",
      avatarUrl:
          "https://img.freepik.com/premium-photo/profile-icon-white-background_941097-161433.jpg?w=360"),
];

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          final chat = chatData[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            title:
                Text(chat.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(chat.message),
            trailing: Text(chat.time,
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {
              // Navigate to chat detail screen
            },
          );
        },
      ),
    );
  }
}

AppBar buildSecondAppBar() {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppColors.darkGreen,
    title: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Messages",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18.0, // Adjust the font size as needed
            ),
          ),
        ),
        Spacer(), // Pushes the icon to the right
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.bookmarks_outlined, color: Colors.white),
            onPressed: () {
              // Action for bookmark icon tap
            },
          ),
        ),
      ],
    ),
  );
}
