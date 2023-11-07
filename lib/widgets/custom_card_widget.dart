import 'package:card_board/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCardWidget extends StatelessWidget {
  final String? title;
  final String? text;
  final bool? edit;
  final bool? delete;
  final Function(String)? onTapEdit;
  final VoidCallback? onTapDelete;
  const CustomCardWidget({
    super.key,
    this.edit = false,
    this.delete = false,
    this.text,
    this.onTapDelete,
    this.title,
    this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomPaint(
        painter: SideCurvePainter(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (edit ?? false)
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                onTapEdit!(result);
                              },
                              color: const Color(0xff2b8a86),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'title',
                                  child: Text(
                                    AppStrings.title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'message',
                                  child: Text(
                                    AppStrings.message,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                              icon: SvgPicture.asset(AppStrings.svgEditPencil),
                              offset: const Offset(0, 40),
                            ),
                          if (edit ?? false)
                            IconButton(
                              icon: SvgPicture.asset(AppStrings.svgClose),
                              onPressed: onTapDelete,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black),
                ],
              ),
              Center(
                child: Text(
                  text ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}

class SideCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.quadraticBezierTo(-5, 0, -10, 40);
    path.lineTo(-10, size.height - 40);
    path.quadraticBezierTo(-5, size.height, 0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        size.width + 5, size.height, size.width + 10, size.height - 40);
    path.lineTo(size.width + 10, 40);
    path.quadraticBezierTo(size.width + 5, 0, size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
