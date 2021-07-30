import 'package:carly_drivers_app/AllScreens/newRideScreen.dart';
import 'package:carly_drivers_app/AllScreens/registrationScreen.dart';
import 'package:carly_drivers_app/Assistants/assistantMethods.dart';
import 'package:carly_drivers_app/Models/rideDetails.dart';
import 'package:carly_drivers_app/configMaps.dart';
import 'package:carly_drivers_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget
{
  final RideDetails rideDetails;

  NotificationDialog({required this.rideDetails});

  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.0),
            Image.asset("images/carlyX.jpeg", width: 150.0,),
            SizedBox(height: 0.0,),
            Text("New Ride Request", style: TextStyle(fontFamily: "Brand Bold", fontSize: 20.0,),),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/pickicon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: Container(child: Text(rideDetails.pickup_address, style: TextStyle(fontSize: 18.0),)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/desticon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 20.0,),
                      Expanded(
                          child: Container(child: Text(rideDetails.dropoff_address, style: TextStyle(fontSize: 18.0),))
                      ),
                    ],
                  ),
                  SizedBox(height: 0.0),

                ],
              ),
            ),

            SizedBox(height: 15.0),
            Divider(height: 2.0, thickness: 4.0,),
            SizedBox(height: 0.0),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      backgroundColor: Colors.white,
                      primary: Colors.red,
                      padding: EdgeInsets.all(8.0),
                    ),

                    onPressed: ()
                    {
                      assetsAudioPlayer.stop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),

                  SizedBox(width: 25.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green)),
                    ),
                    onPressed: ()
                    {
                      assetsAudioPlayer.stop();
                      checkAvailabilityOfRide(context);
                    },
                    child: Text("Accept".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),

                ],
              ),
            ),

            SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }
  
  void checkAvailabilityOfRide(context)
  {
    rideRequestRef.once().then((DataSnapshot dataSnapShot){
      Navigator.pop(context);
      String theRideId = "";
      if(dataSnapShot.value != null)
      {
        theRideId = dataSnapShot.value.toString();
      }
      else
      {
        displayToastMessage("Ride not exists.", context);
      }


      if(theRideId == rideDetails.ride_request_id)
      {
        rideRequestRef.set("accepted");
        AssistantMethods.disableHomeTabLiveLocationUpdates();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NewRideScreen(rideDetails: rideDetails)));
      }
      else if(theRideId == "cancelled")
      {
        displayToastMessage("Ride has been Cancelled.", context);
      }
      else if(theRideId == "timeout")
      {
        displayToastMessage("Ride has time out.", context);
      }
      else
      {
        displayToastMessage("Ride not exists.", context);
      }
    });
  }
}