import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:youth_connect/models/LoginResponse.dart';
import 'package:youth_connect/models/User.dart';

import '../../models/Account.dart';
import '../home/Home.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});



  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final secureStorage= FlutterSecureStorage();
  String? userName;
  String? password;
  String? error;
  bool loading=false;
   Future<void> loginUser() async{
     try{
       setState(() {
         loading=true;
         error=null;
       });

       final response = await http.post(
           Uri.parse('http://localhost:8080/auth/login'),
           headers: <String,String>{
             'Content-Type':'application/json; charset=UTF-8',
           },
           body:jsonEncode({
             "userName":userName,
             "password":password,
           })
       );
       setState(() {
         loading=false;
       });
       LoginResponse responseData= LoginResponse.fromJson(jsonDecode(response.body));

       if(response.statusCode==200){
         print(responseData.authdata?.refreshToken);
         await secureStorage.write(key: 'user_id', value: responseData.authdata!.user!.id);
         Account? account=responseData.authdata?.user?.accounts?.firstWhere((account)=>account.isDefault==true,orElse: ()=>Account(name: "no account"));
         print( account?.id);
         await secureStorage.write(key: 'account_id', value:account!.id);
         await secureStorage.write(key: 'access_token', value:responseData.authdata!.accessToken);
         await secureStorage.write(key: 'refresh_token', value:responseData.authdata!.refreshToken);

         //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const Home()));
         //Navigator.pushReplacementNamed(context, "/home");
         context.pushReplacement("/home");
       }
       else{
         setState(() {
           error=responseData.authdata?.error;
         });
         print(error);
       }

     }catch(e){
       throw Exception(e);
     }

  }

  final _formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Form(
        key:_formkey,
        child:Column(
          spacing: 10,
          children: [
            Padding(
                padding: EdgeInsets.all(15),
                child :TextFormField(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 15,left: 20),
                        child: ImageIcon(
                          AssetImage('asset/images/User.png'),
                          size: 30,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      hintText: "username",
                      hintStyle:TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    border: OutlineInputBorder(),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white54, width: 1.5),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                  ),
                      errorStyle: TextStyle(
                        fontSize: 16,
                      )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty ){
                      return "Please enter valid username";
                    }
                    userName=value;
                    return null;
                    },
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  ),


                )),
            Padding(
                padding: EdgeInsets.all(15),
                child :TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 15,left: 15),
                        child: ImageIcon(
                          AssetImage('asset/images/lock.png'),
                          size: 30,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      hintText: "password",
                      hintStyle:TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    border: OutlineInputBorder(),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white54, width: 1.5),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),

                    errorStyle: TextStyle(
                      fontSize: 16,
                    )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "password cann't null ";
                    }
                    if(value.length <8)
                      return "\npassword must atleast 8 characters";
                    password=value;
                    return null;
                  },
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  ),
                )),
            Align(
              alignment:Alignment.centerRight ,
              child: Padding(
                padding: EdgeInsets.all(10),
                child:TextButton(
                    onPressed:(){},
                    child:Text("Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20
                      ),
                    ))
              ),
            ),
            SizedBox(height:20),
            loading?SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ):SizedBox(),
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B82F6),
                    foregroundColor: Color(0xFFFFFFFF),
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                    onPressed:(){
                      if(_formkey.currentState!.validate()){
                        loginUser();
                      }
                      },
                    child: Padding(
                      padding: EdgeInsets.only(top:12,bottom: 12),
                      child: Text("Submit",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )),
              ),

            ),
            error!=null?Padding(padding: EdgeInsets.all(4),
            child:Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), // Dark grey container
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2), // Shadow color (using 2026 'withValues' syntax),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0,4),
                  )
                ],
              ),
              child: Text('$error',style: TextStyle(
                color:Colors.redAccent,
                fontSize: 18,
              ),),
            )):SizedBox(),
          ],
        ));
  }
}