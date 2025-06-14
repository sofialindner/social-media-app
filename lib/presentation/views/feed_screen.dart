import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/presentation/providers/theme_provider.dart';
import 'package:social_media_app/presentation/themes/colors.dart';
import 'package:social_media_app/presentation/widgets/switch_button.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actionsPadding: EdgeInsets.all(9),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.darkOverlay,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Icon(Ionicons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ElevatedButton(
                  onPressed: () => (),
                  child: Text('Curtir'),
                ),
              ),
              SwitchButton(
                inactiveThumbIcon: Ionicons.sunny,
                activeThumbIcon: Ionicons.moon,
                onChanged: (bool value) {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
