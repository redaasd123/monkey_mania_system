import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:monkey_app/feature/chat/domain/entity/chat_entity.dart';
import 'package:monkey_app/feature/chat/domain/use_case/get_message_use_case.dart';
import 'package:monkey_app/feature/chat/domain/use_case/send_message_use_case.dart';
import 'package:monkey_app/feature/users/domain/use_case/fetch_user_use_case.dart';
import '../../../../core/errors/fire_base_failure.dart';
import '../../../bills/main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../users/domain/entity/user_data_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessageUseCase getMessageUseCase;
  final FetchUserUseCase fetchUserUseCase;

  StreamSubscription<List<ChatEntity>>? _messagesSubscription;

  ChatCubit({
    required this.fetchUserUseCase,
    required this.sendMessageUseCase,
    required this.getMessageUseCase,
  }) : super(const ChatState());

  /// 📨 إرسال رسالة
  Future<void> sendMessage(ChatEntity message) async {
    if (isClosed) return;
    print('🚀 Trying to send message: ${message.messageText}');
    print('📤 Sender: ${message.senderId}, Receiver: ${message.receiverId}');

    emit(state.copyWith(status: ChatStatus.loading));

    final Either<FireBaseFailure, Unit> result = await sendMessageUseCase.call(
      message: message,
    );

    if (isClosed) return;

    result.fold(
          (failure) {
        print('❌ Sending failed: ${failure.message}');
        emit(state.copyWith(
          status: ChatStatus.failure,
          errorMessage: failure.message,
        ));
      },
          (_) {
        print('✅ Message sent successfully');
        emit(state.copyWith(status: ChatStatus.success));
      },
    );
  }


  Future<void> listenToMessages({
    required int ownerId,
    required int userId,
  }) async {
    if (isClosed) return;

    emit(state.copyWith(status: ChatStatus.loading));

    // لو في استماع سابق، الغيه بأمان
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;

    final result = await getMessageUseCase.getMessagesStream(
      ownerId: ownerId,
      userId: userId,
    );
    print("👂 Listening to chat between $ownerId and $userId");
    if (isClosed) return;

    result.fold(
          (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: ChatStatus.failure,
              errorMessage: failure.message,
            ),
          );
        }
      },
          (stream) {
        _messagesSubscription = stream.listen((messages) {
          if (!isClosed) {
            emit(
              state.copyWith(status: ChatStatus.success, messages: messages),
            );
          }
        }, onError: (e) {
          if (!isClosed) {
            emit(
              state.copyWith(status: ChatStatus.failure, errorMessage: e.toString()),
            );
          }
        });
      },
    );
  }


  /// 🧹 إلغاء الاستماع بأمان
  @override
  Future<void> close() async {
    try {
      await _messagesSubscription?.cancel();
    } catch (_) {}
    _messagesSubscription = null;
    return super.close();
  }
}
