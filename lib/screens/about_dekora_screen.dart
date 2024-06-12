import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';

class AboutDekoraScreen extends StatelessWidget {
  const AboutDekoraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              color: GlobalVariables.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'About Dekora',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontFamily: 'Laviossa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB44343), Color(0xFF737373)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Text(
              'Dekora is a sit amet consectetur. Eget sagittis in elementum orci nisl sit et leo rutrum. Vivamus tortor faucibus gravida posuere adipiscing libero. Aliquam suspendisse eget bibendum ultrices auctor sed. Accumsan neque a eu augue tincidunt. Accumsan egestas ullamcorper arcu mi. Ut neque molestie eu risus quis lorem volutpat etiam.\n\n'
              'Amet nisl sit placerat nunc ut sagittis aenean. Velit integer lobortis eu enim quis. Et auctor nisl vel aliquam felis nisl pulvinar euismod dignissim. Elementum pellentesque pharetra nec magna diam nec tristique aliquam sed. Adipiscing sed ullam tincidunt pellentesque neque. Etiam consequat pharetra volutpat eu ac arcu adipiscing scelerisque eget scelerisque sit ac. Urna orci non interdum eu. Venenatis tempor purus elementum eu volutpat tristique risus. Pharetra mattis pulvinar erat condimentum pellentesque porttitor felis suspendisse elementum. Ligula a pellentesque purus consectetur ac sit. Etiam pharetra volutpat auctor lorem amet lacus orci. In etiam sit sed urna hac. Aenean vitae platea et mauris congue pulvinar. Tortor dictum urna tellus quis eget habitant.\n\n'
              'Semper sagittis elit odio lacus. Quis malesuada molestie tellus sit mattis auctor amet augue. Et elit aliquet egestas arcu. Bibendum pellentesque eu in egestas egestas. Elementum nec nec sit tortor lectus sem quis. Pretium ultrices id sagittis vitae. Posuere gravida vitae sit pharetra id ut rhoncus.\n\n'
              'Elit eget mi quis placerat volutpat. Porttitor volutpat neque pulvinar fermentum nisl. Convallis et turpis egestas tincidunt sapien malesuada morbi. Posuere donec diam nulla aliquet tortor ornare cursus. Pellentesque pharetra urna neque ut nisl dapibus. Morbi nisl lorem gravida fringilla ullamcorper. Proin scelerisque quam aliquet dolore libero. Acupam vel pharetra dignissim libero justo sed iaculis nulla venenatis. Adipiscing sit aenean consectetur id congue mauris cras enim. Consequat arcu aliquet eu cursus arcu sit. Neque sed feugiat sapien at lacus venenatis. Cursus erat tellus orci ipsum nibh tellus at massa. Ut.',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
