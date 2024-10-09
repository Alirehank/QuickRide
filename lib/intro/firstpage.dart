
import 'package:flutter/material.dart';
import 'loginsignup/loginpage.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  void changepage(BuildContext context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Wrap with MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Rent The Car Of Your Dreams',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Enjoy Luxury Experience',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          Image.asset(
            'assets/images/1727374197949z5pptjwr.webp',
          ),
          SizedBox(height: 50,),
          Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () => changepage(context),
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
              ))
        ],
      ),
    );
  }
}
