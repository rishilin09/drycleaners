import 'package:drycleaners/Models/user.dart';

///For creating Invoice
class Invoice {
  final String title;
  final UserData userdata;
  final List<InvoiceItems> invoiceItems;
  final bool isDryCleaning;
  final String total;
  final DateTime date;

  Invoice({required this.title,required this.userdata,required this.invoiceItems,required this.isDryCleaning,required this.total,required this.date});
}

///For storing invoice items
class InvoiceItems{
  final String item;
  final String quantity;
  final String unitPrice;
  final String totalUnitPrice;

  const InvoiceItems({required this.item,required this.quantity,required this.unitPrice,required this.totalUnitPrice});
}

///For transferring values from SelectionPage to FinalPage
class Items {

  final bool isDryCleaning;
  final double total;
  final List<ItemDetails> itemDetails;

  const Items({required this.isDryCleaning,required this.total,required this.itemDetails});
}

class ItemDetails {

  final int quantity;
  final double priceX;
  final double totalUnitPrice;

  const ItemDetails({required this.quantity,required this.priceX,required this.totalUnitPrice});
}