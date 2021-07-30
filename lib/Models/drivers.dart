import 'package:firebase_database/firebase_database.dart';

class Drivers
{
  String name;
  String phone;
  String email;
  String id;
  // ignore: non_constant_identifier_names
  String car_color;
  // ignore: non_constant_identifier_names
  String car_model;
  // ignore: non_constant_identifier_names
  String car_number;

  // ignore: non_constant_identifier_names
  Drivers({required this.name, required this.phone, required this.email, required this.id, required this.car_color, required this.car_model, required this.car_number,});

  Drivers.fromSnapshot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key!;
    phone = dataSnapshot.value["phone"];
    email = dataSnapshot.value["email"];
    name = dataSnapshot.value["name"];
    car_color = dataSnapshot.value["car_details"]["car_color"];
    car_model = dataSnapshot.value["car_details"]["car_model"];
    car_number = dataSnapshot.value["car_details"]["car_number"];
  }
}