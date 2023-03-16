import 'package:flutter/material.dart';

import '../../helpers/theme.dart';

class CircularDropDownMenu extends StatefulWidget {
  final String hintText;
  final List<DropdownMenuItem> dropDownMenuItem;
  final dynamic onChanged;
  CircularDropDownMenu({
    required this.onChanged,
    required this.dropDownMenuItem,
    required this.hintText,
  });
  @override
  _CircularDropDownMenuState createState() => _CircularDropDownMenuState();
}

class _CircularDropDownMenuState extends State<CircularDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: widget.dropDownMenuItem,
          onChanged: widget.onChanged,
          hint: Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              widget.hintText,
              style: inputTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
