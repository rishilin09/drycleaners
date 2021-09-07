import 'package:drycleaners/projectImports.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


///This Class will build the Invoice for the user
class PdfInvoice {

  ///This method generates invoice. invoice parameter of Invoice type is passed which will
  ///help to create the invoice.
  static Future<File> generate(Invoice invoice) async {

    ///If the qrImg is null then qrImg will be set to 'No URL' else it will take the
    ///invoice.userdata.url value
    final qrImg = invoice.userdata.url != 'No URL'
        ? await networkImage(invoice.userdata.url)
        : 'No URL';

    ///InvoiceItems object related to Shirt will be stored in shirt variable
    final InvoiceItems shirt = invoice.invoiceItems[0];

    ///InvoiceItems object related to Trousers will be stored in trousers variable
    final InvoiceItems trousers = invoice.invoiceItems[1];

    ///InvoiceItems object related to Saree will be stored in saree variable
    final InvoiceItems saree = invoice.invoiceItems[2];

    ///invoice.date will be stored in variable date of type DateTime
    final DateTime date = invoice.date;

    ///Formatting the date and storing into String dateTime variable
    final String dateTime = '${date.day}/${date.month}/${date.year}\t:' +
        '\t${date.hour}:${date.minute}:${date.second}';

    ///myTheme will have base, bold, italic, boldItalic font types used for building invoice
    ///withFont is defined method in pdf.dart file which takes base, bold, italic, boldItalic as parameters
    var myTheme = pw.ThemeData.withFont(
      base:
          Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")),
      italic:
          Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Italic.ttf")),
      boldItalic: Font.ttf(
          await rootBundle.load("assets/fonts/OpenSans-BoldItalic.ttf")),
    );

    /// Document will be created where all the details will be laid out
    final pdf = pw.Document();

    ///This Function creates invoice with pdf filetype.
    ///addPage will created pages for document which takes MultiPage as parameter.
    ///MultiPage takes two parameters pageTheme and build.
    ///pageTheme will built the theme of document with fonts,decoration etc
    ///build method takes series of widgets which will be build into document. It will build according
    ///to the order it is placed in the build method.
    ///Prefix pw is used with widgets which indicates that we are using widgets from pdf.dart package
    ///and not from material.dart package.
    pdf.addPage(pw.MultiPage(
      pageTheme: _buildTheme(dateTime, PdfPageFormat.a4, myTheme),
      build: (context) => [
        pw.Text(Strings.title,
            style: pw.TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
        buildUserDetails(invoice, qrImg),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        invoice.isDryCleaning
            ? orderText('DryCleaning of clothes')
            : orderText('Ironing of Clothes'),
        pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
        buildInvoice(invoice, shirt, trousers, saree, 20),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildPay(invoice, 25.0),
      ],
    ));

    ///Document will be saved
    return PdfApi.saveDocument('${invoice.userdata.fullName}-invoice.pdf', pdf);
  }

  ///Building PageTheme for PDF file
  static pw.PageTheme _buildTheme(dateTime, PdfPageFormat pageFormat, theme) =>
      pw.PageTheme(
        pageFormat: pageFormat,
        theme: theme,
        buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: invoiceUI(dateTime, 430.0, 670.0)),
      );

  ///PDF background UI
  static pw.Widget invoiceUI(dateTime, horizontal, vertical) =>
      pw.Stack(children: [
        ///Secondary Circle
        pw.Positioned(
          left: horizontal,
          bottom: vertical,
          child: pw.Container(
            alignment: pw.Alignment.topRight,
            width: 250,
            height: 250,
            decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle, color: PdfColor.fromHex('02D1E1CC')),
          ),
        ),

        ///Primary Circle
        pw.Positioned(
          right: horizontal,
          top: vertical,
          child: pw.Container(
            width: 250,
            height: 250,
            decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle, color: PdfColor.fromHex('0C55E2FF')),
          ),
        ),

