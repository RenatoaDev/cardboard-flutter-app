import 'package:card_board/constants/strings.dart';
import 'package:card_board/home/view/home_view.dart';
import 'package:card_board/services/locator.dart';
import 'package:card_board/services/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final PreferenceService _preferenceService = getIt();
  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool usernameHasInteracted = false;

  @observable
  bool passwordHasInteracted = false;

  @computed
  bool get isUsernameValid =>
      (usernameHasInteracted &&
          username.isNotEmpty &&
          username.length <= 20 &&
          !username.endsWith(' ')) ||
      !usernameHasInteracted;

  @computed
  bool get isPasswordValid =>
      (passwordHasInteracted &&
          password.isNotEmpty &&
          password.length >= 2 &&
          password.length <= 20 &&
          !password.endsWith(' ') &&
          RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password)) ||
      !passwordHasInteracted;

  @computed
  bool get canLogin =>
      isUsernameValid &&
      isPasswordValid &&
      (usernameHasInteracted && passwordHasInteracted);

  @action
  void setUsername(String value) {
    username = value.trim();
    usernameHasInteracted = true;
  }

  @action
  void setPassword(String value) {
    password = value.trim();
    passwordHasInteracted = true;
  }

  Future<void> login(BuildContext context) async {
    if (canLogin) {
      _preferenceService.loginUser(username);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeView(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(AppStrings.loginErrorMessage),
      ));
    }
  }
}
