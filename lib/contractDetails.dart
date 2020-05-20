import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nodustmobileapp/Models/addressResponse.dart';
import 'package:http/http.dart' as http;
import 'package:nodustmobileapp/Models/cardsResponse.dart';
import 'package:nodustmobileapp/Models/contractAddress.dart';
import 'Models/cardDetails.dart';

class ContractDetails extends StatefulWidget {
  final CardDetails contract_data;
  final String customer_id;
  final String status;
  const ContractDetails({Key key, this.contract_data,this.customer_id, this.status}) : super(key: key);
  @override
  _ContractDetailsState createState() =>
      _ContractDetailsState(this.contract_data,customer_id,status);
}

class _ContractDetailsState extends State<ContractDetails> {
  CardDetails contract_data;
  String _customer_id;
  String status;
  _ContractDetailsState(this.contract_data,this._customer_id,this.status);
  List<ContractAddress> _addresses =[];
  String selectedAddress;
  String _oldAddress;
  String bodyRequest="";
  String myurl ="http://gdms.nodust-eg.com:80/cmobile_API/CardAddresses";
  final  addressController = new TextEditingController();
  final  nameController = new TextEditingController();
  final  emailController = new TextEditingController();
  final  mobileController = new TextEditingController();
  final  phoneController = new TextEditingController();


