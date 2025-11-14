import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/avatar_config.dart';

class AvatarPreview extends StatelessWidget {
  final AvatarConfig config;
  final double size;

  const AvatarPreview({super.key, required this.config, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: config.avatarUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: size * 0.3,
            height: size * 0.3,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.grey[400]!,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
