import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  final cameras = await availableCameras();


  final firstCamera = cameras.first;

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: TakePictureScreen(camera: firstCamera),
  ));
}


class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

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
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prendre la Photo')),
   
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return Center(child: CircularProgressIndicator()); // Otherwise, display a loading indicator
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),

        onPressed: () async {
          try {
            await _initializeControllerFuture;


            final isCostly = true; 

        
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isCostly ? "Objet de valeur" : "Objet sans valeur")));
          } catch (e) {
            print(e); 
          }
        },
      ),
    );
  }
}
