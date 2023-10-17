import 'package:bloc/bloc.dart';

class NumbersBloc extends Bloc<dynamic, dynamic> {
  NumbersBloc() : super(null) {
    on<List<int>>((listOfNumbers, emit) {
      try {
        final result = getResult(listOfNumbers);
        emit(result);
      } catch (e) {
        emit("Spróbuj ponownie");
      }
    });
    on<String>((errorMessage, emit) {
      print(errorMessage);
      emit(errorMessage);
    });
  }

  dynamic getResult(List<int> list) {
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
      } else if (evenCount < oddCount && evenCount == 1) {
        for (int number in list) {
          if (number % 2 == 0) {
            resultNumber = number;
          }
        }
        return resultNumber;
      } else {
        error = "Spróbuj ponownie";
        return error;
      }
    } catch (e) {
      return error = "Spróbuj ponownie";
    }
  }
}
