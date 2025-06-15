import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:social_media_app/presentation/themes/colors.dart';

class ProfileImage extends StatelessWidget {
  final Uint8List? image;

  const ProfileImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.memory(
              image!,
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            alignment: Alignment.center,
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkOverlay,
            ),
            child: Icon(
              CupertinoIcons.person_fill,
              color: AppColors.primaryColor,
            ),
          );
  }
}
