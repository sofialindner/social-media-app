import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/controllers/post_controller.dart';
import 'package:social_media_app/presentation/views/main_scaffold/feed/post_container.dart';
import 'package:social_media_app/presentation/widgets/custom_app_bar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = List.empty();
  bool _isLoading = false;

  _loadPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      posts = await getAllPostsRequest();
      setState(() {});
    } catch (e) {
      print('erro: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          // Botão de logout à direita da barra
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushReplacementNamed('/login');
            },
            icon: const Icon(CupertinoIcons.square_arrow_right),
            hoverColor: Colors.transparent,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: PostContainer(post: posts[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
