
import 'package:flutter/material.dart';
import 'package:youth_connect/pages/login/LoginForm.dart';

class Login extends StatelessWidget {

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body:SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "YouthConnect",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 50,),
              LoginForm(),
              SizedBox(height:5),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("If you don't have account?",style: TextStyle(
                    color: Color(0xFFFFFFFF)
                  ),),
                  SizedBox(width:1,),
                  TextButton(onPressed:(){}, child:Text("Signup",style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 22,
                ),)),
              ]),
            ],
          ),
        ),
      )
    );
    throw UnimplementedError();
  }

}