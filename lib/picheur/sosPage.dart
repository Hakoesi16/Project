import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {

  String _displayNumber = "1548";

  final List<String> _keys = [
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9",
    "*", "0", "#"
  ];

  void _onKeyPressed(String key) {
    setState(() {
      if (_displayNumber == "1548") {
        _displayNumber = key; 
      } else {
        _displayNumber += key;
      }
    });
  }

  Future<void> _makeCall() async {
    final url = Uri.parse("tel:$_displayNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF0F172A),
        ),
        title: Text(
          "SOS",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Block(),

            Image.asset(
              "images/logoPolice.png",
              width: 210,
              height: 210,
              fit: BoxFit.cover,
            ),

            Block(),

            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(13),topRight: Radius.circular(13), bottomRight: Radius.circular(13), bottomLeft: Radius.circular(13)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 6),
                    spreadRadius: -2,
                    blurRadius: 12,
                  ),
                  // BoxShadow(
                  //   color: Colors.grey,
                  //   offset: Offset(0, -4),
                  //   spreadRadius: -2,
                  //   blurRadius: 12,
                  // ),
                  // BoxShadow(
                  //   color: Colors.grey,
                  //   offset: Offset(-3, 0),
                  //   spreadRadius: -2,
                  //   blurRadius: 12,
                  // ),
                  // BoxShadow(
                  //   color: Colors.grey,
                  //   offset: Offset(3, 0),
                  //   spreadRadius: -2,
                  //   blurRadius: 12,
                  // ),
                
                ]
              ),
              child: Text(_displayNumber,style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 44,
                letterSpacing: -0.6,
              ),),
            ),
            //Divider(),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: _keys.map((key) =>
                      GestureDetector(
                        onTap: () => _onKeyPressed(key),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF7C7C7C),
                            shape: BoxShape.circle,
                            border: BoxBorder.all(
                              color: Color(0xB2B2B280)
                            )
                          ),
                          child: Center(
                            child: Text(
                              key,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 44,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ),
                        ),
                      )
                    ).toList(),
                  ),
                  Block(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _makeCall,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF528C55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Color(0x81AF7973)
                            )
                          ),
                        ),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ]
              
              ),
            ),



          ],
        ),
      )
    );
  }
}


class Block extends StatelessWidget {
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}
