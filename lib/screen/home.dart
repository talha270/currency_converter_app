import 'package:currency_converter_app/components/usdtoany.dart';
import 'package:currency_converter_app/functions/fetchrates.dart';
import 'package:currency_converter_app/utils/key.dart';
import 'package:flutter/material.dart';

import '../components/anytoany.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});

  @override
  State<Homepage> createState()=>Homepagestate();
}

class Homepagestate extends State<Homepage>{
  final formkey=GlobalKey<FormState>();
  late Future<Map> allcurrencies;
  late Future<Map> currenciesrates;
  @override
  void initState() {
    super.initState();
    setState(() {
    allcurrencies= fetchcurrencys("https://openexchangerates.org/api/currencies.json?app_id=$key");
    currenciesrates= fetchcurrencys("https://openexchangerates.org/api/latest.json?app_id=$key");
    });
    print(currenciesrates);
  }
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.sizeOf(context).height;
    var w=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Currency Converter App"),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(fit:BoxFit.cover,image: AssetImage("assets/images/background2.png")),
        ),
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
                key: formkey,
                child: FutureBuilder(
                    future: currenciesrates,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Expanded(child: const Center(child: CircularProgressIndicator(),));
                      }
                      return FutureBuilder(
                          future: allcurrencies,
                          builder: (context, currsnapshot) {
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Expanded(child: const Center(child: CircularProgressIndicator(),));
                            }
                            else if(currsnapshot.hasData){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Usdtoany(rates: snapshot.data!["rates"], currencies: currsnapshot.data!),
                                  const SizedBox(height: 20,),
                                  Anytoany(currencies: currsnapshot.data!,rates: snapshot.data!["rates"],)
                                ],
                              );
                            }
                            else{
                              return Expanded(child: const Center(child: CircularProgressIndicator(),));
                            }
                          },);
                    },),
                // child:
            ),
          ),
        ),
      ),
    );
  }
}