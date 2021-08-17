import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final StreamController<List<String>> imageUrlsController;
  final VoidCallback shouldLogOut;
  final VoidCallback shouldShowCamera;

  const GalleryPage({
    Key? key,
    required this.imageUrlsController,
    required this.shouldLogOut,
    required this.shouldShowCamera,
  }) : super(key: key);

  Widget _galleryGrid() {
    return StreamBuilder(
      stream: imageUrlsController.stream,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          final imageUrls = snapshot.data;
          if (imageUrls != null && imageUrls.length > 0) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No images to display.'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: shouldLogOut,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: shouldShowCamera,
      ),
      body: Container(
        child: _galleryGrid(),
      ),
    );
  }
}
