import 'package:dartz/dartz.dart';
import 'package:monkey_app/core/errors/fire_base_failure.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';
import '../repo/chat_repo.dart';

class SendMessageUseCase {
  final ChatRepo repo;

  SendMessageUseCase({required this.repo});

  Future<Either<FireBaseFailure, Unit>> call({
    required ChatEntity message,
  }) async {
    return await repo.sendMessage(message: message);
  }
}
