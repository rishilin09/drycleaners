import 'package:pdf/widgets.dart';
import 'package:drycleaners/projectImports.dart';

///This Class will store and open the pdf which is built in PdfInvoice.dart file
class PdfApi {

  ///This function will save the document in the device storage.
  ///First the Document 'pdf' passed will be saved in 'bytes' variable then with the help of
  ///path_provider.dart package device directory will be retrieved and stored in 'dir' variable.
  ///With the usage of File() method file will be created with 'path of dir' and passed parameter
  ///'name' and it will be stored in 'file' variable. Finally the pdf will be write as bytes into file
  ///and it will be return.
  static Future<File> saveDocument(String name,Document pdf) async{

    final bytes = await pdf.save();

    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  ///This function will open the file from the specified File type.
  ///File will be Opened with help of open_file.dart package
  static Future openFile(File file) async{
    final url = file.path;
    await OpenFile.open(url);
  }
}