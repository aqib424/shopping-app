import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shopping_app/provider/product.dart';
import 'package:shopping_app/provider/products.dart';

class Productdetail extends StatelessWidget {
  static const routName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageurl,
              // fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              loadedProduct.title,
            ),
            tileColor: Colors.white60,
            // ignore: missing_required_param
            trailing: IconButton(
                icon: Icon(
                  loadedProduct.isfavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {

                },
              ),
            ),
          SizedBox(height: 50),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.discription,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
