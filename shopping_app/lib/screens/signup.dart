import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/provider/regex_pattern.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/models/http_exception.dart';
import 'package:shopping_app/screens/allproduct_screen.dart';

class SignUpScreen extends StatefulWidget  {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController =TextEditingController();
  final _passwordController =TextEditingController();
  final _confirmpasswordController =TextEditingController();
  final _usernameController =TextEditingController();
  final _addressController =TextEditingController();
  final _phonenumberController =TextEditingController();
  var _formkey = GlobalKey<FormState>();
  RegExp regexp = new RegExp(RegExPattern.emailRegExPattern);
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Shopping App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 70.0),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 35.0),
                      ),
                    ),
                  ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your UserName';
                      }

                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.perm_identity_rounded),
                      hintText: 'UserName',
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
                        borderSide: BorderSide(color: Colors.blue),
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
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // onChanged: (value) {},
                  ),
                ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter the Email';
                        }


                        if (!regexp.hasMatch(value)) {
                          return 'Email format incorrect';
                        }
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter Email',
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
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter password';
                      }
                      // Use any password length of your choice here
                      if (value.length < 5) {
                        return 'Password length should be atleast 6 Character';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.key),
                      hintText: 'Enter Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    //onChanged: (value) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _confirmpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Re-Enter password';
                      }
                      // Use any password length of your choice here
                      if (value.length < 5) {
                        return 'Password length should be atleast 6 Character';
                      }
                      if(value!=_passwordController.text){
                        return "Password not matched";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.key),
                      hintText: 'Re-Enter Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    //onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.orange,
                    onPressed: ()  {
                      _submit();
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
               /* Center(child: Text('or')),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.all(11),
                    color: Colors.red,
                    onPressed: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        SizedBox(
                          width: 55.0,
                        ),
                        Text(
                          'Sign Up with Google',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );

  }
  void _showErrorDialog(String message){
    showDialog(
        context: context,
        builder: (ctx)=>AlertDialog(title: Text('Error Message'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('OKAY'))
          ],)
    );

  }
  Future<void> _submit() async{
    try{
      if(_formkey.currentState.validate()){
        await Provider.of<Auth>(context,listen: false).signup(_emailController.text,_passwordController.text);
        Navigator.popAndPushNamed(context, Allproduct.routeName);
      }
    } on HttpException catch(error){
      var errorMsg='Authentication Failed';
      if(error.toString().contains('EMAIL_EXISTS')){
        errorMsg='This email address already in use';
      }else if(error.toString().contains('INVALID_EMAIL')){
        errorMsg='Invalid email';
      }else if (error.toString().contains('EMAIL_NOT_FOUND')){
        errorMsg='this email dose not exists';
      }else if(error.toString().contains('WEAK_PASSWORD')){
        errorMsg='weak password';
      }else if (error.toString().contains('INVALID_PASSWORD')){
        errorMsg='Invalid password';
      }
      _showErrorDialog(errorMsg);
    }catch(error){
      var errorMsg='Could not authenticate you. Try again later';
      _showErrorDialog(errorMsg);
    }

  }
}
