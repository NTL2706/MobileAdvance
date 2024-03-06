import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  
  Widget build (BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("StudentHub"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 120,
              ),
              const Center(
                child: Text(
                  "Login with StudentHub", 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  hintText: "Username or Email"
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  hintText: "Password"
                ),
              ),
              ElevatedButton(onPressed: (){
                
              }, child: Text("LOGIN"))
            ],
          ),
        ),
      ),
    );
  }
}