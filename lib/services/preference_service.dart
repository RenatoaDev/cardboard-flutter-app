import 'package:card_board/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PreferenceService {
  final SharedPreferences _preferences;
  static const String noteCounterKey = 'note_counter';
  static const String userLoggedInKey = 'user_logged_in';
  static const String usernameKey = 'username';
  static const String textKey = AppStrings.keyText;
  PreferenceService(this._preferences);

  Future<void> loginUser(String username) async {
    await _preferences.setBool(userLoggedInKey, true);
    await _preferences.setString(usernameKey, username);
  }

  Future<void> logoutUser() async {
    await _preferences.setBool(userLoggedInKey, false);
    await _preferences.remove(usernameKey);
    await _preferences.remove(noteCounterKey);
    await _preferences.remove(textKey);
  }

  bool isUserLoggedIn() {
    return _preferences.getBool(userLoggedInKey) ?? false;
  }

  String? getUsername() {
    return _preferences.getString(usernameKey);
  }

  Future<int> _incrementNoteCounter() async {
    int currentCounter = _preferences.getInt(noteCounterKey) ?? 0;
    int newCounter = currentCounter + 1;
    await _preferences.setInt(noteCounterKey, newCounter);
    return newCounter;
  }

  Future<Map<String, String>> addNoteToList(String key, String value) async {
    int noteId = await _incrementNoteCounter();
    List<Map<String, String>> notesList = getNotesList(key);
    Map<String, String> newNote = {
      'title': 'Texto digitado $noteId',
      'text': value
    };
    notesList.add(newNote);
    await saveNotesList(key, notesList);
    return newNote;
  }

  Future<void> updateTextInList(String key, int index, String text) async {
    List<Map<String, String>> notesList = getNotesList(key);

    if (index >= 0 && index < notesList.length) {
      Map<String, String> updatedNote = {
        'title': notesList[index]['title'] ?? '',
        'text': text
      };
      notesList[index] = updatedNote;
      await saveNotesList(key, notesList);
    }
  }

  Future<void> updateTitleInList(String key, int index, String title) async {
    List<Map<String, String>> notesList = getNotesList(key);

    if (index >= 0 && index < notesList.length) {
      Map<String, String> updatedNote = {
        'title': title,
        'text': notesList[index]['text'] ?? ''
      };
      notesList[index] = updatedNote;
      await saveNotesList(key, notesList);
    }
  }

  Future<void> removeNoteFromList(String key, int index) async {
    List<Map<String, String>> notesList = getNotesList(key);

    if (index >= 0 && index < notesList.length) {
      notesList.removeAt(index);
      await saveNotesList(key, notesList);
    }
  }

  Future<void> saveNotesList(
      String key, List<Map<String, String>> notesList) async {
    String jsonString = jsonEncode(notesList);
    await _preferences.setString(key, jsonString);
  }

  List<Map<String, String>> getNotesList(String key) {
    String? jsonString = _preferences.getString(key);
    if (jsonString == null) return [];
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => Map<String, String>.from(item)).toList();
  }
}
