part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
final class PostLoadingState extends PostState {}
final class PostSuccessState extends PostState {
  final SchoolModel schoolModel;

  PostSuccessState({required this.schoolModel});
}
final class PostFailureState extends PostState {
  final String errMessage;
  PostFailureState({required this.errMessage});
}
