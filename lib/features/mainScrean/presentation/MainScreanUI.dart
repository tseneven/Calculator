import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MainScreanUI extends StatefulWidget {
  _MainScreanUIState createState() => _MainScreanUIState();
}

class _MainScreanUIState extends State<MainScreanUI> {
  String text = "";
  String result = "";
  bool isPressed = false;

  Color colorDarkGrey = Color.fromARGB(255, 58, 58, 58);
  Color colorOrange = Colors.orange;
  Color colorLightGrey = Colors.grey;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        text = "";
        result = "";
      } else if (value == "=") {
        result = _calculate(text);
        isPressed = true;
      } else if(value == "D"){
        if(text.isNotEmpty) text = text.substring(0, text.length-1);
      }else {
        text += value;
        isPressed = false;
      }
    });
  }

  String _calculate(String input) {
  try {
    input = input.replaceAll('X', '*');
    input = input.replaceAll('%', '/100');

    Parser p = Parser();
    Expression exp = p.parse(input);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    if (eval == eval.toInt()) {
      return eval.toInt().toString();
    }

    return eval.toString();
  } catch (e) {
    return "Error";
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Expanded(
        child: Column(
          children: [
            _UpperResultWidget(
              isPressed: isPressed,
              text: text,
              result: result,
            ),
            Column(
              children: [
                SizedBox(height: 40),
                _ButtonRowsWidget(
                  symbols: ["C", "D", "%", "/"],
                  colors: [
                    colorLightGrey,
                    colorLightGrey,
                    colorLightGrey,
                    colorOrange,
                  ],
                  onTaps: [
                    () => _onButtonPressed("C"),
                    () => _onButtonPressed("D"),
                    () => _onButtonPressed("%"),
                    () => _onButtonPressed("/"),
                  ],
                ),
                _ButtonRowsWidget(
                  symbols: ["7", "8", "9", "x"],
                  colors: [
                    colorDarkGrey,
                    colorDarkGrey,
                    colorDarkGrey,
                    colorOrange,
                  ],
                  onTaps: [
                    () => _onButtonPressed("7"),
                    () => _onButtonPressed("8"),
                    () => _onButtonPressed("9"),
                    () => _onButtonPressed("X"),
                  ],
                ),
                _ButtonRowsWidget(
                  symbols: ["4", "5", "6", "-"],
                  colors: [
                    colorDarkGrey,
                    colorDarkGrey,
                    colorDarkGrey,
                    colorOrange,
                  ],
                  onTaps: [
                    () => _onButtonPressed("4"),
                    () => _onButtonPressed("5"),
                    () => _onButtonPressed("6"),
                    () => _onButtonPressed("-"),
                  ]
                ),
                _ButtonRowsWidget(
                  symbols: ["1", "2", "3", "+"],
                  colors: [
                    colorDarkGrey,
                    colorDarkGrey,
                    colorDarkGrey,
                    colorOrange,
                  ],
                  onTaps: [
                    () => _onButtonPressed("1"),
                    () => _onButtonPressed("2"),
                    () => _onButtonPressed("3"),
                    () => _onButtonPressed("+"),
                  ],
                ),
                _ButtonRowsWidget(
                  symbols: ["mode", "0", ".", "="],
                  colors: [
                    colorDarkGrey,
                    colorDarkGrey,
                    colorDarkGrey,
                    colorOrange,
                  ],
                  onTaps: [
                    () => _onButtonPressed("mode"),
                    () => _onButtonPressed("0"),
                    () => _onButtonPressed("."),
                    () => _onButtonPressed("="),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonRowsWidget extends StatelessWidget {
  final List<String> symbols;
  final List<Color> colors;
  final List<VoidCallback> onTaps;

  const _ButtonRowsWidget({
    super.key,
    required this.symbols,
    required this.colors,
    required this.onTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ButtonWidget(text: symbols[0], color: colors[0], onTap: onTaps[0]),
        _ButtonWidget(text: symbols[1], color: colors[1], onTap: onTaps[1]),
        _ButtonWidget(text: symbols[2], color: colors[2], onTap: onTaps[2]),
        _ButtonWidget(text: symbols[3], color: colors[3], onTap: onTaps[3]),
      ],
    );
  }
}

class _ButtonWidget extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _ButtonWidget({
    required this.text,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<_ButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: _isPressed ? widget.color.withOpacity(0.7) : widget.color,
            borderRadius: BorderRadius.circular(200),
            boxShadow:
                _isPressed
                    ? []
                    : [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _UpperResultWidget extends StatelessWidget {
  const _UpperResultWidget({
    super.key,
    required this.isPressed,
    required this.text,
    required this.result,
  });

  final bool isPressed;
  final String text;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 260,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DefaultSelectionStyle.defaultColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isPressed)
                Text('=', style: TextStyle(fontSize: 40, color: Colors.white)),
              Text(text, style: TextStyle(fontSize: 40, color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isPressed)
                Text(
                  result,
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
