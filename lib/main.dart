import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: WeatherApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = 'Chennai';
  String country = '';
  String Climate = '';
  String city2 = 'Chennai';
  String Weatherdata = '';
  double temp = 0;
  double min = 0;
  double max = 0;
  double feels = 0;
  int itemp = 0;
  int imin = 0;
  int imax = 0;
  int ifeels = 0;
  int flag = 0;
  int ws = 0;
  int pre = 0;
  int hum = 0;
  double windspeed = 0;


  void fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=256c22e7dc831882c7fe861ee43ee869'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        flag = 1;
        Climate = jsonResponse['weather'][0]['main'];
        Weatherdata = jsonResponse['weather'][0]['description'];
        temp = jsonResponse['main']['temp'];
        temp -= 273.15;
        itemp = temp.toInt();
        min = jsonResponse['main']['temp_min'];
        min -= 273.15;
        imin = min.toInt();
        max = jsonResponse['main']['temp_max'];
        max -= 273.15;
        imax = max.toInt();
        feels = jsonResponse['main']['feels_like'];
        feels -= 273.15;
        ifeels = feels.toInt();
        city2=city;
        country = jsonResponse['sys']['country'];
        windspeed = jsonResponse['wind']['speed']*3.6;
        ws = windspeed.toInt();
        pre = jsonResponse['main']['pressure'];
        hum = jsonResponse['main']['humidity'];
      });
    } else {
      setState(() {
        flag = 0;
      });

    }

  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/appbarimage.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.purpleAccent.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 65,

      ),
      /* drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            ListTile(
              title: Text('Change Location'),
              ),

          ],
        ),
      ),*/
      backgroundColor: Colors.purpleAccent,
      body:
      Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              Climate == 'Clouds' ? 'assets/cloudbg.gif':
              Climate == 'Mist' ? 'assets/mistbg.gif':
              Climate == 'Haze' ? 'assets/hazebg.gif':
              Climate == 'Clear' ? 'assets/clearbg.gif':
              Climate == 'Smoke' ? 'assets/smokebg.gif':
              Climate == 'Rain' ? 'assets/rainbg.gif':
              Climate == 'Snow' ? 'assets/snowbg.gif':
              Climate == 'Drizzle' ? 'assets/drizzlebg.gif':
                  'assets/deafultbg.gif',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/appicon.jpg'),
                          radius: 25,
                        ),


                        TextField(
                          onChanged: (value) {
                            city = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter city',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: fetchWeatherData,
                          child: const Text('Get Weather'),
                        ),
                        Text(
                          flag == 0 ? 'City not found! \n':
                          '',
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.blueGrey,
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                    color: Colors.redAccent,
                                  ),
                                  Text( ' $city2,$country',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black45,
                                    ),),
                                ],
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Text('$itemp°',
                              style: const TextStyle(
                                fontSize: 25,
                              ),),
                          ],
                        ),
                        Text(Climate,
                          style: const TextStyle(
                            fontSize: 19,
                          ),),
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          child:
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
                            child: Column(
                              children: [
                                Image.asset(
                                  Climate == 'Clouds' ? 'assets/clouds.jpg':
                                  Climate == 'Mist' ? 'assets/mist.jpg':
                                  Climate == 'Smoke' ? 'assets/smoke.jpg':
                                  Climate == 'Clear' ? 'assets/clear.jpg':
                                  Climate == 'Rain' ? 'assets/rain.jpg':
                                  Climate == 'Haze' ? 'assets/haze.jpg':
                                  Climate == 'Snow' ? 'assets/snow1.jpg':
                                  Climate == 'Drizzle' ? 'assets/drizzle.jpg':
                                  'assets/appicon.jpg',
                                  height: 140,
                                  width: 180,

                                ),

                                Text('\n\n$imax°/$imin° \nFeels like $ifeels°\n ',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),),
                              ], ), ), ),
                        Column(
                          children: [
                            Text(Weatherdata.toUpperCase() ,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),),
                            const SizedBox(
                              height: 30,
                            ),

                          ],
                        ),
                         const Divider(
                          height: 10,
                           thickness: 3,
                           indent: 0,
                           color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  color: Colors.transparent,
                                  elevation: 100,
                                  child: Column(
                            children: [
                        const Row(
                                    children: [
                                       Icon(Icons.thermostat,
                                       color: Colors.orangeAccent),
                                       SizedBox(
                                        height:5,
                                        width: 10,),
                                      Text('Temperature ',
                                      style: TextStyle(
                                        fontSize: 20,
                                          color: Colors.orange,
                                      ),),
                                    ],
                                  ),
                              Row(
                                children: [
                                  Text('$itemp °',
                                  style: const TextStyle(
                                    fontSize: 30,
                                      color: Colors.orange,
                                  ),),
                                ],
                              )
            ],),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),

                                Card(
                                  elevation: 100,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.air),
                                          SizedBox(
                                            height:5,
                                            width: 10,),
                                          Text('Wind',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('  $ws km/h  ',
                                            style: const TextStyle(
                                              fontSize: 30,
                                            ),),
                                        ],
                                      )
                                    ],),
                                )

                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),


                            Row(
                              children: [
                                Card(

                                  elevation: 100,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      const Row(

                                        children: [
                                          Icon(
                                              Icons.compress_rounded,
                                              color: Colors.lightGreenAccent),
                                          SizedBox(
                                            height:5,
                                            width: 10,),
                                          Text('Pressure',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.lightGreenAccent,
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('  $pre mb  ',
                                            style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.lightGreenAccent,
                                            ),),
                                        ],
                                      )
                                    ],),
                                ),

                                const SizedBox(
                                  width: 60,
                                ),
                                Card(
                                  elevation: 100,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.water_drop_outlined,
                                            color: Colors.cyan,),
                                          SizedBox(
                                            height:5,
                                            width: 10,),
                                          Text(' Humidity     ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.cyan,
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('  $hum %',
                                            style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.cyan,
                                            ),),
                                        ],
                                      )
                                    ],),
                                ),

                              ],
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                ], ),
            ), ),
        ], ),


    );
  }

}
