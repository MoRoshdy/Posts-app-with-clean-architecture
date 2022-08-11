import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/error/failure.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repository/posts_repository.dart';

class DeletePostUseCase{
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}