import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/numbers_bloc_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String? textError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _inputWidget(textError),
                BlocBuilder<NumbersBloc, dynamic>(
                  builder: (context, state) {
                    if (state is String) {
                      return Text(
                        state,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buttonWiget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputWidget(String? errorMessage) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 8.0, left: 10, right: 10),
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            cursorColor: const Color.fromRGBO(255, 171, 45, 1),
            decoration: const InputDecoration(
              counterText: "",
              hintText: "Wpisz liczby...",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Color.fromRGBO(255, 171, 45, 1),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Color.fromRGBO(255, 171, 45, 1),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonWiget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          try {
            final listOfNumbers =
                textEditingController.text.split(',').map(int.parse).toList();

            final numbersBloc = BlocProvider.of<NumbersBloc>(context);
            numbersBloc.add(listOfNumbers);
            Navigator.pushNamed(context, '/result');
          } catch (e) {
            String errorMessage = "Spróbuj ponownie";
            final numbersBloc = BlocProvider.of<NumbersBloc>(context);
            numbersBloc.add(errorMessage);
          }
          textEditingController.clear();
        },
        minWidth: 70,
        height: 50,
        color: const Color.fromRGBO(255, 171, 45, 1),
        child: const Text(
          'Wyszukaj',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
