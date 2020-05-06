import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/cardProducts.dart';
import 'package:nodustmobileapp/Models/packageProducts.dart';

class ContractProducts extends StatefulWidget {
  final  List<CardProducts> contract_products;

  const ContractProducts({Key key, this.contract_products}) : super(key: key);

  @override
  _ContractProductsState createState() => _ContractProductsState(this.contract_products);
}

class _ContractProductsState extends State<ContractProducts> {
  List<CardProducts> _contract_products;
  _ContractProductsState(this._contract_products);
  @override
  Widget build(BuildContext context) {
    return  new ListView.builder(
      itemCount: _contract_products.length,
      itemBuilder: (context, i) {
        if(_contract_products[i].packageProducts!= null)
        return new ExpansionTile(
          leading: Icon(
            Icons.shop_two,
            size: 40.0,
            color: Colors.black26,
          ),
          title: new Text(
            _contract_products[i].item_name,
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black),
          ),
          subtitle: new Text(_contract_products[i].treatment!=null?_contract_products[i].treatment:""),
          children: <Widget>[
            new Column(
              children: _buildExpandableContent(_contract_products[i]),
            ),
          ],
        );
        else
          return new ExpansionTile(
            leading: Icon(
              Icons.shop,
              size: 40.0,
              color: Colors.black26,
            ),
            trailing: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_contract_products[i].quantity),
                      Icon(
                        Icons.local_grocery_store,
                        size: 30.0,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  Text(_contract_products[i].price+"EGP")
                ],
              ),
            ),
            title: new Text(
              _contract_products[i].item_name,
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black),
            ),
            subtitle: new Text(_contract_products[i].treatment!=null?_contract_products[i].treatment:"" , style: new TextStyle(
                color: Colors.black)),
          );
      },
    );
  }

  _buildExpandableContent(CardProducts policies) {
    List<Widget> columnContent = [];

    for (PackageProducts content in policies.packageProducts)
      columnContent.add(
        new ListTile(
          leading:  Icon(
            Icons.shop,
            size: 20.0,
            color: Colors.black26,
          ),
            subtitle: new Text(content.treatment),
            title: new Text(
              content.product_name,
              style: new TextStyle(fontSize: 15.0, color: Colors.black),
            ),
            ),
      );

    return columnContent;
  }

}

