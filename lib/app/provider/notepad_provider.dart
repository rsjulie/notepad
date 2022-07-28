import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:notepad/app/models/note_model.dart';

class NotepadProvider extends ChangeNotifier {
  final List<NoteModel> _notes = [NoteModel(id: 0, title: 'Test')];

  UnmodifiableListView<NoteModel> getnotes() {
    return UnmodifiableListView(_notes);
  }

  void addNote(NoteModel note) {
    note.id = _notes.length;
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(NoteModel note, int index) {
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
