import 'package:flutter/material.dart';
import 'package:dekora/global_variables.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

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
          'Terms and Conditions',
          style: TextStyle(
            color: GlobalVariables.primaryColor,
            fontFamily: 'Laviossa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Egestas pellentesque at fames sit senectus amet curabitur gravida. Quis scelerisque urna varius risus eu. Vel donec sed mattis purus. Nibh aliquam elementum felis egestas aliquam id. Sit odio non augue sit varius nulla. Mattis dui interdum imperdiet viverra. Turpis quis diam sed massa. Malesuada sem nunc vel velit morbi egestas arcu facilisi. Nisl lobortis morbi eu nec porttitor at justo amet vel. Justo et nisl porttitor egestas id lacus. Risus a sit purus lorem. Mauris viverra odio suscipit pulvinar et a at viverra. Risus lectus pellentesque dignissim eget egestas vulputate nibh molestie. Massa sed urna urna arcu aliquet dui.\n\n'
                'Fames ipsum sed vel nunc. Malesuada ut aenean libero pharetra eu maecenas porta nulla. Massa malesuada amet donec cras orci nisl velit. At nam sit vitae sit hac donec enim. Faucibus et faucibus placerat sit varius dignissim eu euismod. At leo volutpat libero bibendum mauris neque in. Augue vitae elementum id a enim lorem eget commodo dictum. Risus interdum a pharetra sit tempor adipiscing integer sed libero. Leo magna vitae consectetur mattis. In vitae id quam quam sapien metus habitant. Tortor quam nulla et a dui adipiscing morbi. A porttitor viverra consequat mollis magna.\n\n'
                'Lacus nec risus est eleifend. Nulla platea id congue id eget nunc non est. Praesent pulvinar ad condimentum rhoncus. Tempor convallis sit tincidunt neque tincidunt sit nisi senectus lorem. Feugiat ipsum nibh pulvinar suspendisse mollis faucibus.\n\n'
                'Sed tortor neque ac amet pharetra morbi commodo facilisis. Neque facilisis turpis mi et. Gravida amet scelerisque tortor odio vel eget egestas risus. Egestas sit amet scelerisque tortor ut. Ante at sed bibendum nunc ornare. Quam urna congue vulputate elementum egestas urna curabitur. Mi aliquet at egestas nisi ut ultricies diam. Sed tortor fringilla felis lorem.\n\n'
                'Neque varius sit lobortis nisl. Et penatibus sed ac ullamcorper euismod. Vitae sollicitudin platea lorem auctor arcu arcu. Arcu velit magna risus. Tellus sagittis tempor fames purus ultrices bibendum. Pharetra id quis quam amet. Dignissim adipiscing enim integer in massa suspendisse volutpat quisque. Nullam sagittis ut orci dolor sagittis sed condimentum. Nulla facilisis tellus quis id est. Eleifend non convallis et arcu ac ullamcorper.\n\n'
                'Tortor egestas fringilla. Egestas malesuada mi mi. Aliquam urna quam congue viverra ac posuere.',
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontFamily: 'SF Pro Display',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
