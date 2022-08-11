import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/error/failure.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repository/posts_repository.dart';

class UpdatePostUseCase{
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}