import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/network_constants.dart';

getAvatarImageWidget(String? imageUrl, Color defaultIconColor, double size) {
  return CachedNetworkImage(
    imageUrl: '${NetworkConstants().baseUrl}$imageUrl',
    imageBuilder: (context, imageProvider) => Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),),
    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => Icon(Icons.account_circle, color: defaultIconColor, size: size)
  );
}