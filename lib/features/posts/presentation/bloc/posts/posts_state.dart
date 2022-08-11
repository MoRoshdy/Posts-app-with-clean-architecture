// ignore_for_file: prefer_const_constructors_in_immutables

part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadingPostsState extends PostsState{}

class LoadedPostsState extends PostsState{
  final List<Post> post;

  LoadedPostsState({required this.post});

  @override
  List<Object> get props => [post];
}

class FailedLoadingPostsState extends PostsState{
  final String message;

  FailedLoadingPostsState({required this.message});

  @override
  List<Object> get props => [message];
}