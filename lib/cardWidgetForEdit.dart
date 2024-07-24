import 'package:flutter/material.dart';

class CardWidgetForEdit extends StatefulWidget {
  const CardWidgetForEdit({Key? key}) : super(key: key);

  @override
  _CardWidgetForEditState createState() => _CardWidgetForEditState();
}

class _CardWidgetForEditState extends State<CardWidgetForEdit> {
  bool isEditing = false;
  TextEditingController _controller = TextEditingController();
  String _text = 'type smth...';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
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
                    controller: _controller,
                    onSubmitted: (newValue) {
                      setState(() {
                        _text = newValue;
                        isEditing = false;
                      });
                    },
                  )
                      : Text(_text),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        _text = _controller.text;
                      } else {
                        _controller.text = _text;
                      }
                      isEditing = !isEditing;
                    });
                  },
                ),

              ],
            ),
          ),

        ),
        SizedBox(height: 33,)
      ]
    );
  }
}
