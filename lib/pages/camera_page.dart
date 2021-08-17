import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final ValueChanged<String> didProvideImagePath;

  const CameraPage({
    Key? key,
    required this.camera,
    required this.didProvideImagePath,
  }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  void _takePicture() async {
    try {
      await _initializeControllerFuture;

      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now().millisecondsSinceEpoch}.png';
      final path = join(tmpDirectory.path, filePath);

      XFile? picture = await _controller?.takePicture();
      picture?.saveTo(path);
      widget.didProvideImagePath(path);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          final controller = this._controller;
          if (controller == null ||
              snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return CameraPreview(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _takePicture,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
