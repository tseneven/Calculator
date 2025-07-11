import 'package:flutter/material.dart';

class MainScreanUI extends StatefulWidget {
  _MainScreanUIState createState() => _MainScreanUIState();
}

class _MainScreanUIState extends State<MainScreanUI> {
  static String text = "";
  static String result = "";
  bool isPressed = false;

  Color colorDarkGrey = Color.fromARGB(255, 58, 58, 58); 
  Color colorOrange = Colors.orange;
  Color colorLightGrey = Colors.grey;

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
                _ButtonRowsWidget(symbols: ["C", "D", "%", "/"], colors: [colorLightGrey, colorLightGrey, colorLightGrey, colorOrange],),
                _ButtonRowsWidget(symbols: ["7", "8", "9", "X"], colors: [colorDarkGrey, colorDarkGrey, colorDarkGrey, colorOrange],),
                _ButtonRowsWidget(symbols: ["4", "5", "6", "-"], colors: [colorDarkGrey, colorDarkGrey, colorDarkGrey, colorOrange],),
                _ButtonRowsWidget(symbols: ["1", "2", "3", "+"], colors: [colorDarkGrey, colorDarkGrey, colorDarkGrey, colorOrange],),
                _ButtonRowsWidget(symbols: ["mode", "0", ".", "="], colors: [colorDarkGrey, colorDarkGrey, colorDarkGrey, colorOrange],),
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

  const _ButtonRowsWidget({super.key, required this.symbols, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ButtonWidget(text: symbols[0], color: colors[0]),
        _ButtonWidget(text: symbols[1], color: colors[1]),
        _ButtonWidget(text: symbols[2], color: colors[2] ),
        _ButtonWidget(text: symbols[3], color: colors[3]),
      ],
    );
  }
}

class _ButtonWidget extends StatefulWidget {
  final String text;
  final Color color;

  const _ButtonWidget({required this.text, required this.color, Key? key}) : super(key: key);

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
          // Здесь ты можешь вызывать какую-нибудь функцию
          print("Нажата кнопка: ${widget.text}");
          // Пример: если "=" — показать результат
          if (widget.text == "=") {
            setState(() {
              // Тебе нужно вызвать что-то во внешнем MainScreenUI
              // Пока просто для примера
            });
          }
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
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
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