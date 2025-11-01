import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
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

  const ChatEntity({
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

  @override
  List<Object?> get props => [
    name,
    id,
    lastUpdate,
    timestamp,
    isActive,
    seenMessage,
    messageIsSend,
  ];


  factory ChatEntity.createFromText(
      String text,
      int userId,
      int receiverId,
      String name,
      ) {
    return ChatEntity(
      id: userId,
      name: name,
      messageText: text,
      senderId: userId,
      receiverId: receiverId,
      timestamp: Timestamp.fromDate(DateTime.now()),
      lastUpdate: Timestamp.fromDate(DateTime.now()),
      isActive: true,
      seenMessage: false,
      messageIsSend: true,
    );
  }


}