  void load_addresses () async
  {
    var response = await  http.post(myurl,headers: {'CARDID':contract_data.card_no});
    if(response.statusCode == 200) {
      print(response.body);
      AddressResponse jsonResponse = AddressResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Success") {
        String current_address;
        for(int i =0;i<jsonResponse.data.length;i++)
          {
            if(jsonResponse.data[i].active=="1")
              current_address=jsonResponse.data[i].address_id;
          }
        setState(() {
          _addresses = jsonResponse.data;
          _addresses.add(new ContractAddress("Add New", "0", "new_address"));
          selectedAddress=current_address;
          _oldAddress= current_address;
        });

      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.credit_card,
                size: 30.0,
                color: Colors.black26,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Customer Name : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(contract_data != null
                  ? contract_data.client_name
                  : "clientName")
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.phone,
                size: 30.0,
                color: Colors.black26,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Phone Number : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(contract_data != null
                  ? contract_data.contract_phone
                  : "phone")
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.smartphone,
                size: 30.0,
                color: Colors.black26,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Mobile Number : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(contract_data != null
                  ? contract_data.contract_mobile
                  : "mobile")
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                size: 30.0,
                color: Colors.black26,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Email : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(contract_data != null
                  ? contract_data.contract_email
                  : "email")
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 30.0,
                color: Colors.black26,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "City : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(contract_data != null
                          ? contract_data.city_name
                          : "city"),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15)),
              Spacer(
                flex: 1,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Area : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(contract_data != null
                        ? contract_data.area_name
                        : "area"),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Street : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      contract_data != null
                          ? contract_data.street_name
                          : "street",
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Region : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(contract_data != null
                        ? contract_data.region_name
                        : "region"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Address : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      contract_data != null
                          ? contract_data.street_name
                          : "street",
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment_turned_in,
                      size: 30.0,
                      color: Colors.black26,
                    ),
                    Text(
                      "Last Change Date : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      contract_data != null
                          ? contract_data.last_changed_date
                          : "change_date",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 30.0,
                      color: Colors.black26,
                    ),
                    Text(
                      "Contract Date : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      contract_data != null
                          ? contract_data.contract_date
                          : "contract_date",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          (status=="Active"?Row(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              FloatingActionButton(
                child: Icon(
                  Icons.edit,
                ),
                foregroundColor: Colors.blue,
                onPressed: () {
                  _modalBottomSheetMenu(context);
                },
              ),
            ],
          ):SizedBox(height: 0,))
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    nameController.text=contract_data.client_name;
    phoneController.text=contract_data.contract_phone;
    mobileController.text=contract_data.contract_mobile;
    emailController.text=contract_data.contract_email;
    addressController.text="";
    showModalBottomSheet(
        isScrollControlled:
        true, // Important: Makes content maxHeight = full device height
        context: context,
        builder: (context) {
// Does not work
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Customer Name ',
                                  isMandatoryField: true
                              ),
                            //  initialValue: contract_data.client_name,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Customer is required';
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Phone Number ',
                                  isMandatoryField: true
                              ),
                              keyboardType: TextInputType.phone,
                             // initialValue: contract_data.contract_phone,
                              controller: phoneController,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Phone Number is required';
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Mobile Number ',
                                  isMandatoryField: true
                              ),
                              keyboardType: TextInputType.phone,
                              controller: mobileController,
                              //initialValue: contract_data.contract_mobile,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Mobile Number is required';
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Email ',
                                  isMandatoryField: true
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                             // initialValue: contract_data.contract_email,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Email is required';
                                }
                              },
                            ),
                            _DropDownFormField_Address(),
                            selectedAddress=="new_address"? TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Address ',
                                  isMandatoryField: true
                              ),
                              minLines: 1,
                              maxLines: 2,
                              controller: addressController,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Address is required';
                                }
                              },
                            ) : Text(""),
                            RaisedButton(onPressed: (){
                              request_update(context);
                              //Navigator.pop(context);


                            },child: Text("Confirm"),)
                          ],
                        ),
                      ),


                    ],
                  )));
        });
  }

  void request_update (BuildContext context){
    bodyRequest="";
    if(nameController.text != contract_data.client_name)
      bodyRequest +="change Contract Client Name from "+contract_data.client_name+" to "+nameController.text;
    if(phoneController.text != contract_data.contract_phone)
      {
        if (bodyRequest!="")
          bodyRequest+=" , ";
        bodyRequest +="change Contract phone from "+contract_data.contract_phone+" to "+phoneController.text;
      }
    if(mobileController.text != contract_data.contract_mobile)
    {
      if (bodyRequest!="")
        bodyRequest+=" , ";
      bodyRequest +="change Mobile from "+contract_data.contract_mobile+" to "+mobileController.text;
    }
    if(emailController.text != contract_data.contract_email)
    {
      if (bodyRequest!="")
        bodyRequest+=" , ";
      bodyRequest +="change Email from "+contract_data.contract_email+" to "+emailController.text;
    }
    if(selectedAddress == "new_address")
    {
      if (bodyRequest!="")
        bodyRequest+=" , ";
      bodyRequest +="Add new Address "+addressController.text;
    }
    else if (_oldAddress != selectedAddress){
          if (bodyRequest!="")
            bodyRequest+=" , ";
          bodyRequest +="Change Address from "+_oldAddress+" to "+selectedAddress;

    }
    if(bodyRequest != "")
      _submitChanges(context);

  }
  _DropDownFormField_Address() {
    return FormField<String>(
      validator: (value) {
        if (value == null) {
          print(selectedAddress);
          return "Please Select Address";

        }
      },
      onSaved: (value) {
        selectedAddress = value;
        print(selectedAddress);
      },
      builder: (
          FormFieldState<String> state,
          ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InputDecorator(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Address ',
                  isMandatoryField: true
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: new Text("Select Address"),
                  value: selectedAddress,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      selectedAddress = newValue;
                    });
                  },
                  items:  _addresses.map((ContractAddress map) {
                    return new DropdownMenuItem<String>(
                      value: map.address_id,
                      child: new Text(map.address,
                          style: new TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              state.hasError ? state.errorText : '',
              style:
              TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
            ),
          ],
        );
      },
    );
  }

  _submitChanges (BuildContext context)async{
    var response = await  http.post("http://gdms.nodust-eg.com:80/cmobile_API/UpdateContractDetails",headers: {'CUSTOMERID':_customer_id,'REQUESTBODY':bodyRequest,'CARDID':contract_data.card_no});
    if(response.statusCode == 200) {
      CardResponse jsonResponse = CardResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Done") {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "new Contract",
          toastLength: Toast.LENGTH_LONG,
        );

      }

    }

  }



  @override
  void initState() {
    load_addresses();
    //print("gggg");
  }
}
