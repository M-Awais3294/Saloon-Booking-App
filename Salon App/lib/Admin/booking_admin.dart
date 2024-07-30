import 'package:barber_booking/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? BookingStream;
  getontheload() async {
    BookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
        stream: BookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFFB91635),
                            Color(0xff621d3c),
                            Color(0xFF311937)
                          ]),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 80.0,
                                      width: 80.0,
                                      fit: BoxFit.cover,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("Service: " + ds["Service"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("Name: " + ds["Username"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("Date: " + ds["Date"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("Time: " + ds['Time'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().DeleteBooking(ds.id);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFdf711a),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("Done",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
                child: Text(
              "All Bookings",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 30.0,
            ),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
