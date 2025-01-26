import 'dart:convert';

Map<String,String> allcurrenciesfromjson(String str){
  return Map.from(json.decode(str)).map((k,v)=>MapEntry<String, String>(k,v));
}

String allcurrencestojson(Map<String,String> data){
  return json.encode(Map.from(data).map((k,v)=>MapEntry<String,dynamic>(k,v)));

}
// Map<String, String> allCurrenciesFromJson(String str) {
//   return Map<String, String>.from(json.decode(str));
// }
//
// String allCurrenciesToJson(Map<String, String> data) {
//   return json.encode(data);
// }