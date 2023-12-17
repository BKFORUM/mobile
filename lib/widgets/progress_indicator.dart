import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String gifUrl = 'https://res.cloudinary.com/dy7he6gby/image/upload/v1702484463/ioqhf86xbmyjmwo99hgw.png';

  CustomProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CachedNetworkImage(
            imageUrl: gifUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ).animate().shake(),
        ),
      ),
    );
  }
}