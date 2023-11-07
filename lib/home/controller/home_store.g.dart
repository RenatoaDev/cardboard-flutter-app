// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isEditableAtom =
      Atom(name: 'HomeStoreBase.isEditable', context: context);

  @override
  bool get isEditable {
    _$isEditableAtom.reportRead();
    return super.isEditable;
  }

  @override
  set isEditable(bool value) {
    _$isEditableAtom.reportWrite(value, super.isEditable, () {
      super.isEditable = value;
    });
  }

  late final _$indexSelectedAtom =
      Atom(name: 'HomeStoreBase.indexSelected', context: context);

  @override
  int get indexSelected {
    _$indexSelectedAtom.reportRead();
    return super.indexSelected;
  }

  @override
  set indexSelected(int value) {
    _$indexSelectedAtom.reportWrite(value, super.indexSelected, () {
      super.indexSelected = value;
    });
  }

  late final _$textListAtom =
      Atom(name: 'HomeStoreBase.textList', context: context);

  @override
  ObservableList<Map<String, String>> get textList {
    _$textListAtom.reportRead();
    return super.textList;
  }

  @override
  set textList(ObservableList<Map<String, String>> value) {
    _$textListAtom.reportWrite(value, super.textList, () {
      super.textList = value;
    });
  }

  late final _$addTextAsyncAction =
      AsyncAction('HomeStoreBase.addText', context: context);

  @override
  Future<void> addText(String value) {
    return _$addTextAsyncAction.run(() => super.addText(value));
  }

  late final _$updateTextAsyncAction =
      AsyncAction('HomeStoreBase.updateText', context: context);

  @override
  Future<void> updateText(String title) {
    return _$updateTextAsyncAction.run(() => super.updateText(title));
  }

  late final _$updateTitleAsyncAction =
      AsyncAction('HomeStoreBase.updateTitle', context: context);

  @override
  Future<void> updateTitle(String title) {
    return _$updateTitleAsyncAction.run(() => super.updateTitle(title));
  }

  late final _$loadTextsAsyncAction =
      AsyncAction('HomeStoreBase.loadTexts', context: context);

  @override
  Future<void> loadTexts() {
    return _$loadTextsAsyncAction.run(() => super.loadTexts());
  }

  late final _$logoutAsyncAction =
      AsyncAction('HomeStoreBase.logout', context: context);

  @override
  Future<void> logout(BuildContext context) {
    return _$logoutAsyncAction.run(() => super.logout(context));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void onEdit(int index, String value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.onEdit');
    try {
      return super.onEdit(index, value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPageChanged(int index) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.onPageChanged');
    try {
      return super.onPageChanged(index);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEditable: ${isEditable},
indexSelected: ${indexSelected},
textList: ${textList}
    ''';
  }
}
