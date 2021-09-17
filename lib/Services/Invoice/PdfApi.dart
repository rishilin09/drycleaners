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
  static Future<File> saveDocument(String name, Document pdf) async {
    final bytes = await pdf.save();

    Directory? dir = await getExternalStorageDirectory();
    ///print(dir); ==> '/storage/emulated/0/Android/data/com.rishi.drycleaners/files'
    /*Directory filePath = Directory(path(dir!));
    print(filePath);
    await filePath.create(recursive: true);
    final file = File('${filePath.path}/$name');*/
    final file = File('${dir!.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  ///This function will open the file from the specified File type.
  ///File will be Opened with help of open_file.dart package
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  /*static String path(Directory directory) {
    String newPath = "";
    List<String> folders = directory.path.split("/");
    for (int i = 1;i<folders.length;i++){
      String folder = folders[i];
      if(folder != "Android"){
        newPath += "/"+folder;
      } else {
        break;
      }
    }
    newPath = newPath+"/DryCleaners";
    return newPath;
  }*/


}
