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
