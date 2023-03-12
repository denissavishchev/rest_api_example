import 'package:flutter/material.dart';
import 'package:rest_api_example/models/note_for_listing.dart';
import 'package:rest_api_example/views/note_delete.dart';
import 'package:rest_api_example/views/note_modify.dart';
import 'package:get_it/get_it.dart';
import '../services/notes_service.dart';

class NoteList extends StatefulWidget {
  NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  List<NoteForListing> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}.${dateTime.month}.${dateTime.day}';
  }

  @override
  void initState() {
    super.initState();
    notes = service.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of Notes')),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteModify()));
          },
              child: const Icon(Icons.add)),
      body: ListView.separated(
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.green),
        itemBuilder: (_, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {

            },
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context,
                  builder: (_) => const NoteDelete());
              return result;
            },
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white,),),
            ),
            child: ListTile(
              title: Text(notes[index].noteTitle),
              subtitle: Text(
                  'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)
                => NoteModify(noteID: notes[index].noteID,)));
              },
            ),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
