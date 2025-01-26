import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/fetchrates.dart';

class Usdtoany extends StatefulWidget {
  Usdtoany({super.key,required this.rates,required this.currencies});
  Map currencies;
  final rates;
  @override
  State<Usdtoany> createState() => _UsdtoanyState();
}

class _UsdtoanyState extends State<Usdtoany> {
  TextEditingController usdcontroller=TextEditingController();
  String dropdownvalue="AUD";
  String answer="Converted Currency will be shown here :)";
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    return Card(
      color: Colors.white70,
      elevation: 20,
      // shadowColor: Colors.amberAccent,
      child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("USD to Any Currency",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            TextFormField(
              key: const ValueKey("usd"),
              controller: usdcontroller,
              decoration: const InputDecoration(hintText: "Enter USD"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                      value: dropdownvalue,
                      elevation: 16,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      items: widget.currencies.keys.toSet().toList()
                          .map<DropdownMenuItem<String>>((value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          dropdownvalue=value.toString();
                        });
                      }),
                ),
                CupertinoButton(
                    child: Text("Convert"),
                    onPressed: (){
                      if(usdcontroller.text!=null){
                        setState(() {
                          answer="${usdcontroller.text}USD= ${convertusdtoany(rates: widget.rates,usd: usdcontroller.text,convertedcurrency: dropdownvalue)} $dropdownvalue";
                        });
                      }
                      else{

                      }
                    })
              ],
            ),
            SizedBox(height: 10,),
            Container(child: Text(answer))

          ],
        ),
      ),
    );
  }
}

