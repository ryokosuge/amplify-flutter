import 'package:amplify_flutter_example/pages/camera_page.dart';
import 'package:amplify_flutter_example/pages/gallery_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlowPage extends StatefulWidget {
  final VoidCallback shouldLogOut;

  const CameraFlowPage({
    Key? key,
    required this.shouldLogOut,
  }) : super(key: key);

  @override
  _CameraFlowPageState createState() => _CameraFlowPageState();
}

class _CameraFlowPageState extends State<CameraFlowPage> {
  CameraDescription? _camera;
  bool _shouldShowCamera = false;

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final cameraList = await availableCameras();
    if (cameraList.isEmpty) {
      return;
    }

    setState(() {
      final firstCamera = cameraList.first;
      this._camera = firstCamera;
    });
  }

  List<MaterialPage> get _pages {
    return [
      // Show Gallery Page
      MaterialPage(
        child: GalleryPage(
          shouldLogOut: widget.shouldLogOut,
          shouldShowCamera: () {
            this._toggleCameraOpen(true);
          },
        ),
      ),
      // Show Camera Page
      if (_camera != null && _shouldShowCamera)
        MaterialPage(
            child: CameraPage(
                camera: _camera!,
                didProvideImagePath: (imagePath) {
                  this._toggleCameraOpen(false);
                })),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: this._pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
