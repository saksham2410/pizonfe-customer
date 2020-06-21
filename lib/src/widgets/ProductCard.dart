import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizon_customer/models/Product.dart';
import 'package:pizon_customer/screens/ProductDetail.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () =>
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return ProductDetail(item: product);
      // })),
      child: Card(
        elevation: 1,
        child: Container(
          height: 130,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.32,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        product.imageUri,
                        height: 90,
                        width: 90,
                      ),
                    ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                        ),
                        Text(product.description != null
                            ? product.description
                            : product.subCategory),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("First Items"),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Rs 1428",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          child: Text("ADD"),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          onTap: null,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
