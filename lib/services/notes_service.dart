import 'dart:convert';

import 'package:rest_api_example/models/api_response.dart';
import '../models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {

  static const API = 'http://api.notes.devis.com';
  static const headers = {
    'apiKey': '0f0sh4368-4n56-3477-93nf-349jkk53h2'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$API/notes'), headers: headers)
        .then((data) {
          if (data.statusCode == 200) {
            final jsonData = jsonDecode(data.body);
            final notes = <NoteForListing>[];
            for (var item in jsonData) {
              final note = NoteForListing(
                  noteID: item['noteID'],
                  noteTitle: item['noteID'],
                  createDateTime: DateTime.parse(item['createDateTime']),
                  lastEditDateTime: DateTime.parse(item['latestEditDateTime']));
              notes.add(note);
            }
            return APIResponse<List<NoteForListing>>(data: notes, errorMessage: 'Error');
          }
          return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Error');
    }).catchError(() => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Error'));
  }
}