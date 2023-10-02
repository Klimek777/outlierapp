import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result});
  final dynamic result;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _closePageWidget(),
          _sucessWidget(),
          _resultWidet(),
        ],
      ),
    ));
  }

  Widget _closePageWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 40,
            )),
      ],
    );
  }

  Widget _sucessWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Center(
        child: Text(
          "Odstająca liczba to:",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _resultWidet() {
    return Text(
      widget.result.toString(),
      style: const TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(255, 171, 45, 1)),
    );
  }
}
