import 'package:flutter/material.dart';
import 'package:quickride/responsepage/carpage.dart';

import '../auth/firebaseAuth.dart';
import '../intro/loginsignup/loginpage.dart';

class Affordable extends StatefulWidget {
  Affordable({super.key});

  List<Map<String, dynamic>> Aff = [
    {
      "name": "Lula Bergstrom",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Elmer Schimmel",
      "carname": "Toyota Corolla",
      "color": "azure",
      "price": 90,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-xKMoiJluk0N5fIEZP3RXWDbW9s1tT4rPQw&s",
      "id": "2"
    },
    {
      "name": "Theresa Hahn",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Marjorie Miller",
      "carname": "Hyundai Elantra",
      "color": "red",
      "price": 19,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNKneiITDCTUkR2XJl-u2GMh8QrtyTyLa_LQ&s",
      "id": "3"
    },
    {
      "name": "Nathan Wilderman",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Edgar Beahan",
      "carname": "Ford Fiesta",
      "color": "pink",
      "price": 84,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_9gWKrWSUPxlC8SpDPlKsQ-4yZR63nKUo5w&s",
      "id": "4"
    },
    {
      "name": "Jackie Heathcote",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Craig Stracke",
      "carname": "Chevrolet Spark",
      "color": "turquoise",
      "price": 3,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF3WESpX3uN3QWFBLsKwfrogsFurajFOFZCg&s",
      "id": "5"
    },
    {
      "name": "Lynette Considine",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Jackie Olson",
      "carname": "Nissan Sentra",
      "color": "lavender",
      "price": 17,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1ONyuRBkDFt9FHowf3kaI9GlQpFLCOHD2sg&s",
      "id": "6"
    },
    {
      "name": "Maurice Huel",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Latoya Stamm",
      "carname": "Kia Soul",
      "color": "tan",
      "price": 26,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmQ_84hz4ZszqP8jVyShIcfqO9ussaf4vmgA&s",
      "id": "7"
    },
    {
      "name": "Shirley Swift",
      "ownerimg":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDhPz7CL8gVPIQ3wkwqaslgqc8DJ_XlzT9rg&s",
      "owner": "Mr. Elena Rodriguez",
      "carname": "Mazda 3",
      "color": "magenta",
      "price": 98,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo0bQvLStGfK56oChswrS1O1TKHRzA4StEmQ&s",
      "id": "8"
    },
  ];



  @override
  State<Affordable> createState() => AffordableState();
}

class AffordableState extends State<Affordable> {
  final AuthService _authService = AuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Affordable Cars'),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,
        width: 250,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text('All Cars'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Carpage()));
              },
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // Car listing
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: widget.Aff.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.Aff.length,
                          itemBuilder: (context, index) {
                            final car = widget.Aff[index];
                            return GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           Cardetails(car: car),
                              //     ),
                              //   );
                              // },
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(car['image'],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${car['carname']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(Icons.attach_money),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Price: \$${car['price']} per hour',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.account_circle_sharp),
                                              Text('Owner: ${car['owner']}'),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
