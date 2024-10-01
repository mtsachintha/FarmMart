import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ChatScreen()));

// Define the ChatItem model
class ChatItem {
  final String chatId;
  final String storeName;
  final String itemName;
  final Icon icon;
  final String lastMessage;

  ChatItem({
    required this.chatId,
    required this.storeName,
    required this.itemName,
    required this.icon,
    required this.lastMessage,
  });
}

// Define the ChatScreen widget
class ChatScreen extends StatelessWidget {
  // Sample list of chat items
  final List<ChatItem> chatItems = [
    ChatItem(
      chatId: '1',
      storeName: 'Evo Green House',
      itemName: '3 Ton of Organic Unprocessed Rice Fresh from the Fields',
      icon: Icon(Icons.store, size: 40.0, color: Colors.grey),
      lastMessage: 'I will send you the samples',
    ),
    ChatItem(
      chatId: '2',
      storeName: 'Fresh Farm',
      itemName: '10 Kg of Organic Tomatoes',
      icon: Icon(Icons.shopping_basket, size: 40.0, color: Colors.grey),
      lastMessage: 'The shipment will arrive tomorrow.',
    ),
    ChatItem(
      chatId: '3',
      storeName: 'Green Valley',
      itemName: '5 Kg of Fresh Organic Mangoes',
      icon: Icon(Icons.local_florist, size: 40.0, color: Colors.grey),
      lastMessage: 'Thank you for your purchase!',
    ),
    ChatItem(
      chatId: '4',
      storeName: 'Organic Harvest',
      itemName: '20 Kg of Brown Rice',
      icon: Icon(Icons.agriculture, size: 40.0, color: Colors.grey),
      lastMessage: 'The order has been confirmed.',
    ),
    ChatItem(
      chatId: '5',
      storeName: 'Healthy Foods',
      itemName: '15 Kg of Organic Lentils',
      icon: Icon(Icons.eco, size: 40.0, color: Colors.grey),
      lastMessage: 'Your order is being processed.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
            8.0), // Add padding around the ListView.builder
        child: ListView.builder(
          itemCount: chatItems.length,
          itemBuilder: (context, index) {
            return _buildChatItem(chatItems[index]);
          },
        ),
      ),
    );
  }

  Widget _buildChatItem(ChatItem item) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0), // Set card radius here
        ),
        child: ListTile(
          leading: item.icon,
          title: Text(
            item.itemName,
            style: TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1, // Limit the title to one line
            overflow:
                TextOverflow.ellipsis, // Add ellipsis if the title is too long
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seller: ${item.storeName}',
                style: TextStyle(
                    color: Colors.grey[600], fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 4.0),
              Text(item.lastMessage),
            ],
          ),
        ),
      ),
    );
  }
}
