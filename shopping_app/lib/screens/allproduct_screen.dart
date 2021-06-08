import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/product.dart';
import 'package:shopping_app/provider/products.dart';
import 'package:shopping_app/widget/app_drawer.dart';
import 'package:shopping_app/widget/badge.dart';
import 'package:shopping_app/provider/cart.dart';
import 'package:shopping_app/widget/infodialogue.dart';
import 'package:shopping_app/widget/product_list.dart';
import 'package:speech_recognition/speech_recognition.dart';


import 'cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class Allproduct extends StatefulWidget {
  static const routeName = '/allproduct';

  @override
  _AllproductState createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  //final TextEditingController __searchcontroller = new TextEditingController();
  var _showOnlyFavorites = false;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "Search input";




  @override
  void initState() {
    initSpeechRecognizer();
    super.initState();

  }


  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );
    void onRecognitionResult(String text) {
      setState(() {
        resultText = text;
        // print('Product id is: ${resultText.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}');
      });
    }

    void onRecognitionComplete() {
      setState(() {
        _isListening = false;
     //   _handleSubmitted(resultText);
      });
    }
    _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
    _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);

  }

/*
    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => {resultText = speech,

            }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
            () {
                  (String speech) => setState(() => {resultText = speech,

              });
              print("line 79");
              print(resultText);
              setState(() => _isListening = false);

              */
/* print('-->setRecognitionCompleteHandler<--')
;              log(resultText);
                     setState(() {
                       completeResultText = resultText;
                       searchkeyword=resultText;
                     });*//*


            }
    );
*/

    // _speechRecognition.activate().then(
    //       (result) => setState(() => _isAvailable = result),
    // );



 /* @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit) {
      Provider.of<Products>(context).FetchandSetProducts(searchkeyword);
    }
    _isInit=false;
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    final _productlist = Provider.of<Products>(context);
    //final _productdata = _productlist.items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Products'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width *0.9 ,
            height:  MediaQuery.of(context).size.width *0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.black, width: 0.7),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Text(
              resultText,
              textAlign:TextAlign.center,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                   // flex:2,
                   FlatButton(
                      // padding: EdgeInsets.all(15),
                      child: Text(
                        'clear the field',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {
                          resultText="";
                         // completeResultText='';
                        });


                      },
                    ),
                SizedBox(
                  width: 5.0,
                ),
                FlatButton(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Voice Input',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    if (  !_isListening)
                      _speechRecognition.listen(locale: "en_US");//.then((result) => resultText=result);
                  },
                ),

                SizedBox(width: 5.0,),


                FlatButton(
                    onPressed: (){
                      //  Provider.of<Products>(context).FetchandSetProducts(searchkeyword);
                        Provider.of<Products>(context,listen: false).FetchandSetProducts(resultText);
                        initDialog();


                    },
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'search',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    color: Colors.orange,

                ),
              ],
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Text("Categories", textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
          ),

 
          ListView(
            shrinkWrap: true,
           scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(3),
            children: <Widget>[
              Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,

                child: Text("Phone", textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),




          /*Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Productlist(),
          ),*/
        ]),
      ),
    );
  }
  void initDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InfoDialog(),
    );

    var RequestTimeout = 15;
    const oneSecondTick = Duration(seconds: 1);

    var timer = Timer.periodic(oneSecondTick, (timer) {
      RequestTimeout--;

      if (RequestTimeout == 0) {
        Navigator.pop(context);
        RequestTimeout = 60;

        timer.cancel();
      }
    });
  }

  /*Future<void> _submit() async{

        await Provider.of<Products>(context,listen: false).FetchandSetProducts(searchkeyword);

  }
*/
  }


/**/
