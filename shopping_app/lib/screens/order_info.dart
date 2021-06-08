import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/order.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OrderInfo extends StatefulWidget {
  static const routeName = '/orderinfo';
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
 // final String authtoken= Auth().userid;
  final _addressController = TextEditingController();
  final _postalcodeController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  var pickupSelected ;
  var _formkey = GlobalKey<FormState>();
  List contrylist=["Pakistan","UnitedStates","India","southafrica"];


  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem<dynamic>> DropDownMenucontrylist = contrylist.map(
          (var value) => DropdownMenuItem(
        value: value,
        child: Text(value),
      ),
    ).toList();


    return Scaffold(
      appBar: AppBar(
        title: Text('Order Info'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _fullnameController,
                  keyboardType: TextInputType.streetAddress,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your Fullname';
                    }

                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city_outlined),
                    hintText: 'Fullname',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  // onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _postalcodeController,
                  keyboardType: TextInputType.streetAddress,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter Postal code';
                    }

                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city_outlined),
                    hintText: 'Postal code',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  // onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your Address';
                    }

                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city_outlined),
                    hintText: 'Address',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  // onChanged: (value) {},
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextFormField(
                  controller: _phonenumberController,
                  keyboardType: TextInputType.phone,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your PhoneNumber';
                    }

                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.local_phone_outlined),
                    hintText: 'PhoneNumber',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  // onChanged: (value) {},
                ),
              ),
              Container(
                child: DropdownButton(
                  items: DropDownMenucontrylist,
                  value: pickupSelected,
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Text('Select Country'),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      pickupSelected = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 2,),
              FlatButton(
                padding: EdgeInsets.all(15),
                color: Colors.orange,
                onPressed: ()  {
                 submit(_addressController.text, _fullnameController.text, _phonenumberController.text);
                },
                child: Text(
                  'Confirm Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
  Future<void> submit(String address, String fullname, String phonenumber) async{

    if(_formkey.currentState.validate()){
    await Provider.of<Auth>(context,listen: false).confirmorder(fullname,address,phonenumber);}

  }
}
