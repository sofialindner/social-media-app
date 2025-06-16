import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/themes/colors.dart';

class ProfileImage extends StatelessWidget {
  final Uint8List? image;
  final double? size;

  const ProfileImage({super.key, this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.memory(
              image!,
              height: size ?? 45,
              width: size ?? 45,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            alignment: Alignment.center,
            height: size ?? 45,
            width: size ?? 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightOverlay
                  : AppColors.darkOverlay,
            ),
            child: Icon(
              CupertinoIcons.person_fill,
              color: Theme.of(context).colorScheme.primary,
              size: size != null ? (size! - 20) : null,
            ),
          );
  }
}
