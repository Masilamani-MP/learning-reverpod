

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reverpod/second_page.dart';

import 'main.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  Position? position;
  String? address;

  @override
  void initState() {
    super.initState();
    getLocation();
  }
  Future<void> getLocation() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     if(position != null){
       List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);

       Placemark place = placemarks[0];
       setState(() {
         address = '${place.locality.toString()}, ${place.street.toString()},';
       });
       ref.read(addressProvider.notifier).state = place;
     }
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Location Coordinates'),
            const SizedBox(height: 15,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Latitude : ${position?.latitude}'),
                Text('Langitude : ${position?.longitude}'),
              ],
            ),
            const SizedBox(height: 30,),

            const Text('Current Location'),
            const SizedBox(height: 15,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(address ?? ''),
              ],
            ),

            ElevatedButton(
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Secondpage()),
                  );
                },
                child: Text('second page'))
          ],
        ),
      ),
    );
  }
}