import 'package:http/http.dart' as http;
import 'dart:typed_data';

class PredictedImage {
  Uint8List? imageBytes;
  Uint8List? prediction;
  Function update;

  PredictedImage({required this.update});

  Future<void> predict(String artist) async {
    if (imageBytes == null) return;

    final uri = Uri.parse("https://styletransferapi-production.up.railway.app/predict");

    // Convert the Uint8List to a file or directly use multipart for raw bytes
    var request = http.MultipartRequest('POST', uri);

    // Add the image as a multipart file
    request.files.add(http.MultipartFile.fromBytes('file', imageBytes!, filename: 'image.png'));

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      prediction = await response.stream.toBytes();
      update();      
    } 
  }
}
