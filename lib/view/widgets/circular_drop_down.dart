import 'package:flutter/material.dart';

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
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.only(top: 16),
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
              style: TextStyle(
                fontFamily: 'Muli',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
