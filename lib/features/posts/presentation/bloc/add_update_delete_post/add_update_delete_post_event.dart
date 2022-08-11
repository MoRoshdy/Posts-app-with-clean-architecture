// ignore_for_file: prefer_const_constructors_in_immutables

part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostEvent extends Equatable {
  const AddUpdateDeletePostEvent();

  @override
  List<Object?> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent{
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent{
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent{
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
