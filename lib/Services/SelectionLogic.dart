import 'package:flutter/cupertino.dart';

///ChangeNotifier will help to change the state of the SelectionPage
class PayingServices with ChangeNotifier {
  ///Declarations and Initializations
  double _totalShirtPay = 0.0;
  double _totalTrousersPay = 0.0;
  double _totalSareePay = 0.0;

  ///Quantity of items
  int _noOfShirts = 0;
  int _noOfTrousers = 0;
  int _noOfSarees = 0;

  ///Ironing price of shirt, trousers, and saree is 7, 7, and 20 rupees each
  double _iShirtPriceX = 7.0;
  double _iTrousersPriceX = 7.0;
  double _iSareePriceX = 20.0;

  ///DryCleaning price of shirt, trousers, and saree is 25, 25, and 60 rupees each
  double _dShirtPriceX = 25.0;
  double _dTrousersPriceX = 25.0;
  double _dSareePriceX = 60.0;

  bool _isDryCleaning = false;

  ///This function will calculate total cost of total n.o of shirts provided as String values
  ///in SelectionPage Shirt TextFormField
  void shirtCalculate(String counter, bool isDryCleaning) {
    counter = counter.isEmpty ? '0' : counter;
    _noOfShirts = int.parse(counter);
    _totalShirtPay = isDryCleaning
        ? (_dShirtPriceX * double.parse(counter))
        : (_iShirtPriceX * double.parse(counter));
    _isDryCleaning = isDryCleaning;
    notifyListeners();
  }

  ///This function will calculate total cost of total n.o of trousers provided as String values
  ///in SelectionPage Trousers TextFormField
  void trousersCalculate(String counter, bool isDryCleaning) {
    counter = counter.isEmpty ? '0' : counter;
    _noOfTrousers = int.parse(counter);
    _totalTrousersPay = isDryCleaning
        ? (_dTrousersPriceX * double.parse(counter))
        : (_iTrousersPriceX * double.parse(counter));
    _isDryCleaning = isDryCleaning;
    notifyListeners();
  }

  ///This function will calculate total cost of total n.o of saree provided as String values
  ///in SelectionPage Saree TextFormField
  void sareeCalculate(String counter, bool isDryCleaning) {
    counter = counter.isEmpty ? '0' : counter;
    _noOfSarees = int.parse(counter);
    _totalSareePay = isDryCleaning
        ? (_dSareePriceX * double.parse(counter))
        : (_iSareePriceX * double.parse(counter));
    _isDryCleaning = isDryCleaning;
    notifyListeners();
  }

  ///Bool value to check whether DryCleaning or Ironing
  bool get isDryCleaning => _isDryCleaning;

  ///Quantity of Shirts
  int get noOfShirts => _noOfShirts;

  ///Quantity of Trousers
  int get noOfTrousers => _noOfTrousers;

  ///Quantity of Sarees
  int get noOfSarees => _noOfSarees;

  ///UnitPrice of Shirt
  double get shirtPriceX => isDryCleaning ? _dShirtPriceX : _iShirtPriceX;

  ///UnitPrice of Trousers
  double get trousersPriceX =>
      isDryCleaning ? _dTrousersPriceX : _iTrousersPriceX;

  ///UnitPrice of Saree
  double get sareePriceX => isDryCleaning ? _dSareePriceX : _iSareePriceX;

  ///Total cost of all clothes
  double get totalPay => (_totalShirtPay + _totalTrousersPay + _totalSareePay);

  ///Total cost of total n.o of shirts
  double get totalShirtPay => _totalShirtPay;

  ///Total cost of total n.o of trousers
  double get totalTrousersPay => _totalTrousersPay;

  ///Total cost of total n.o of saree
  double get totalSareePay => _totalSareePay;
}
