import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/presentation/providers/theme_provider.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/views/feed_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Builder(
      builder: (context) {
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(brightness: brightness),
            ),
            ChangeNotifierProvider(
              create: (_) {
                UserProvider userProvider = UserProvider();

                // Carrega os dados do usuário ao iniciar
                userProvider.loadUser();
                return userProvider;
              },
            ),
          ],
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        //'/': (context) => const InitialScreen(),
        //'/login': (context) => const LoginScreen(),
        '/': (context) => const FeedScreen(),
      },
    );
  }
}
