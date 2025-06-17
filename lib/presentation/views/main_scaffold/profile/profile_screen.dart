import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/post_controller.dart';
import 'package:social_media_app/presentation/controllers/user_controller.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController scrollController = ScrollController();
  User? user;
  List<Post> posts = List.empty();
  bool isLoading = true;

  Future<void> _followUser() async {
    try {
      user!.follows!
          ? await unfollowUserRequest(widget.userId)
          : await followUserRequest(widget.userId);

      await _loadUser();
      setState(() {});
    } catch (e) {
      print('Erro ao seguir usuário: $e');
    }
  }

  Future<void> _loadUser() async {
    try {
      user = await getUserProfileRequest(widget.userId);
    } catch (e) {
      print('Erro ao carregar usuário: $e');
    }
  }

  Future<void> _loadUserPosts() async {
    try {
      posts = await getPostsFromUserRequest(widget.userId);
    } catch (e) {
      print('Erro ao carregar posts: $e');
    }
  }

  Future<void> _firstLoad() async {
    await _loadUser();
    await _loadUserPosts();

    setState(() => isLoading = false);
  }

  Future<void> _refresh() async {
    await _loadUser();
    await _loadUserPosts();
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.name ?? 'Usuário', style: TextStyle(fontSize: 20)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: posts.isEmpty
                  ? const Center(child: Text('Usuário não encontrado.'))
                  : Column(
                      children: [
                        // Informações do usuário
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            children: [
                              ProfileImage(image: user?.image, size: 80),
                              const SizedBox(width: 12.0),

                              // Credenciais: nome e e-mail
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          user!.name!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Text(
                                          user!.email!,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color!
                                                .withAlpha(125),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),

                                    // Indicadores do usuário: seguidores, etc.
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildCounter(
                                            '${posts.length}',
                                            'Publicações',
                                          ),
                                          _buildCounter(
                                            '${user?.followersCount ?? 0}',
                                            'Seguidores',
                                          ),
                                          _buildCounter(
                                            '${user?.followingCount ?? 0}',
                                            'Seguindo',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // Botão de 'Seguir'
                        if (widget.userId != userProvider.user?.id!)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 32,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          user!.follows!
                                              ? Colors.transparent
                                              : null,
                                        ),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  6.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () => _followUser(),
                                      child: Text(
                                        user!.follows! ? 'Seguindo' : 'Seguir',
                                        style: TextStyle(
                                          color: user!.follows!
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                              : Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),

                                Spacer(),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12.0),

                        // Publicações
                        Container(
                          height: 1,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.color!.withAlpha(40),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return Image.memory(
                                posts[index].images[0],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}

Widget _buildCounter(String value, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      Text(label),
    ],
  );
}
