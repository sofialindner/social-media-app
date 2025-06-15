import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/controllers/post_controller.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/views/feed/post_container.dart';
import 'package:social_media_app/presentation/widgets/profile_image.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          fit: BoxFit.cover,
          width: 80,
          'https://vertigo.com.br/wp-content/uploads/2023/08/neo4j-1024x512.png',
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1.0, color: Colors.white10),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12.0),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(32.0),
            onTap: () => print(userProvider.user?.toJson()),
            child: ProfileImage(),
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
