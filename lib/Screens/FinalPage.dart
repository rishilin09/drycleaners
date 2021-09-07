/*import 'package:drycleaners/config/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';*/

import 'package:drycleaners/projectImports.dart';
import 'package:telephony/telephony.dart';


///This Page will be the final page of the project where user will be downloading there invoice
class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ///Accessing Current User Details
    final user = Provider.of<UserUID?>(context);

    ///Accessing values from SelectionPage
    final counter = ModalRoute.of(context)!.settings.arguments as Items;
    final shirt = counter.itemDetails[0];
    final trousers = counter.itemDetails[1];
    final saree = counter.itemDetails[2];
    final isDryCleaning = counter.isDryCleaning;
    final total = counter.total;

    ///StreamBuilder is implemented to collect data and to store it as Invoice object in Invoice class.
    ///Invoice class consists of some parameters and they are
    ///'title' which has a String datatype for the title of Invoice.
    ///'userdata' will take UserData objects since it has UserData datatype.
    ///'invoiceItems' will take a list of InvoiceItems objects since it has InvoiceItems datatype.
    ///'isDryCleaning' as bool datatype to check whether user has selected DryCleaning or Ironing.
    ///'total' has a String datatype and will take total amount of all items.
    ///'date' has a DateTime datatype and will display on which date and time the user has downloaded
    ///the invoice.
    return StreamBuilder<UserData>(
        stream: DataBaseServices(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            final invoice = Invoice(
              title: Strings.title,
              userdata: UserData(
                fullName: userData!.fullName,
                email: userData.email,
                phoneNumber: userData.phoneNumber,
                url: userData.url,
              ),
              invoiceItems: [
                InvoiceItems(
                    item: 'Shirts',
                    quantity: (shirt.quantity).toString(),
                    unitPrice: (shirt.priceX).toString(),
                    totalUnitPrice: (shirt.totalUnitPrice).toString()),
                InvoiceItems(
                    item: 'Trousers',
                    quantity: (trousers.quantity).toString(),
                    unitPrice: (trousers.priceX).toString(),
                    totalUnitPrice: (trousers.totalUnitPrice).toString()),
                InvoiceItems(
                    item: 'Sarees',
                    quantity: (saree.quantity).toString(),
                    unitPrice: (saree.priceX).toString(),
                    totalUnitPrice: (saree.totalUnitPrice).toString()),
              ],
              isDryCleaning: isDryCleaning,
              total: (total).toString(),
              date: DateTime.now(),
            );
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(gradient:gradientLayout),
                child: Stack(
                  children: [

                    ///FinalPage UI
                    finalPageUI(context),

                    ///Download Button
                    ///Invoice object created initially will be passed as a parameter to ElevatedButton Widget
                    ///and from there invoice function will be called.
                    downloadButton(context, invoice),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: ProjectColors.primary,
              ),
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 50.h,
              ),
            );
          }
        });
  }

  ///Final Page UI
  Widget finalPageUI(context) {
    return Stack(
      children: [
        //Success Text
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 110.h),
            child: SizedBox(
              width: 320.w,
              height: 58.h,
              child: Text(
                Strings.successOrder,
                style: TextStyle(
                  fontSize: 25.sp,
                ),
              ),
            ),
          ),
        ),

        //SVG Image
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 220.h),
            child: SizedBox(
              width: 150.w,
              height: 160.h,
              child: SvgPicture.asset(ImageStrings.confirmedimg),
            ),
          ),
        ),

        //Download Text
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 420.h),
            child: Text(
              Strings.downloadInvoice,
              style: TextStyle(
                fontSize: 25.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Invoice Download
  Widget downloadButton(BuildContext context, Invoice invoice) {
    return Padding(
      padding: EdgeInsets.only(top: 497.h, bottom: 65.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 178.w,
          height: 78.h,
          child: ElevatedButton.icon(
            onPressed: () async {
              ///For Sending SMS
              final Telephony telephony = Telephony.instance;
              final fullName = invoice.userdata.fullName;
              final shirtQ = int.parse(invoice.invoiceItems[0].quantity);
              final trouserQ = int.parse(invoice.invoiceItems[1].quantity);
              final sareeQ = int.parse(invoice.invoiceItems[2].quantity);
              final total = double.parse(invoice.total);
              final isDryCleaning = invoice.isDryCleaning;
              final message = messageBuild(fullName, shirtQ, trouserQ, sareeQ, total, isDryCleaning);
              print(message);
              telephony.sendSms(
                  to: "7021058163",
                  message: message,
                  isMultipart: true
              );
              final pdfFile = await PdfInvoice.generate(invoice);
              return PdfApi.openFile(pdfFile);
            },
            icon: Icon(Icons.assignment),
            label: Text(
              Strings.download,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String messageBuild(String fullName,int shirtQ,int trouserQ,int sareeQ,double total,bool isDryCleaning){
    final service = isDryCleaning ? 'DryCleaning' : 'Ironing';
    String message = '';
    if(shirtQ == 0){
      if(trouserQ == 0)
        message = 'Customer $fullName has placed order for\n$sareeQ sarees for $service\nand total will be Rs $total';
      else if(sareeQ == 0)
        message = 'Customer $fullName has placed order for\n$trouserQ trousers for $service\nand total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for\n$trouserQ trousers &\n$sareeQ sarees for $service\nand total will be Rs $total';
    }

    else if(trouserQ == 0){
      if(shirtQ == 0)
        message = 'Customer $fullName has placed order for\n$sareeQ sarees for $service\nand total will be Rs $total';
      else if(sareeQ == 0)
        message = 'Customer $fullName has placed order for\n$shirtQ shirts for $service\nand total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for\n$shirtQ shirts &\n$sareeQ sarees for $service\nand total will be Rs $total';
    }

    else if(sareeQ == 0){
      if(shirtQ == 0)
        message = 'Customer $fullName has placed order for\n$trouserQ trousers for $service\nand total will be Rs $total';
      else if(trouserQ == 0)
        message = 'Customer $fullName has placed order for\n$shirtQ shirts for $service\nand total will be Rs $total';
      else
        message = 'Customer $fullName has placed order for\n$shirtQ shirts &\n$trouserQ trousers for $service\nand total will be Rs $total';
    }

    else
      message = 'Customer $fullName has placed order for\n$shirtQ shirts,\n$trouserQ trousers &\n$sareeQ sarees for $service\nand total will be Rs $total';

    return message;
  } /*${shirtQ.toInt()}, {trouserQ.toInt()}, ${sareeQ.toInt()}*/
/*final invoice = Invoice(
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
              );*/

}