        pw.Positioned(
            left: horizontal - 100.0,
            top: vertical + 120.0,
            child:
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              invoiceTexts('Date:', 18.0, 5.0, false),
              invoiceTexts(dateTime, 18.0, 5.0, false)
            ])),
      ]);

  ///PDF User Details
  static pw.Widget buildUserDetails(Invoice invoice, qrImg) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(Strings.invoice,
                      style: pw.TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  pw.SizedBox(height: 1.0 * PdfPageFormat.cm),
                  userInvoiceDetails(
                      Strings.fullName + ':', invoice.userdata.fullName),
                  userInvoiceDetails(
                      Strings.email + ':', invoice.userdata.email),
                  userInvoiceDetails(Strings.phoneNumber + ':',
                      (invoice.userdata.phoneNumber).toString()),
                ]),
            qrImg != 'No URL'
                ? pw.Container(height: 100, width: 100, child: pw.Image(qrImg))
                : pw.Container(
                    height: 100,
                    width: 100,
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(2),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text('QR Code was not uploaded from details page',
                        style: pw.TextStyle(fontSize: 12)))
          ]);

  ///User Details Builder
  static pw.Row userInvoiceDetails(field, value) => pw.Row(children: [
        pw.Text(field, //Strings.fullName+':',
            style: pw.TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
        pw.Text(value, //invoice.userdata.fullName,
            style: pw.TextStyle(fontSize: 15)),
      ]);

  ///Item details Builder will be created in the form of Table
  static pw.Widget buildInvoice(Invoice invoice, InvoiceItems shirt,
          InvoiceItems trousers, InvoiceItems saree, double padding) =>
      pw.Table(
          border: pw.TableBorder.all(),
          defaultColumnWidth: pw.FixedColumnWidth(50),
          children: [
            rowsHeaders(18.0, padding),
            if (shirt.quantity != '0.0') invoiceRows(shirt, 15.0, padding),
            if (trousers.quantity != '0.0') invoiceRows(trousers, 15.0, padding),
            if (saree.quantity != '0.0') invoiceRows(saree, 15.0, padding),
          ]);

  ///Headers for Table
  static pw.TableRow rowsHeaders(double size, double padding) =>
      pw.TableRow(children: [
        invoiceTexts('Clothing Item', size, padding, true),
        invoiceTexts('Quantity', size, padding, true),
        invoiceTexts('Unit\nPrice', size, padding, true),
        invoiceTexts('Total\nUnit\nPrice', size, padding, true),
      ]);

  ///Individual Items details
  static pw.TableRow invoiceRows(
          InvoiceItems item, double size, double padding) =>
      pw.TableRow(children: [
        invoiceTexts('${item.item}', size, padding, false),
        invoiceTexts('${item.quantity}', size, padding, false),
        invoiceTexts('Rs\t${item.unitPrice}', size, padding, false),
        invoiceTexts('Rs\t${item.totalUnitPrice}', size, padding, false),
      ]);

  ///Table Texts
  static pw.Widget invoiceTexts(text, fontsize, padding, isBold) =>
      pw.Container(
          alignment: pw.Alignment.center,
          padding: pw.EdgeInsets.all(padding), //20
          child: pw.Text(text,
              style: pw.TextStyle(
                  fontSize: fontsize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)));

  ///Order Text
  static pw.Text orderText(String text) => pw.Text(Strings.orderPlaced + text,
      style: pw.TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  ///Total Amount will be displayed
  static pw.Widget buildPay(Invoice invoice, double padding) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              invoiceTexts('Total:', 24.0, padding, true),
              //pw.SizedBox(width: 1.0 * PdfPageFormat.cm),
              pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(
                              color: PdfColor.fromHex('0C55E2FF'), width: 5))),
                  child:
                      invoiceTexts('Rs.${invoice.total}', 24.0, padding, true))
            ]),
          ]);
}
