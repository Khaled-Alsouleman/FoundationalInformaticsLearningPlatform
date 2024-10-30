import 'dart:math';

import 'package:foundational_learning_platform/core/utils/index.dart';
class AutomatonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0;


    Map<String, Offset> states = {
      'S0': const Offset(100, 100),
      'S1': const Offset(300, 100),
      'S2': const Offset(300, 300),
      'S3': const Offset(100, 300),
    };


    List<Map<String, dynamic>> transitions = [
      {'from': 'S0', 'input': '0', 'to': 'S3'},
      {'from': 'S0', 'input': '1', 'to': 'S1'},
      {'from': 'S1', 'input': '1', 'to': 'S2'},
      {'from': 'S1', 'input': '1', 'to': 'S1'},
      {'from': 'S2', 'input': '0', 'to': 'S3'},
      {'from': 'S2', 'input': '1', 'to': 'S1'},
      {'from': 'S3', 'input': '0', 'to': 'S3'}
    ];


    states.forEach((name, position) {
      drawState(canvas, paint, position, name);
    });


    for (var transition in transitions) {
      drawTransition(canvas, paint, states[transition['from']]!,
          states[transition['to']]!, transition['input']);
    }
  }


  void drawState(Canvas canvas, Paint paint, Offset position, String name) {
    const double width = 80;
    const double height = 40;
    final Rect rect = Rect.fromCenter(center: position, width: width, height: height);
    canvas.drawRect(rect, paint);


    final textPainter = TextPainter(
      text: TextSpan(
        text: name,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      position - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  // Methode zum Zeichnen eines Übergangs (Pfeil und Eingabesymbol)
  void drawTransition(Canvas canvas, Paint paint, Offset from, Offset to, String input) {
    final Paint arrowPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;


    canvas.drawLine(from, to, arrowPaint);


    final Offset midPoint = (from + to) / 2;
    final textPainter = TextPainter(
      text: TextSpan(
        text: input,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, midPoint - Offset(textPainter.width / 2, 20));


    final double arrowSize = 10;
    final double angle = (to - from).direction;
    final Offset arrowP1 = to - Offset(arrowSize * cos(angle - pi / 6), arrowSize * sin(angle - pi / 6));
    final Offset arrowP2 = to - Offset(arrowSize * cos(angle + pi / 6), arrowSize * sin(angle + pi / 6));

    Path arrowPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(arrowP1.dx, arrowP1.dy)
      ..lineTo(arrowP2.dx, arrowP2.dy)
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
