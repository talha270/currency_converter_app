import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/fetchrates.dart';
import '../utils/key.dart';

class Anytoany extends StatefulWidget {
  const Anytoany({super.key,required this.currencies,required this.rates});
  final Map currencies;
  final Map rates;
  @override
  State<Anytoany> createState() => _AnytoanyState();
}

class _AnytoanyState extends State<Anytoany> {
  TextEditingController anycontroller=TextEditingController();
  String dropdownvalue1="AUD";
  String dropdownvalue2="AUD";
  String answer="Converted Currency will be shown here :)";
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 20,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Convert Any Currency",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            TextFormField(
              key: const ValueKey("amount"),
              controller: anycontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter Amount"),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                      elevation: 20,
                      value: dropdownvalue1,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      items: widget.currencies.keys.toSet().toList().map<DropdownMenuItem<String>>((value){
                    return DropdownMenuItem<String>(value: value,child: Text(value));
                  }).toList(), onChanged:(value){
                    setState(() {
                      dropdownvalue1=value.toString();
                    });
                  }),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: DropdownButton(
                      elevation: 20,
                      value: dropdownvalue2,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      items: widget.currencies.keys.toSet().toList().map<DropdownMenuItem<String>>((value){
                        return DropdownMenuItem<String>(value: value,child: Text(value));
                      }).toList(), onChanged:(value){
                    setState(() {
                      dropdownvalue2=value.toString();
                    });
                  }),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Center(child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  shape: const BeveledRectangleBorder()
                ),
                child: const Text("Convert"), onPressed:(){
              setState(() {
                answer="${anycontroller.text} $dropdownvalue1 = ${convertanytoany(amount: anycontroller.text,rates: widget.rates,basecurrency: dropdownvalue1,convertedcurrency: dropdownvalue2)} $dropdownvalue2";
              });
                }
            )),
            const SizedBox(height: 10,),
            Container(child: Text(answer))
          ],
        ),
      ),
    );
  }
}

