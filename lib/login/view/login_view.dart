import 'package:card_board/constants/strings.dart';
import 'package:card_board/login/controller/login_store.dart';
import 'package:card_board/privacy_policy/view/privacy_policy_view.dart';
import 'package:card_board/services/locator.dart';
import 'package:card_board/widgets/custom_stack_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = getIt();

    return CustomStackBackground(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppStrings.user,
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
                const SizedBox(height: 10.0),
                Observer(
                  builder: (_) => TextField(
                    onChanged: loginStore.setUsername,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: Colors.black,
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorStyle: const TextStyle(
                        color: Color.fromARGB(255, 233, 117, 108),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      errorText: !loginStore.isUsernameValid
                          ? AppStrings.invalidUsername
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.password,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 10.0),
                Observer(
                  builder: (_) => TextField(
                    onChanged: loginStore.setPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorStyle: const TextStyle(
                        color: Color.fromARGB(255, 233, 117, 108),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      errorText: !loginStore.isPasswordValid
                          ? AppStrings.invalidPassword
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Observer(
                  builder: (_) => ElevatedButton(
                    onPressed: loginStore.canLogin
                        ? () => loginStore.login(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 15.0),
                    ),
                    child: const Text(AppStrings.login),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30.0,
          left: 0,
          right: 0,
          child: Center(
            child: TextButton(
              child: const Text(AppStrings.privacyPolicy,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyView(),
                  fullscreenDialog: true,
                ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
