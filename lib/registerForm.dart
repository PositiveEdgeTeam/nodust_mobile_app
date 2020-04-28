import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nodustmobileapp/Models/channel.dart';
import 'package:nodustmobileapp/Models/channelResponse.dart';
import 'package:nodustmobileapp/homemenues.dart';
import 'package:connectivity/connectivity.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = false;
  String myurl ="http://192.168.1.6:80/cmobile_API/GetChannels";
  String myurlRegister ="http://192.168.1.6:80/cmobile_API/RegisterNewCustomer";
  List<Channel> _channels =[];
  List<Channel> _clasification =[Channel("1","Personal"),Channel("2","Company")];
  String selectedChannel;
  String selectedClass;
  final  usernameController = new TextEditingController();
  final  passwordController = new TextEditingController();
  final  nameController = new TextEditingController();
  final  emailController = new TextEditingController();
  final  mobileController = new TextEditingController();
  final  phoneController = new TextEditingController();
  final parentphoneController = new TextEditingController();

  StreamSubscription<ConnectivityResult> subscription;

  _DropDownFormField_Channel() {
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
                labelText: 'channel',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: new Text("Select Channel"),
                  value: selectedChannel,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      selectedChannel = newValue;
                    });
                  },
                  items:  _channels.map((Channel map) {
                    return new DropdownMenuItem<String>(
                      value: map.channel_id,
                      child: new Text(map.channel_name,
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

  _DropDownFormField_classification() {
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
                labelText: 'Account Type',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: new Text("Select Type Please"),
                  value: selectedClass,
                  onChanged: (String newValue) {
                    state.didChange(newValue);
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                  items:  _clasification.map((Channel map) {
                    return new DropdownMenuItem<String>(
                      value: map.channel_id,
                      child: new Text(map.channel_name,
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.account_circle,
              size: 100.0,
              color: Colors.black26,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'UserName is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),

                  _DropDownFormField_Channel(),

                  selectedChannel == "3" ?  TextFormField(
                                controller: parentphoneController,
                                decoration: const InputDecoration(
                                labelText: 'Client Number',
                                ),
                                validator: (String value) {
                                if (value.trim().isEmpty) {
                                return 'Client Number is required';
                                }
                                },
                                ):  const SizedBox(height: 1.0),
                  const SizedBox(height: 16.0),

                  _DropDownFormField_classification(),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Email is required';
                      }
                    },
                  ),
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile ',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Mobile is required';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone ',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Phone is required';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: <Widget>[
              const Spacer(),
              RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void load_channles () async
  {
    var response = await  http.post(myurl);
    if(response.statusCode == 200) {
      print(response.body);
      ChannelResponse jsonResponse = ChannelResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Success") {
        setState(() {
          _channels = jsonResponse.data;
        });

      }

    }

  }
  void _showConnectLost()
  {
    showDialog(
        context: context,
        builder: (_) => Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ), Center( // A simplified version of dialog.
                  child: Text('Connection Lost',
                    style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text('We were unable to complete your request. please try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15,color: Colors.white),
                    maxLines: 2,
                  ),
                ),
                Spacer(flex: 1, ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      child: Text('Ok' ,style: TextStyle(color: Colors.white,fontSize: 20),),
                      color: Colors.red,
                      onPressed: (){
                        Navigator.pop(_);
                      },
                      padding: EdgeInsets.symmetric(horizontal:10 ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        )
    );
  }


  @override
  void initState() {
    print('inite');
    _checkConnection();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile ||result == ConnectivityResult.wifi) {
        load_channles();
        setState(() {
          _agreedToTOS = true;
        });
      }
      else{
        print("no internet");
        setState(() {
          _agreedToTOS = false;
        });
        _showConnectLost();

      }
    });
    super.initState();
  }

 void _checkConnection()async{
   var connectivityResult = await (Connectivity().checkConnectivity());
   if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
     load_channles();
     setState(() {
       _agreedToTOS = true;
     });
   } else  {
     print("no internet");
     setState(() {
       _agreedToTOS = false;
     });
     _showConnectLost();

   }
 }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _submit() {
    bool validated =_formKey.currentState.validate();
    if (validated )
      {
        submit_data();
      }
    print('Form submitted');
  }
  void submit_data() async{


    var response = await  http.post(myurlRegister,headers: {'USERNAME':usernameController.text,'PASSWORD': passwordController.text,'CHANNEL':selectedChannel,
      'CLASSIFICATION':selectedClass,'PARENTPHONE':parentphoneController.text,'EMAIL':emailController.text,'MOBILENUMBER':mobileController.text,'PHONE':phoneController.text,
      'NAME':nameController.text});
    if(response.statusCode == 200) {
      print(response.body);
      ChannelResponse jsonResponse = ChannelResponse.fromJson(jsonDecode(response.body));
      if(jsonResponse != null && jsonResponse.state=="Done") {
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "Incorrect Email or Password",
          toastLength: Toast.LENGTH_LONG,
        );
        await new Future.delayed(const Duration(seconds : 2));        //sharedPreferences.setString("customer_id", jsonResponse.data[0].customer_id);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeMenu(title: ' No Dust')), (Route<dynamic> route) => false);
      }
      else{
       // print(jsonResponse.message);
        Fluttertoast.showToast(
          msg: jsonResponse.message ??  "Incorrect Email or Password",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }

  }

}