import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickride/auth/firebaseAuth.dart';
import 'package:quickride/intro/loginsignup/loginpage.dart';
import 'package:quickride/views/affordable.dart';
import 'package:quickride/views/detailspage.dart';
import '../model/carmodel.dart';
import 'dart:convert';

import '../views/profile.dart';

class Carpage extends StatefulWidget {
  const Carpage({super.key});

  @override
  State<Carpage> createState() => _CarpageState();
}

class _CarpageState extends State<Carpage> {
  List<CarModel> carmodel = [];
  List<CarModel> filteredCars = [];
  int _selectedIndex = 0;
  final FocusNode _focusNode = FocusNode();
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  Future<void> _fetchCars() async {
    final response = await http
        .get(Uri.parse('https://66d06062181d059277de5408.mockapi.io/carapi'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      List jsonResponse = jsonDecode(response.body);
      setState(() {
        carmodel = jsonResponse
            .map((carmodels) => CarModel.fromJson(carmodels))
            .toList();
        filteredCars = carmodel;
      });
      print('response is successful');
    } else {
      throw Exception('Failed to load');
    }
  }

  void _filterCars(String query) {
    final filtered = carmodel
        .where((car) => car.carname.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredCars = filtered;
    });
  }

  void _dismissKeyboard() {
    _focusNode.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _focusNode.requestFocus();
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  Future<void> _Signout() async {
    await _authService.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text('QuickRide'),
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
                title: Text('SignOut'),
                onTap: () {
                  _Signout();
                },
              ),
              ListTile(
                title: Text('Affordable Cars'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Affordable()));
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
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 10)
                      ],
                    ),
                    child: TextField(
                      focusNode: _focusNode,
                      onChanged: _filterCars,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Vehicle...',
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                // Heading and logos row
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Top Brands',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/mercedes.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/bmw.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/ford.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/tesla.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Car listing
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: filteredCars.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredCars.length,
                            itemBuilder: (context, index) {
                              final car = filteredCars[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Cardetails(car: car)));
                                },
                                child: Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(car.image,
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
                                              '${car.carname}',
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
                                                  'Price: \$${car.price} per hour',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.account_circle_sharp),
                                                Text('Owner: ${car.owner}'),
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black, // Background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex, // Track the selected item
            onTap: _onItemTapped, // Handle item tap
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
