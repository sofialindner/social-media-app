import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/controllers/user_controller.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/widgets/page_indicator.dart';
import 'package:social_media_app/presentation/widgets/profile_image.dart';

class PostContainer extends StatefulWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  State<PostContainer> createState() => _PostContainer();
}

class _PostContainer extends State<PostContainer> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    Future<void> togglePostLike(Post post) async {
      try {
        if (post.liked == false) {
          await likePostRequest(userProvider.user!.id!, post.id!);
        } else {
          await dislikePostRequest(userProvider.user!.id!, post.id!);
        }

        widget.post.liked = !(widget.post.liked == true);
      } catch (e) {
        print('erro: $e');
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
        InkWell(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onDoubleTap: () => togglePostLike(widget.post),
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
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
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
