import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/views/main_scaffold/feed/post_container.dart';

class PostList extends StatefulWidget {
  final List<Post> posts;
  final int? initialIndex;

  const PostList({super.key, required this.posts, this.initialIndex});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<GlobalKey> postKeys = List.empty();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex != null &&
          widget.initialIndex! < postKeys.length) {
        final key = postKeys[widget.initialIndex!];
        if (key.currentContext != null) {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posts.isEmpty) {
      return const Center(child: Text('Nenhuma publicação.'));
    }

    // Garante que a lista tenha a quantidade certa de chaves
    if (postKeys.length != widget.posts.length) {
      postKeys = List.generate(widget.posts.length, (_) => GlobalKey());
    }

    return ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return Padding(
          key: postKeys[index],
          padding: const EdgeInsets.only(bottom: 24.0),
          child: PostContainer(post: widget.posts[index]),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
