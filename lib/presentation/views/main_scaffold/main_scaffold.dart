import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/views/main_scaffold/feed/feed_screen.dart';
import 'package:social_media_app/presentation/views/main_scaffold/profile/profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Troca a tab atual com base no índice de argumento
  void _onItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index == _selectedIndex) {
        final navigator = _navigatorKeys[index].currentState;

        if (navigator != null && navigator.canPop()) {
          while (navigator.canPop()) {
            navigator.pop();
          }
        }
      }

      setState(() {
        _selectedIndex = index;
      });
    });
  }

  Future<bool> _onWillPop() async {
    if (_navigatorKeys[_selectedIndex].currentState!.canPop()) {
      _navigatorKeys[_selectedIndex].currentState!.pop();
      return false;
    }

    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0; // Volta para o Feed
      });
      // Impede o comportamento padrão de fechar o aplicativo
      return false;
    }
    // Permite fechar o aplicativo, se estiver no Feed
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Função que cria o navigator para cada tab, com base na Key e screen associados
    Widget buildTabNavigator(int index, Widget rootScreen) {
      return Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => rootScreen);
        },
      );
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            buildTabNavigator(0, const FeedScreen()),
            Container(),
            buildTabNavigator(2, ProfileScreen(userId: userProvider.user!.id!)),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium!.color!.withAlpha(40),
              border: Border(
                top: BorderSide(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withAlpha(40),
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0
                      ? const Icon(CupertinoIcons.house_fill, size: 22)
                      : const Icon(CupertinoIcons.house, size: 22),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? const Icon(CupertinoIcons.plus_square_fill)
                      : const Icon(CupertinoIcons.plus_square),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 2
                      ? const Icon(CupertinoIcons.person_circle_fill)
                      : const Icon(CupertinoIcons.person_circle),
                  label: 'Profile',
                ),
              ],
              unselectedFontSize: 10.0,
              selectedFontSize: 10.0,
              currentIndex: _selectedIndex,
              unselectedItemColor: Theme.of(
                context,
              ).textTheme.bodyMedium?.color!,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType
                  .fixed, // Evita o deslocamento dos ícones
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
