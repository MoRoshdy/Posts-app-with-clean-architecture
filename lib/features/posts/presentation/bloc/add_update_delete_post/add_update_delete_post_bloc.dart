import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_with_clean_architecture/core/error/failure.dart';
import 'package:posts_app_with_clean_architecture/core/strings/failures.dart';
import 'package:posts_app_with_clean_architecture/core/strings/messages.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/update_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrSuccessMessage = await addPost(event.post);
        emit(_mapFailureOrSuccessMessageToState(failureOrSuccessMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrSuccessMessage = await updatePost(event.post);
        emit(_mapFailureOrSuccessMessageToState(failureOrSuccessMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePost());
        final failureOrSuccessMessage = await deletePost(event.postId);
        emit(_mapFailureOrSuccessMessageToState(failureOrSuccessMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }


  AddUpdateDeletePostState _mapFailureOrSuccessMessageToState(Either<Failure, Unit> either,String message) {
    return either.fold(
      (failure) =>
          ErrorAddUpdateDeletePost(message: _mapFailureToMessage(failure)),
      (_) => MessageAddUpdateDeletePost(message: message),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoInternetFailure:
        return NO_INTERNET_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , please try again later';
    }
  }
}
