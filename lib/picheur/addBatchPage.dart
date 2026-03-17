import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Addbatchpage extends StatefulWidget{
  const Addbatchpage ({super.key});
  @override State<Addbatchpage> createState() => _AddBatchPageState();
}

class _AddBatchPageState extends State<Addbatchpage> {
  //
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _locationLoaded = false;
  //
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _locationLoaded = true;
    });
  }
  //
  @override
  //
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  //
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back),color: Color(0xFF0F172A)),
        title: Text("Add Batch", style: TextStyle(
          color: Color(0xFF0F172A),
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          fontSize: 24,
          letterSpacing: -0.6,
        ),textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle(subTitle: "CATCH DETAILS",icon: Icons.sailing_outlined,),
            SizedBox(height: 20),
            Text("Category",style: TextStyle(
              color: Color(0xFF334155),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),),
            SizedBox(height: 7),
            DropdownButtonFormField(items: [], onChanged: (value){},
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Color(0xFFE2E8F0),
                  )
                )
              ),
              hint: Text("Select Category",style: TextStyle(
                color: Color(0xFF0F172A),
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),),
              icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xFF0F172A)),
            ),
            Block(),
            Text("Fish name",style: TextStyle(
              color: Color(0xFF334155),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),),
            SizedBox(height: 7,),
            DropdownButtonFormField(items: [], onChanged: (value){},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Color(0xFFE2E8F0),
                  )
                )
              ),
              hint: Text("e.g.Lacha",style: TextStyle(
                color: Color(0xFFA8A8A8),
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),),
              icon: Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFFA8A8A8)),
            ),
            Block(),
            Text("Catch Method",style: TextStyle(
              color: Color(0xFF334155),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),),
            SizedBox(height: 7,),
            DropdownButtonFormField(items: [], onChanged: (value){},
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Color(0xFFE2E8F0),
                  )
                )
              ),
              hint: Text("Select Catch Method",style: TextStyle(
                color: Color(0xFF0F172A),
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),),
              icon: Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xFF0F172A)),
            ),
            Block(),
            Row(
              spacing: 15,
              children: [
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity (kg)",style: TextStyle(
                      color: Color(0xFF334155),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    SizedBox(height: 7,),
                    TextFormField(onTap: (){},
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color(0xFFE2E8F0),
                            )
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hint: Text("0.00",style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),)
                      ),
                      keyboardType: .number,
                    )
                  ],
                ),),
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price (per kg)",style: TextStyle(
                      color: Color(0xFF334155),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    SizedBox(height: 7,),
                    TextFormField(onTap: (){},
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xFFE2E8F0),
                              )
                          ),
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          hint: Text("0.00 DA",style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),)
                      ),
                      keyboardType: .number,
                    )
                  ],
                ),),
              ],
            ),
            SizedBox(height: 20),
            SubTitle(subTitle: "PHOTO",icon: Icons.camera_alt_outlined),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){},
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: Color(0xFFE2E8F0),style: BorderStyle.solid),
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadiusGeometry.circular(13),
                      ),
                      height: 100.33,
                      width: 111.33,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,color: Color(0xFF94A3B8),),
                            SizedBox(height: 3),
                            Text("PHOTOS",style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            SubTitle(subTitle: "CATCH LOCATION",icon: Icons.location_on_outlined),
            SizedBox(height: 10),
            ///// FOR MAP
            _locationLoaded
                ? SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("current"),
                      position: _currentPosition!,
                    ),
                  },
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
            ////// FOR MAP
            SizedBox(height: 20,),
            SubTitle(subTitle: "ADDITIONAL NOTES",icon: Icons.notes_outlined),
            SizedBox(height: 10,),
            TextFormField(onTap: (){},
              maxLines: 2,
              minLines: 1,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color(0xFFE2E8F0),
                      )
                  ),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  hint: Text("Gear used, or weather\n conditions...",style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsetsGeometry.all(10),
              child: Column(
              children: [
                Container(
                  height: 56,
                  width: 389,
                  child:ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF023E77),
                      foregroundColor: Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(13),
                      ),
                      alignment: AlignmentGeometry.center,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sumbit Batch", style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        ),),
                        SizedBox(width: 10),
                        Icon(Icons.send,size: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 56,
                  width: 389,
                  child:ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA8A8A8),
                      foregroundColor: Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(13),
                      ),
                      alignment: AlignmentGeometry.center,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Save as Draft", style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),),
                        SizedBox(width: 10),
                        Icon(Icons.drafts_outlined,size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),)
          ],
        ),
      )
    );
  }
}

class Block extends StatelessWidget{
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 12);
  }
}

class SubTitle extends StatelessWidget{
  final String? subTitle;
  final IconData? icon;
  const SubTitle({super.key, this.subTitle, this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(icon,color: Color(0xFF023E77)),
        Text("$subTitle",style: TextStyle(
          color: Color(0xFF64748B),
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.7,
        ),),
      ],
    );
  }
}