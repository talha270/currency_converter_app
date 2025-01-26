
import 'dart:convert';

import'package:http/http.dart'as http;

Future<Map>  fetchcurrencys(String url)async{
  var response=await http.get(Uri.parse(url));
  // final allcurrencies = allcurrenciesfromjson(response.body);
  final allcurrencies = jsonDecode(response.body);
  print(allcurrencies);
  return allcurrencies;
}


String convertusdtoany({required Map rates,required String usd,required String convertedcurrency}){
  return ((rates[convertedcurrency]*double.parse(usd)).toStringAsFixed(2)).toString();

}

String convertanytoany({required Map rates,required String basecurrency,required String amount,required String convertedcurrency}){
  return ((double.parse(amount)/rates[basecurrency]*rates[convertedcurrency]).toStringAsFixed(2)).toString();
}