import 'package:card_board/constants/strings.dart';
import 'package:card_board/login/view/login_view.dart';
import 'package:card_board/services/locator.dart';
import 'package:card_board/services/preference_service.dart';
import 'package:card_board/widgets/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final PreferenceService _preferenceService = getIt();
  PageController pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  TextEditingController textEditingController = TextEditingController();

  @observable
  bool isEditable = true;

  bool titleEditable = false;

  @observable
  int indexSelected = -1;

  @observable
  ObservableList<Map<String, String>> textList =
      ObservableList<Map<String, String>>();

  void onTapTextEdit(String value) {
    if (value.trim().isEmpty) return;

    if (indexSelected == -1) {
      addText(value);
    } else {
      if (titleEditable) {
        updateTitle(value);
      } else {
        updateText(value);
      }
      titleEditable = false;
      isEditable = false;
    }
  }

  @action
  Future<void> addText(String value) async {
    Map<String, String> newNote =
        await _preferenceService.addNoteToList(AppStrings.keyText, value);
    textList.add(newNote);
    textEditingController.text = '';
    pageController.jumpToPage(textList.length + 1);
  }

  @action
  Future<void> updateText(String title) async {
    if (titleEditable) {}
    await _preferenceService.updateTextInList(
        AppStrings.keyText, indexSelected, title);
    loadTexts();
  }

  @action
  Future<void> updateTitle(String title) async {
    if (titleEditable) {}
    await _preferenceService.updateTitleInList(
        AppStrings.keyText, indexSelected, title);
    loadTexts();
  }

  @action
  Future<void> loadTexts() async {
    textList.clear();
    final loadedTexts = _preferenceService.getNotesList(AppStrings.keyText);
    textList = ObservableList.of(loadedTexts);
  }

  @action
  void onEdit(int index, String value) {
    if (value == 'title') {
      titleEditable = true;
      textEditingController.text = textList[index]['title'] ?? '';
    } else {
      titleEditable = false;
      textEditingController.text = textList[index]['text'] ?? '';
    }
    indexSelected = index;
    isEditable = true;
  }

  Future<void> onDelete(int index, BuildContext context) async {
    final action = await MessageDialog.show(context,
        message: AppStrings.deleteMessage, isDestructiveAction: true);
    if (action == DialogAction.confirm) {
      await _preferenceService.removeNoteFromList(AppStrings.keyText, index);
      loadTexts();
      isEditable = false;
      titleEditable = false;
    }
  }

  @action
  void onPageChanged(int index) {
    if (index == 0) {
      indexSelected = -1;
      textEditingController.text = '';
      isEditable = true;
      return;
    }

    isEditable = false;
  }

  @action
  Future<void> logout(BuildContext context) async {
    DialogAction? action = await MessageDialog.show(context,
        message: AppStrings.logoutMessage, isDestructiveAction: true);
    if (action == DialogAction.confirm) {
      _preferenceService.logoutUser();

      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginView(),
      ));
    }
  }
}
