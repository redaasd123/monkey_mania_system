part of 'chat_cubit.dart';

enum ChatStatus { initial, loading, success, failure , empty, searchLoading }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatEntity> messages;
  final List<UserDataEntity>? data;
  final String? errorMessage;
  final int? openedChatUserId;
  final bool isSearching;
  final String searchQuery;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;

  const ChatState({
    this.data = const [],
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.errorMessage,
    this.openedChatUserId,
    this.isSearching = false,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoading = false,
  });

  ChatState copyWith({
    List<UserDataEntity>? data,
    ChatStatus? status,
    List<ChatEntity>? messages,
    String? errorMessage,
    int? openedChatUserId,
    bool? isSearching,
    String? searchQuery,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
  }) {
    return ChatState(
      data: data ?? this.data,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      openedChatUserId: openedChatUserId ?? this.openedChatUserId,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    data,
    status,
    messages,
    errorMessage,
    openedChatUserId,
    isSearching,
    searchQuery,
    currentPage,
    hasMore,
    isLoading,
  ];
}
