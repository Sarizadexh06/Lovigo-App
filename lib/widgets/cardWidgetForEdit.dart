import 'package:flutter/material.dart';

class CardWidgetForEdit extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CardWidgetForEdit({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  _CardWidgetForEditState createState() => _CardWidgetForEditState();
}

class _CardWidgetForEditState extends State<CardWidgetForEdit> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 80,
          child: Card(
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: isEditing
                      ? TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                    ),
                    onSubmitted: (newValue) {
                      setState(() {
                        isEditing = false;
                      });
                    },
                  )
                      : Text(widget.controller.text),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 33)
      ],
    );
  }
}
