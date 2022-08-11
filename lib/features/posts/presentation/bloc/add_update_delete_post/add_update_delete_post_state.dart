
part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeletePost extends AddUpdateDeletePostState {}

class MessageAddUpdateDeletePost extends AddUpdateDeletePostState {
  final String message;

  const MessageAddUpdateDeletePost({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorAddUpdateDeletePost extends AddUpdateDeletePostState {
  final String message;

  const ErrorAddUpdateDeletePost({required this.message});

  @override
  List<Object> get props => [message];
}

