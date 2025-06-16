import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/controllers/user_controller.dart';
import 'package:social_media_app/presentation/views/main_scaffold/profile/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/page_indicator.dart';
import 'package:social_media_app/presentation/widgets/profile_image.dart';

class PostContainer extends StatefulWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  State<PostContainer> createState() => _PostContainer();
}

class _PostContainer extends State<PostContainer> {
  Future<void> _togglePostLike(Post post) async {
    try {
      if (post.liked == false) {
        await likePostRequest(post.id!);
      } else {
        await dislikePostRequest(post.id!);
      }

      widget.post.liked = !(widget.post.liked == true);
      setState(() {});
    } catch (e) {
      print('Erro ao dar like/dislike: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Row(
              spacing: 12.0,
              children: [
                ProfileImage(),
                Text(
                  widget.post.userName ?? 'Usuário',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(userId: widget.post.userId),
              ),
            );
          },
        ),
        InkWell(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onDoubleTap: () => _togglePostLike(widget.post),
          child: SizedBox(
            width: double.infinity,
            child: PageIndicator(
              images: widget.post.images
                  .map<Image>((img) => Image.memory(img, fit: BoxFit.cover))
                  .toList(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _togglePostLike(widget.post),
                    icon: widget.post.liked == true
                        ? Icon(CupertinoIcons.heart_fill)
                        : Icon(CupertinoIcons.heart),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.chat_bubble),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.paperplane),
                  ),
                ],
              ),
              Text(widget.post.description!),
            ],
          ),
        ),
      ],
    );
  }
}
