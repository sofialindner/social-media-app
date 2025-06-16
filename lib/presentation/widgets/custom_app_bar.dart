import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor.withAlpha(60),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(color: Colors.transparent),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading
          if (leading != null) leading!,
          if (leading == null)
            Image.network(
              Theme.of(context).brightness == Brightness.light
                  ? 'https://mostlovedworkplace.com/wp-content/uploads/2024/01/logo-fullcolor-RGB-transBG.png'
                  : 'https://vertigo.com.br/wp-content/uploads/2023/08/neo4j-1024x512.png',
              width: 70,
              fit: BoxFit.cover,
            ),

          // Title
          if (title != null)
            Expanded(
              child: Center(
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

          // Actions
          SizedBox(
            width: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [if (actions != null) ...actions!],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
