import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outlierapp/bloc/bloc/numbers_bloc_bloc.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

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
            BlocBuilder<NumbersBloc, dynamic>(
              builder: (context, state) {
                if (state != null && state != "Spróbuj ponownie") {
                  return _resultWidet(state.toString());
                } else {
                  Navigator.pop(context);
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
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
          ),
        ),
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

  Widget _resultWidet(String result) {
    return Text(
      result,
      style: const TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(255, 171, 45, 1),
      ),
    );
  }
}
