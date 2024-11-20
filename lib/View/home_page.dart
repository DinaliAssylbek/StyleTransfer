import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:style_transfer_webapp/Controller/predict.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PredictedImage pi;

  @override
  void initState() {
    super.initState();
    pi = PredictedImage(update: () {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 20, // 1/3 of screen width
              height: MediaQuery.of(context).size.height,
              child: Menu(predictedImage: pi,),
            ),
            const Spacer(),
            Container(
                  width: MediaQuery.of(context).size.width * 2 / 3 - 20,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  child: pi.prediction != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          pi.prediction!,
                          fit: BoxFit.contain, // Adjust image to fill the container
                        ),
                      )
                    : const Center(child: Text("No Output Image")),
                )
          ],
        ),
      ),
    );
  }
}