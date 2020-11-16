import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:some_app/models/Cart.dart';
import 'package:some_app/models/Product.dart';

import 'cart_page.dart';

class ItemPage extends StatelessWidget {

  final String productId;

  ItemPage({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<ProductDataProvider>(context).getElementById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title, style: GoogleFonts.marmelad(),),
        ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: data.imgUrl,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data.imgUrl),
                  ),
                ),
              ),
            ),

            Card(
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Text(data.title, style: TextStyle(fontSize: 26.0),),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text('Цена: ',style: TextStyle(fontSize: 24.0) ,),
                        Text('${data.price}',style: TextStyle(fontSize: 24.0) ,),
                      ],
                    ),
                    Divider(),
                    Text(data.description),

                    SizedBox(height: 20.0,),
                  
                    Provider.of<CartDataProvider>(context)
                    .cartItems
                    .containsKey(productId)
                    ? Column(
                      children: <Widget>[
                        MaterialButton(
                          color: Color(0xFFCCFF90),
                          child: Text('Перейтив корзину'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartPage(), 
                              ));
                          },
                        ),
                        Text(
                          'Товар уже добавлен в корзину',
                          style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
                        ),
                      ],
                    )
                    : MaterialButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Добавить в корзину',
                      ),
                      onPressed: () {
                        Provider.of<CartDataProvider>(context, listen: false).addItem(
                          productId: data.id,
                          imgUrl: data.imgUrl,
                          title: data.title,
                          price: data.price,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}