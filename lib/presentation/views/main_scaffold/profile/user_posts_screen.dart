import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/views/main_scaffold/feed/post_list.dart';

class UserPostsScreen extends StatefulWidget {
  final List<Post> userPosts;
  final int? initialIndex;

  const UserPostsScreen({
    super.key,
    required this.userPosts,
    this.initialIndex,
  });

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publicações')),
      body: Column(
        children: [
          Expanded(
            child: PostList(
              posts: widget.userPosts,
              initialIndex: widget.initialIndex,
            ),
          ),
        ],
      ),
    );
  }
}
