import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';

class ChatModel {
  final String name;
  final int id;
  final Timestamp lastUpdate;
  final Timestamp timestamp;
  final bool isActive;
  final bool seenMessage;
  final bool messageIsSend;
  final int senderId;
  final int receiverId;
  final String messageText;

  const ChatModel({
    required this.messageText,
    required this.receiverId,
    required this.senderId,
    required this.name,
    required this.id,
    required this.lastUpdate,
    required this.timestamp,
    required this.isActive,
    required this.seenMessage,
    required this.messageIsSend,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel(
      name: data['name'] ?? '',
      id: data['id'] ?? 0,
      lastUpdate: data['lastUpdate'] ?? Timestamp.now(),
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isActive: data['isActive'] ?? false,
      seenMessage: data['seenMessage'] ?? false,
      messageIsSend: data['messageIsSend'] ?? false,
      senderId: data['senderId'] ?? 0,
      receiverId: data['receiverId'] ?? 0,
      messageText: data['text'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'id': id,
      'lastUpdate': lastUpdate,
      'timestamp': timestamp,
      'isActive': isActive,
      'seenMessage': seenMessage,
      'messageIsSend': messageIsSend,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': messageText,
    };
  }
}

extension ChatModelX on ChatModel {
  ChatEntity toEntity() {
    return ChatEntity(
      messageText: messageText,
      receiverId: receiverId,
      senderId: senderId,
      name: name,
      id: id,
      lastUpdate: lastUpdate,
      timestamp: timestamp,
      isActive: isActive,
      seenMessage: seenMessage,
      messageIsSend: messageIsSend,
    );
  }
}
