import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewProductImage extends StatelessWidget {
  @override
  final String image;
  ViewProductImage(this.image);
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(backgroundColor:Colors.purple,),
        body: Card(child:CachedNetworkImage(imageUrl: image,),));
  }
}
