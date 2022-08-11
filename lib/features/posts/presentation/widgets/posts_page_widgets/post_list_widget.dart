import 'package:flutter/material.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/pages/post_details_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text('${posts[index].id}'),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailPage(post: posts[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
      itemCount: posts.length,
    );
  }
}
