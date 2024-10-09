import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/ProfileModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ProfileModel> profiles = [];
  bool isLoading = true;

  // Controllers for adding a new car
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carPriceController = TextEditingController();
  final TextEditingController carImageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfiles(); // Fetch the data when the widget is initialized
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    carNameController.dispose();
    carColorController.dispose();
    carPriceController.dispose();
    carImageController.dispose();
    super.dispose();
  }

  Future<void> fetchProfiles() async {
    try {
      final response = await http.get(
          Uri.parse('https://66d06062181d059277de5408.mockapi.io/profile'));

      if (response.statusCode == 200) {
        setState(() {
          profiles = profileModelFromJson(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load profiles');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addCar(ProfileModel newCar) async {
    try {
      final response = await http.post(
        Uri.parse('https://66d06062181d059277de5408.mockapi.io/profile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newCar.toJson()),
      );

      if (response.statusCode == 201) {
        setState(() {
          profiles.add(newCar);
        });
        clearTextFields();
      } else {
        throw Exception('Failed to add car');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCar(String id, ProfileModel updatedCar) async {
    try {
      final response = await http.put(
        Uri.parse('https://66d06062181d059277de5408.mockapi.io/profile/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedCar.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          final index = profiles.indexWhere((car) => car.id == id);
          if (index != -1) {
            profiles[index] = updatedCar;
          }
        });
      } else {
        throw Exception('Failed to update car');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCar(String id) async {
    try {
      final response = await http.delete(
          Uri.parse('https://66d06062181d059277de5408.mockapi.io/profile/$id'));

      if (response.statusCode == 200) {
        setState(() {
          profiles.removeWhere((car) => car.id == id);
        });
      } else {
        throw Exception('Failed to delete car');
      }
    } catch (e) {
      print(e);
    }
  }

  void clearTextFields() {
    carNameController.clear();
    carColorController.clear();
    carPriceController.clear();
    carImageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyYf3ArTo30OMbVD8TISYQu8KyhyrrVtc96Q&s',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              )),
                          Text(
                            'User Name',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'aliR',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Ali Rehan",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Divider(),
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('alirehan2460@gmail.com',
                        style: TextStyle(color: Colors.grey)),
                    Divider(),
                    SizedBox(
                      height: 50,
                    ),

                    Text('ADD NEW CARS',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(height: 10),
                    TextField(
                      controller: carNameController,
                      decoration: InputDecoration(
                          labelText: 'Car Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: carColorController,
                      decoration: InputDecoration(
                          labelText: 'Car Color',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: carPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Car Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: carImageController,
                      decoration: InputDecoration(
                          labelText: 'Car Image URL',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final newCar = ProfileModel(
                            carname: carNameController.text,
                            carimg: carImageController.text,
                            price: carPriceController.text,
                            color: carColorController.text,
                            id: '',
                          );
                          addCar(newCar);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(child: Text('Added Sucessfully')),
                          ));
                        },
                        child: Text('ADD'),
                      ),
                    ),
                    SizedBox(height: 30),


                    Center(
                        child:
                            Text('Car List', style: TextStyle(fontSize: 25))),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        final profile = profiles[index];

                        final TextEditingController carNameController =
                            TextEditingController(text: profile.carname);
                        final TextEditingController carColorController =
                            TextEditingController(text: profile.color);
                        final TextEditingController carPriceController =
                            TextEditingController(text: profile.price);

                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(profile.carimg,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [

                                    TextField(
                                      controller: carNameController,
                                      decoration: InputDecoration(
                                          labelText: 'Car Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      controller: carColorController,
                                      decoration: InputDecoration(
                                          labelText: 'Car Color',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      controller: carPriceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: 'Car Price',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                    ),
                                    SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.black),
                                          onPressed: () {

                                            final updatedCar = ProfileModel(
                                              carname: carNameController.text,
                                              carimg: profile.carimg,
                                              price: carPriceController.text,
                                              color: carColorController.text,
                                              id: profile.id,
                                            );
                                            //Update
                                            updateCar(profile.id, updatedCar);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Center(
                                                  child: Text(
                                                      'Updated Successful')),
                                            ));
                                          },
                                          child: Text('Update'),
                                        ),
                                        TextButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.black),
                                          onPressed: () {
                                            // Delete the car
                                            deleteCar(profile.id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Center(
                                                  child: Text(
                                                      'Deleted Sucessfull')),
                                            ));
                                          },
                                          child: Text(
                                            'Delete',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
