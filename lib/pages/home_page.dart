import 'package:flutter/material.dart';
import 'package:outlierapp/pages/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int>? listOfNumbers;
  double? _deviceHeight, _deviceWidth;
  TextEditingController textEditingController = TextEditingController();
  dynamic result;
  String? textError;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
      children: [
        _inputWidget(textError),
        _buttonWiget(),
      ],
    ));
  }

  Widget _inputWidget(String? errorMessage) {
    return Padding(
      padding: EdgeInsets.only(
          top: _deviceHeight! * 0.20, bottom: 8.0, left: 10, right: 10),
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            cursorColor: const Color.fromRGBO(255, 171, 45, 1),
            decoration: const InputDecoration(
              // hintStyle: GoogleFonts.kanit(),
              counterText: "",
              hintText: "Wpisz liczby...",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromRGBO(255, 171, 45, 1)),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromRGBO(255, 171, 45, 1)),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight:
                        FontWeight.w400), // Customize the error message style
              ),
            ),
        ],
      ),
    );
  }

  Widget _buttonWiget() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          try {
            listOfNumbers =
                textEditingController.text.split(',').map(int.parse).toList();

            Numbers numbers = Numbers();
            result = numbers.getResult(listOfNumbers!);
            result == "ERROR"
                ? throw Exception()
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultPage(result: result)));

            setState(() {
              textError = null;
              textEditingController.clear();
            });
          } catch (e) {
            String errorMessage = "Spróbuj ponownie";
            setState(() {
              textError = errorMessage;
            });
          }
        },
        minWidth: _deviceWidth! * 0.70,
        height: _deviceHeight! * 0.08,
        color: const Color.fromRGBO(255, 171, 45, 1),
        child: const Text(
          'Wyszukaj',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Numbers {
  dynamic checkNumbers(List<int> list) {
    int evenCount = 0;
    int oddCount = 0;
    int? resultNumber;
    String? error;
    try {
      for (int number in list) {
        if (number % 2 == 0) {
          evenCount++;
        } else {
          oddCount++;
        }
      }

      if (evenCount > oddCount && oddCount == 1) {
        for (int number in list) {
          if (number % 2 != 0) {
            resultNumber = number;
          }
        }
        return resultNumber;
      } else if ((evenCount < oddCount && evenCount == 1)) {
        for (int number in list) {
          if (number % 2 == 0) {
            resultNumber = number;
          }
        }
        return resultNumber;
      } else {
        error = "ERROR";

        return error;
      }
    } catch (e) {
      return error = "ERROR";
    }
  }

  dynamic getResult(List<int> list) {
    return checkNumbers(list);
  }
}
