import 'dart:io';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:path_provider/path_provider.dart';
String token = '';
void clearCache() async{
  var appDir = (await getTemporaryDirectory()).path;
  new Directory(appDir).delete(recursive: true);
}


void printFullText(String text)
{
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
