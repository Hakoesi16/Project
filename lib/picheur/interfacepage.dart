import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Interfacepage extends StatefulWidget {
  final String token;
  const Interfacepage({super.key, required this.token});

  @override
  State<Interfacepage> createState() => _InterfacepageState();
}
class _InterfacepageState extends State<Interfacepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Let's Fishing", style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.fromBorderSide( const BorderSide(color: Colors.grey)),
            ),
            child:Container(
                padding: EdgeInsets.all(10),
                child: IconButton(onPressed: (){}, icon: Icon(Icons.help_outline,color: Colors.grey,))),
          )
        ],
      ),
      body:Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 6),
              image: DecorationImage(
                image: AssetImage("images/sea.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 50),
          _textcenter("Let's Complete"),
          _textcenter("Your Profil"),
          _text("To start trading in the marketplace,"),
          _text("we need a few more details about you"),
          _text("and your vessel"),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF033F78),
                minimumSize: const Size(70, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: MaterialButton(onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(token: widget.token)));
              },child: const Text("Start Setup", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),)
          ),
        ],
      ),
    );
  }
}

Widget _textcenter(String txt){
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 11, color: Colors.black),
        children: [
          TextSpan(text:txt,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 36)),
        ],
      ),
    ),
  );

}

Widget _text(String text){
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 11, color: Colors.grey),
        children: [
          TextSpan(text:text,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Color(0xFF475569))),
        ],
      ),
    ),
  );

}