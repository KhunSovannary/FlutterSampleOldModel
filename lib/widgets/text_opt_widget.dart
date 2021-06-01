import 'package:flutter/material.dart';

class TextOPTWidget extends StatelessWidget {

  TextOPTWidget({@required this.onChanged, @required this.autFocus,@required this.focusNode, this.textEditingController});

  final Function onChanged;
  final FocusNode focusNode;
  final bool autFocus;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.width * 0.15,
        child: TextField(
          controller: textEditingController,
          onChanged: onChanged,
          autofocus: autFocus,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,   // This is not so important
          ),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0)
          ),
        )
    );
  }
}
