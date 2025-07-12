import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:style_transfer_webapp/Controller/predict.dart';

class Menu extends StatefulWidget {
  PredictedImage predictedImage;
  Menu({required this.predictedImage, super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String? _item = 'Vincent Van Gogh';
  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>['Vincent Van Gogh','Claude Monet', 'Edvard Munch'];
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Art Style Transfer Project", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text("Dinali Assylbek", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                  ],
                ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Pick and Artist", style: TextStyle(fontSize: 18)),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(15.0))),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _item = value;
                    });
                  },
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item)
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Select A File", style: TextStyle(fontSize: 18)),
                    ),
                    IconButton(
                      onPressed:  () async {
                        var picked = await FilePicker.platform.pickFiles();

                        if (picked != null && picked.files.first.bytes != null) {
                          setState(() {
                            widget.predictedImage.imageBytes = picked.files.first.bytes;
                          });
                        }
                      }, 
                      icon: const Icon(Icons.attach_file)
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  child: widget.predictedImage.imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          widget.predictedImage.imageBytes!,
                          fit: BoxFit.contain, // Adjust image to fill the container
                        ),
                      )
                    : const Center(child: Text("No Image Selected")),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,  // Makes the button fill the width
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                onPressed: () async {
                  await widget.predictedImage.predict(_item);
                  setState(() {
                    
                  });
                },
                child: const Text('Transfer'),
              ),
            )
          ],
        )
    );
  }
}
