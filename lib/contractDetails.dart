import 'package:flutter/material.dart';
import 'package:nodustmobileapp/Models/cardData_.dart';

import 'Models/cardDetails.dart';

class ContractDetails extends StatefulWidget {
  final  CardDetails contract_data;

  const ContractDetails({Key key,this.contract_data}) : super(key: key);
  @override
  _ContractDetailsState createState() => _ContractDetailsState(this.contract_data);
}

class _ContractDetailsState extends State<ContractDetails> {
  CardDetails contract_data;
  _ContractDetailsState(this.contract_data);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
            Icon(
              Icons.credit_card,
              size: 30.0,
              color: Colors.black26,),
               SizedBox(width: 8,),
               Text("Customer Name : " ,style: TextStyle(
              fontWeight: FontWeight.bold ,
              fontSize: 15,
            ),),
            Text(contract_data!=null ? contract_data.client_name : "clientName")
          ],),
          Row(
            children: <Widget>[
              Icon(
                Icons.phone,
                size: 30.0,
                color: Colors.black26,),
              SizedBox(width: 8,),
              Text("Phone Number : " ,style: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 15,
              ),),
              Text(contract_data!=null ? contract_data.contract_phone : "phone")
            ],),
          Row(
            children: <Widget>[
              Icon(
                Icons.smartphone,
                size: 30.0,
                color: Colors.black26,),
              SizedBox(width: 8,),
              Text("Mobile Number : " ,style: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 15,
              ),),
              Text(contract_data!=null ? contract_data.contract_mobile : "mobile")
            ],),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                size: 30.0,
                color: Colors.black26,),
              SizedBox(width: 8,),
              Text("Email : " ,style: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 15,
              ),),
              Text(contract_data!=null ? contract_data.contract_email : "email")
            ],),
          SizedBox(height: 30,),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 30.0,
                color: Colors.black26,),
              SizedBox(width: 8,),
              Text("Address" ,style: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 20,
              ),),
            ],),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text("City : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.city_name : "city"),
                  ],
                ),
                  padding: EdgeInsets.symmetric(horizontal: 15)
              ),
              Spacer(flex: 1, ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text("Area : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.area_name : "area"),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
              )
            ],
          ),
          SizedBox(height: 3,),
          Row(
            children: <Widget>[
              Container(
               padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text("Street : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.street_name : "street",maxLines: 2,),
                  ],
                ),
              ),
              Spacer(flex: 1, ),
              Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text("Region : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.region_name : "region"),
                  ],
                ),
              ),
            ],),
          SizedBox(height: 3,),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text("Address : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.street_name : "street",maxLines: 2,),
                  ],
                ),
              ),
            ],),
          SizedBox(height: 30,),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon( Icons.assignment_turned_in,
                      size: 30.0,
                      color: Colors.black26,),
                    Text("Last Change Date : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.last_changed_date : "change_date",),
                  ],
                ),
              ),
            ],),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon( Icons.calendar_today,
                      size: 30.0,
                      color: Colors.black26,),
                    Text("Contract Date : " ,style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15,
                    ),),
                    Text(contract_data!=null ? contract_data.contract_date : "contract_date",),
                  ],
                ),
              ),
            ],),
          Spacer(flex: 1,),
          Row(  children: <Widget>[
            Spacer(flex: 1,),
            FloatingActionButton(child: Icon(Icons.edit,),
              foregroundColor: Colors.blue,onPressed: () {

              },
            ),
          ],
          )

        ],
      ),
    );
  }

  @override
  void initState() {
    //print("gggg");
  }

}
