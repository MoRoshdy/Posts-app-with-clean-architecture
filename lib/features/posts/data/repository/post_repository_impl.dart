// ignore_for_file: await_only_futures, prefer_generic_function_type_aliases

import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/error/exceptions.dart';
import 'package:posts_app_with_clean_architecture/core/error/failure.dart';
import 'package:posts_app_with_clean_architecture/core/network/network_info.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repository/posts_repository.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts =
            await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPost =
            await localDataSource.getCachedPosts();
        return Right(localPost);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );

    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return  const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
