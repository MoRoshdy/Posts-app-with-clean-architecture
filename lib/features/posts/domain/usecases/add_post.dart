import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/error/failure.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repository/posts_repository.dart';

class AddPostUseCase{
  final PostsRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}