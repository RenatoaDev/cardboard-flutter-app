import 'package:card_board/constants/strings.dart';
import 'package:card_board/home/controller/home_store.dart';
import 'package:card_board/services/locator.dart';
import 'package:card_board/widgets/custom_card_widget.dart';
import 'package:card_board/widgets/custom_stack_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeStore store = getIt();

  @override
  void initState() {
    super.initState();
    store.loadTexts();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return CustomStackBackground(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(top: isKeyboardOpen ? 60 : 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: !isKeyboardOpen
                  ? (MediaQuery.of(context).size.height - kToolbarHeight)
                  : (MediaQuery.of(context).size.height / 2),
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (context) {
                    return Center(
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                          physics: store.textList.isEmpty
                              ? const NeverScrollableScrollPhysics()
                              : store.isEditable && store.indexSelected != -1
                                  ? const NeverScrollableScrollPhysics()
                                  : null,
                          controller: store.pageController,
                          onPageChanged: (value) => store.onPageChanged(value),
                          itemCount: store.textList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const CustomCardWidget();
                            }
                            final item = store.textList[index - 1];
                            return CustomCardWidget(
                              title: item['title'],
                              text: item['text'],
                              edit: true,
                              delete: true,
                              onTapEdit: (value) =>
                                  store.onEdit(index - 1, value),
                              onTapDelete: () =>
                                  store.onDelete(index - 1, context),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                  Observer(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 40),
                      child: store.isEditable
                          ? TextField(
                              controller: store.textEditingController,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) =>
                                  store.onTapTextEdit(value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: AppStrings.enterYourText,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            )
                          : Container(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
              onPressed: () => store.logout(context),
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              )),
        )),
      ],
    );
  }
}
