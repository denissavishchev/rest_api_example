import 'package:flutter/material.dart';
import 'package:rest_api_example/models/api_response.dart';
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

  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;


  String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}.${dateTime.month}.${dateTime.day}';
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  _fetchNotes() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
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
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return const CircularProgressIndicator();
          }if (_apiResponse.error) {
            return Center(child: Text('$_apiResponse.errorMessage'),);
          }
          return ListView.separated(
            separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data?[index].noteID),
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
                  title: Text(_apiResponse.data[index].noteTitle),
                  subtitle: Text(
                      'Last edited on ${formatDateTime(_apiResponse.data[index].lastEditDateTime)}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)
                    => NoteModify(noteID: _apiResponse.data[index].noteID,)));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data!.length,
          );
        },
      )
    );
  }
}
