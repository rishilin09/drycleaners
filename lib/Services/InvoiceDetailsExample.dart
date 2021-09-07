//import 'package:drycleaners/Services/Invoice/PdfApi.dart';
import 'package:drycleaners/projectImports.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
//import 'Invoice/PdfInvoice.dart';


class MessageSend extends StatelessWidget {

  final Telephony telephony = Telephony.instance;
  final bool isDryCleaning = false;
  final String fullName = 'Rishikesh Lingayat';
  final double shirt = 2.0;
  final double trouser = 2.0;
  final double saree = 1.0;
  @override
  Widget build(BuildContext context) {
    final double total = isDryCleaning ? 160.0 : 48.0;
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(50.sp),
            child: ElevatedButton(
              onPressed: () {
                final SmsSendStatusListener listener = (SendStatus status) {
                  print(status.toString());
                };
                final message = messageBuild(fullName,shirt,trouser,saree,total,isDryCleaning);
                print(message);
                telephony.sendSms(
                    to: "9987660507",
                    message: message,
                    isMultipart: true,
                    statusListener: listener
                );
              },
              child: Text('Send'),
            ),
          )
        ],
      ),
    );
  }

  String messageBuild(String fullName,double shirt,double trouser,double saree,double total,bool isDryCleaning){
    final service = isDryCleaning ? 'DryCleaning' : 'Cleaning';
    String message = '';
    if(shirt == 0.0){
      if(trouser == 0.0)
        message = 'Customer $fullName has placed order for $saree sarees for $service and total will be Rs $total';
      else if(saree == 0.0)
        message = 'Customer $fullName has placed order for $trouser trousers for $service and total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for $trouser trousers & $saree sarees for $service and total will be Rs $total';
    }

    else if(trouser == 0.0){
      if(shirt == 0.0)
        message = 'Customer $fullName has placed order for $saree sarees for $service and total will be Rs $total';
      else if(saree == 0.0)
        message = 'Customer $fullName has placed order for $shirt shirts for $service and total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for $shirt shirts & $saree sarees for $service and total will be Rs $total';
    }

    else if(saree == 0.0){
      if(shirt == 0.0)
        message = 'Customer $fullName has placed order for $trouser trousers for $service and total will be Rs $total';
      else if(trouser == 0.0)
        message = 'Customer $fullName has placed order for $shirt shirts for $service and total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for $shirt shirts & $trouser trousers for $service and total will be Rs $total';
    }

    else
      message = 'Customer $fullName has placed order for $shirt shirts, $trouser trousers & $saree sarees for $service and total will be Rs $total';

    return message;
  }
}


/*class InvoiceDetailsExample extends StatelessWidget {
  const InvoiceDetailsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(50.sp),
          child: ElevatedButton(
            onPressed: () {
              final invoice = Invoice(
                title: Strings.title,
                userdata: UserData(
                    fullName: 'Rishikesh Lingayat',
                    email: 'rishikeshlingayat5062@gmail.com',
                    phoneNumber: 7021058163,
                    url: 'No URL',
                        /*'https://firebasestorage.googleapis.com/v0/b/drycleanersproject-48a0f.appspot.com/o/userQRCodes%2FRishikesh%20Lingayat-qr.png?alt=media&token=90f5a323-2c27-429d-818c-50d36188a793'*/
                ),
                invoiceItems: [
                  InvoiceItems(
                      item: 'Shirts',
                      quantity: 0.0.toString(),
                      unitPrice: 5.0.toString(),
                      totalUnitPrice: 10.toString()),
                  InvoiceItems(
                      item: 'Trousers',
                      quantity: 2.0.toString(),
                      unitPrice: 5.0.toString(),
                      totalUnitPrice: 10.toString()),
                  InvoiceItems(
                      item: 'Sarees',
                      quantity: 1.0.toString(),
                      unitPrice: 10.0.toString(),
                      totalUnitPrice: 10.0.toString()),
                ],
                isDryCleaning: false,
                total: 30.toString(),
                date: DateTime.now(),
              );
              return details(invoice);
            },
            child: Text('Download'),
          ),
        ),
      ],
    ));
  }

  details(invoice) async {
    final pdfFile = await PdfInvoice.generate(invoice);

    return PdfApi.openFile(pdfFile);
  }
}*/
