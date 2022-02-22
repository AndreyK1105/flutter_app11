import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/service/auth.dart';

class HomePage extends StatelessWidget {
  TextEditingController? _controllerEmail=TextEditingController();
  TextEditingController? _controllerPass=TextEditingController();
  AuthService authService= AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget> [
          Container(),
          Padding(padding: const EdgeInsets.all(50), child: TextField(controller: _controllerEmail, decoration: const InputDecoration(hintText: "email"),)),
          Padding(padding: const EdgeInsets.all(50), child: TextField(controller: _controllerPass, decoration: const InputDecoration(hintText: "pass"),)),
          ElevatedButton(onPressed:() {authService.registerWhithEmailAndPassword(_controllerEmail!.text, _controllerPass!.text );}, child: Text("Registr")),
          ElevatedButton(onPressed: (){authService.signInWhithEmailAndPassword!(_controllerEmail!.text, _controllerPass!.text);}, child: Text("LogIn")),
          ElevatedButton(onPressed: (){authService.logOut();}, child: const Text("LogOut1")),

        ],
      ),
    );
  }
}
