import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {

  final String? noteID;
  bool get isEditing => noteID != null;

  NoteModify({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Note title'
              ),
            ),
            const SizedBox(height: 8,),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Note content'
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),),
            ),
          ],
        ),
      ),
    );
  }
}
