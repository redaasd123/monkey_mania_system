import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monkey_app/feature/chat/data/model/chat_model.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage({required ChatModel message});

  Future<List<ChatEntity>> getMessages({
    required int ownerId,
    required int userId,
  });

  Stream<List<ChatEntity>> getMessagesStream({
    required int ownerId,
    required int userId,
  });
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  static const int ownerId = 1;

  ChatRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> sendMessage({required ChatModel message}) async {
    try {
      final chatId = message.senderId == ownerId
          ? '${ownerId}_${message.receiverId}'
          : '${ownerId}_${message.senderId}';


      await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toFirestore());

      await firestore.collection('chats').doc(chatId).set({
        'lastUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }

  @override
  Future<List<ChatEntity>> getMessages({
    required int ownerId,
    required int userId,
  }) async {
    try {
      final chatId = '${ownerId}_$userId';

      final querySnapshot = await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => ChatModel.fromFirestore(doc).toEntity())
          .toList();
    } catch (e) {
      throw Exception("Failed to get messages: $e");
    }
  }

  @override
  Stream<List<ChatEntity>> getMessagesStream({
    required int ownerId,
    required int userId,
  }) {
    final chatId = '${ownerId}_$userId';

    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatModel.fromFirestore(doc).toEntity())
        .toList());
  }
}
