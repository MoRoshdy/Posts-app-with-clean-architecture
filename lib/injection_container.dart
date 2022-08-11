import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_with_clean_architecture/core/network/network_info.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/repository/post_repository_impl.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repository/posts_repository.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts

  // Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
        addPost: sl(),
        updatePost: sl(),
        deletePost: sl(),
      ));

  // Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  // Repository

  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data_Sources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(clint: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
