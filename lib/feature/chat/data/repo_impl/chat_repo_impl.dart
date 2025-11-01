import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/fire_base_failure.dart';
import 'package:monkey_app/feature/chat/data/model/chat_model.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:monkey_app/feature/chat/domain/repo/chat_repo.dart';
import '../data_source/remote_data_source.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepoImpl(this.remoteDataSource);

  static const int ownerId = 1;

  /// 🔹 إرسال الرسالة
  @override
  Future<Either<FireBaseFailure, Unit>> sendMessage({
    required ChatEntity message,
  }) async {
    try {
      final chatModel = ChatModel(
        name: message.name,
        id: message.id,
        lastUpdate: Timestamp.now(),
        timestamp: Timestamp.now(),
        isActive: true,
        seenMessage: false,
        messageIsSend: true,
        senderId: message.senderId,
        receiverId: message.receiverId,
        messageText: message.messageText,
      );

      await remoteDataSource.sendMessage(message: chatModel);
      return const Right(unit);
    } catch (error) {
      final failure = FirebaseErrorHandler.handleFirebaseError(error);
      return Left(failure);
    }
  }

  @override
  Future<Either<FireBaseFailure, List<ChatEntity>>> getMessages({
    required int ownerId,
    required int userId,
  }) async {
    try {
      final messages =
      await remoteDataSource.getMessages(ownerId: ownerId, userId: userId);
      return Right(messages);
    } catch (error) {
      final failure = FirebaseErrorHandler.handleFirebaseError(error);
      return Left(failure);
    }
  }

  @override
  Future<Either<FireBaseFailure, Stream<List<ChatEntity>>>> getMessagesStream({
    required int ownerId,
    required int userId,
  }) async {
    try {
      final stream =
      remoteDataSource.getMessagesStream(ownerId: ownerId, userId: userId);
      return Right(stream);
    } catch (error) {
      final failure = FirebaseErrorHandler.handleFirebaseError(error);
      return Left(failure);
    }
  }
}
