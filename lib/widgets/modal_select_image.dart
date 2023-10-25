import 'package:flutter/material.dart';

class ModalSelectImage extends StatefulWidget {
  const ModalSelectImage({Key? key}) : super(key: key);

  @override
  _ModalSelectImageState createState() => _ModalSelectImageState();
}

class _ModalSelectImageState extends State<ModalSelectImage> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () {
                    if (selectedImages.contains(index.toString())) {
                      setState(() {
                        selectedImages.remove(index.toString());
                      });
                    } else {
                      if (selectedImages.length < 5) {
                        setState(() {
                          selectedImages.add(index.toString());
                        });
                      } else {
                        // Show a message that maximum images are selected
                        // when the user tries to select more than 5 images.
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImages.contains(index.toString())
                            ? Colors.blue
                            : Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: Image.asset('assets/images/${index + 1}.png'),
                  ),
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform the desired action when the user selects images and taps the select button.
              // You can access the selectedImages list here.
              Navigator.pop(context);
            },
            child: Text('Select'),
          ),
        ],
      ),
    );
  }
}