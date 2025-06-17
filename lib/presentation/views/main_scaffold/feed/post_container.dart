import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/presentation/controllers/user_controller.dart';
import 'package:social_media_app/presentation/views/main_scaffold/profile/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/page_indicator.dart';
import 'package:social_media_app/presentation/widgets/profile_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostContainer extends StatefulWidget {
  final Post post;
  final bool? redirectToProfile;

  const PostContainer({super.key, required this.post, this.redirectToProfile});

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
  void initState() {
    super.initState();
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onTap: Navigator.canPop(context)
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(userId: widget.post.userId),
                    ),
                  );
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Row(
              spacing: 12.0,
              children: [
                ProfileImage(image: widget.post.userImage),
                Text(
                  widget.post.userName ?? 'Usuário',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
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

              // Nome de usuário e descrição do post
              Text.rich(
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  text: '${widget.post.userName}   ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: widget.post.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Horário de postagem
              Text(
                timeago.format(widget.post.createdAt, locale: 'pt_br'),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
