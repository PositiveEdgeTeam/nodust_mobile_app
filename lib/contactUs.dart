import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nodustmobileapp/Models/contact.dart';
import 'package:nodustmobileapp/Models/channelResponse.dart';
import 'package:nodustmobileapp/Models/contactusResponse.dart';
import 'package:nodustmobileapp/homemenues.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';


import 'Models/contact.dart';
import 'Models/sharedPref.dart';
import 'Models/user.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  _ContactUs createState() => _ContactUs();
}



class _ContactUs extends State<ContactUs> {
  final GlobalKey<FormState> _formKey_ = GlobalKey<FormState>();
  bool _agreedToTOS = false;
  SharedPref sharedPref = SharedPref();
  User userLoad;
  User anotherccount;
  final String phone = 'tel:02 35352700';
 String myurl ="http://192.168.1.9:80/cmobile_API/ContactUs";
 // String myurl ="http://192.168.1.10/mobile_API/cmobile_API/ContactUs";
 String myurlSubmit ="http://192.168.1.9:80/cmobile_API/Complaint";
  List<Contact> _subjects =[];
  List<String> _categories =[];
  int selectedIndex ;
  //// =[subject("1","Personal"),subject("2","Company")];
  String selectedChannel;
  String selectedClass;
  //String custid ="1";
  String date="2019-12-20";
  final textboxController = new TextEditingController();
  String flag ="1";

  //StreamSubscription<ConnectivityResult> subscription;


  _DropDownFormField_contactus() {
    return FormField<String>(
      validator: (value) {
        if (value == null) {
          print(selectedChannel);
          return "Please Select Channel";

        }
      },
      onSaved: (value) {
        selectedChannel = value;
        print(selectedChannel);
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
                labelText: 'Subject',
                  isMandatoryField: true
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: new Text("Select "),
                  value: selectedChannel,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      selectedChannel = newValue;
                      for(int i =0 ;i <_subjects.length;i++) {
                        if(_subjects[i].subject==newValue) {
                          selectedIndex=i;
                          _categories = _subjects[i].category;
                          break;
                        }
                      }

                    });
                  },
                items:  _subjects.map((Contact map) {
                    return new DropdownMenuItem<String>(
                     value: map.subject,
                     child: new Text(map.subject,
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

  _DropDownFormField_categories() {
    return FormField<String>(
      validator: (value) {
        if (value == null) {
          print(selectedChannel);
          return "Please Select Account Type";

        }
      },
      onSaved: (value) {
        selectedClass = value;
        print(selectedClass);
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
                labelText: 'Sub Topic',
                //  isMandatoryField: true
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: new Text("Select Topic Please"),
                  value: selectedClass,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                 items:  _categories.map((String map) {
                  return new DropdownMenuItem<String>(
                  value: map,
                     child: new Text(map,
                        style: new TextStyle(color: Colors.black)),
                    );
                }).toList(),
                ),
              ),
            ),
            //SizedBox(height: 5.0),
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


  @override
  Widget build(BuildContext context) {
    return Form (
      key: _formKey_,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 150.0,
                      child: Image.asset(
                        "images/logo.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),

                  ),



                  _DropDownFormField_contactus(),
                  if(selectedIndex!=null && _subjects[selectedIndex].category!=null)
                    _DropDownFormField_categories(),



                  Container(


                    decoration: BoxDecoration(

                      border: Border.all(
                        color: Colors.black26,
                      ),

                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    padding: EdgeInsets.all(10),
                    width: 600,
                    height: 200,
                    child: Center(child: TextFormField( maxLines: 3,
                    controller:textboxController ,),
                    ),
                  ),



                  Row(
                    children: <Widget>[

                      Center(

                        child:GestureDetector(
                          //padding: EdgeInsets.symmetric(horizontal: 5),
                          onTap: _fbpage,
                          child: SizedBox(
                            height: 40.0,
                            child: Image.asset(
                              "images/images.png",
                                fit: BoxFit.contain,
                              //  color: Colors.black,

                            ),
                          ),
                        ),
                      ),

                      Center(

                        child: GestureDetector(

                          //padding: EdgeInsets.symmetric(horizontal:10 ),
                          onTap: _callPhone,

                          child:Container(
                            child:Icon(
                              Icons.call,
                              size: 30.0,
                              color: Colors.black,

                            ),

                          ),
                        ),
                      ),
                      const Spacer(),
                      RaisedButton(

                        color: Colors.red,
                        textColor: Colors.white,
                        //onPressed:(),

                        onPressed: submit_data,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            );
  }


  @override
  void initState() {

    super.initState();
    loadSharedPrefs();
    load_channles();

  }

  bool _submittable() {
    return _agreedToTOS;
  }



  void _submit() {
    bool validated =_formKey_.currentState.validate();
    if (validated )
    {
      submit_data();
    }
    print('Form submitted');
  }
  swapAccount () async
  {
    sharedPref.save("user_data", anotherccount.toJson());
    sharedPref.save("another_account",userLoad.toJson());
    setState(() {
      User swap = userLoad;
      userLoad = anotherccount;
      anotherccount = swap;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);

    });

  }


  loadSharedPrefs() async {
    try {
      print("in function");
      User user = User.fromJson(await sharedPref.read("user_data"));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // do something
      print("in Execption 1");
    }

    try {
      User user = User.fromJson(await sharedPref.read("another_account"));
      setState(() {
        anotherccount = user;
      });
    } catch (Excepetion) {
      // do something
      print("in Execption 2");
    }

  }

  void load_channles() async
  {
    var response = await  http.post(myurl);
    if(response.statusCode == 200) {
      print(response.body);
      contactusResponse jsonResponse = contactusResponse.fromJson(jsonDecode(response.body));

      if(jsonResponse != null && jsonResponse.state=="Success") {
        setState(() {
          _subjects = jsonResponse.data;
        });

      }

    }

  }




  _callPhone() async {
  if (await canLaunch(phone)) {
  await launch(phone);
  } else {
  throw 'Could not Call Phone';
  }
  }

 _fbpage() async{
   var facebookUrl ="https://www.facebook.com/NoDust.EG/";
   await canLaunch(facebookUrl)? launch(facebookUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
 }







  void submit_data() async {
    if (( selectedChannel != null && selectedClass!= null  && selectedChannel !="Others")||(selectedChannel =="Others")){
      var response = await http.post(myurlSubmit, headers: {
        'CUSTOMERID': userLoad.customer_id,
        'CATEGORY': selectedClass,
        'DATE': date,
        'MESSAGE': textboxController.text,
        'FLAGSTATUS': flag,
        'SUBJECT': selectedChannel
      });
      if (response.statusCode == 200) {
        print(response.body);
        contactusResponse jsonResponse = contactusResponse.fromJson(
            jsonDecode(response.body));
        if (jsonResponse != null && jsonResponse.state == "Done") {
          Fluttertoast.showToast(
            msg: jsonResponse.message ?? "Incorrect Email or Password",
            toastLength: Toast.LENGTH_LONG,
          );
          await new Future.delayed(const Duration(
              seconds: 2)); //sharedPreferences.setString("customer_id", jsonResponse.data[0].customer_id);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (
              Route<dynamic> route) => false);
        }
        else {
          // print(jsonResponse.message);
          Fluttertoast.showToast(
            msg: jsonResponse.message ?? "Incorrect Email or Password",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      }
    }
    else{
      Fluttertoast.showToast(msg: "please enter valid data" );
    }
  }
}