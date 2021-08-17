import 'dart:js';

import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  final VoidCallback shouldShowCamera;

  const GalleryPage({
    Key? key,
    required this.shouldLogOut,
    required this.shouldShowCamera,
  }) : super(key: key);

  Widget _galleryGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Placeholder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
