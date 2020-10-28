import 'package:firecek_stacked_architecture/ui/widgets/second_jnput_field.dart';
import 'package:flutter/material.dart';

class FMHeaderDetail extends StatelessWidget {
  final Function onTap, onSubmitted;
  final String initialData;
  final FocusNode _productNameFocusNode = FocusNode();
  FMHeaderDetail({this.initialData, this.onSubmitted, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => onTap()),
          ),
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SecondInputField(
                      height: 70,
                      width: 300,
                      fieldFocusNode: _productNameFocusNode,
                      initialData: initialData ?? 'empty',
                      onSubmitted: onSubmitted,
                      colorTheme: Colors.white,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage('assets/images/firemonitorAssets/header_fm.jpg'))),
    );
  }
}
