import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/fire_base_failure.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';

abstract class ChatRepo {
  /// 🔹 إرسال رسالة
  Future<Either<FireBaseFailure, Unit>> sendMessage({
    required ChatEntity message,
  });

  /// 🔹 جلب الرسائل مرة واحدة (مش لحظي)
  Future<Either<FireBaseFailure, List<ChatEntity>>> getMessages({
    required int ownerId,
    required int userId,
  });

  /// 🔹 الاستماع للرسائل في الوقت الفعلي (real-time)
  Future<Either<FireBaseFailure, Stream<List<ChatEntity>>>> getMessagesStream({
    required int ownerId,
    required int userId,
  });
}
