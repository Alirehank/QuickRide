import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickride/model/carmodel.dart';

class Cardetails extends StatefulWidget {
  final CarModel car;

  const Cardetails({super.key, required this.car});

  @override
  State<Cardetails> createState() => _CardetailsState();
}

class _CardetailsState extends State<Cardetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(widget.car.carname,
            style:
                TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image.network(
                widget.car.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // Display car name
              Text(
                widget.car.carname,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star),
                  Text(
                    '4.5 [105 Reviews]',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.network(fit: BoxFit.cover,widget.car.ownerimg, height: 50, width: 50)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.car.owner),
                  Spacer(),
                  Icon(Icons.phone),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.message)
                ],
              ),
              Text('Renter'),
              SizedBox(
                height: 10,
              ),
              Divider(),

              Text(
                'Car Info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.local_gas_station),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Fuel Type:Petrol'),
                  Spacer(),
                  FaIcon(FontAwesomeIcons.snowflake),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Air Conditioned')
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.gear),
                  Text('Engine: 2000cc'),
                  SizedBox(
                    width: 52,
                  ),
                  FaIcon(FontAwesomeIcons.carSide),
                  Text(' 4 Doors')
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(child: Text('Booking Sucessfull')),
                        )
                    );
                  },
                  child: Text(
                    'Book Now | \$${widget.car.price} per hour',
                    style: TextStyle(fontSize: 18),
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
