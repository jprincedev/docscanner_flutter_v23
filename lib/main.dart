import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const DocScannerApp());
}

class DocScannerApp extends StatelessWidget {
  const DocScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocScanner',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ScannerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  File? _scannedImage;

  Future<void> _scanDocument() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final savedImage = await File(pickedFile.path).copy('${directory.path}/scanned_doc.png');

      setState(() {
        _scannedImage = savedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DocScanner')),
      body: Center(
        child: _scannedImage == null
            ? const Text('Peze bouton an pou w eskane yon dokiman.')
            : Image.file(_scannedImage!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanDocument,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
