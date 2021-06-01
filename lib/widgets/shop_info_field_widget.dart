import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/widgets/text_field_widget.dart';

class ShopInfoWidget extends StatelessWidget {

  ShopInfoWidget({
    @required this.title,
    @required this.textFieldHint,
    @required this.controller,
    @required this.textFieldReadonly,
    @required this.image,
    @required this.icon
  });

  final String title;
  final String textFieldHint;
  final TextEditingController controller;
  final bool textFieldReadonly;
  final String image;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title ?? '', style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 14
          ),),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: image != null ?
                    Image.asset(image, scale: 2.4,) :
                    Icon(icon, size: 26, color: Colors.grey.shade700,)
              ),
              Expanded(
                flex: 6,
                child: InkWell(
                    child: TextFieldWidget(hintText: textFieldHint, readOnly: textFieldReadonly,)),
              )
            ],
          )
        ],
      ),
    );
  }
}
