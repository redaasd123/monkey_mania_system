import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/fire_base_failure.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';
import '../repo/chat_repo.dart';

class GetMessageUseCase {
  final ChatRepo repo;

  GetMessageUseCase({required this.repo});

  /// 🔹 جلب الرسائل مرة واحدة (مش لحظي)
  Future<Either<FireBaseFailure, List<ChatEntity>>> call({
    required int ownerId,
    required int userId,
  }) async {
    return await repo.getMessages(ownerId: ownerId, userId: userId);
  }

  /// 🔹 الاستماع للرسائل في الوقت الفعلي (real-time)
  Future<Either<FireBaseFailure, Stream<List<ChatEntity>>>> getMessagesStream({
    required int ownerId,
    required int userId,
  }) async {
    return await repo.getMessagesStream(ownerId: ownerId, userId: userId);
  }
}
