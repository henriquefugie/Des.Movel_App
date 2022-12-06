import 'dart:convert';
import 'dart:ffi';

import 'package:aplicativo/model/user_manager.dart';
import 'package:aplicativo/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/custom_drawer/custom_drawer.dart';

int passos = 0;
int pedometer = 0;
int total = 0;

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

void updatePassos(String passos) {
  final User currentUser = auth.currentUser!;
  final docUser = firestore.collection('users').doc(currentUser.uid);
  docUser.update({'passos': passos});
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashBoardState createState() => _DashBoardState();
}

Future<int>? loadCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final User currentUser = auth.currentUser!;
  (currentUser.uid);
  final docUser = firestore.collection('users').doc(currentUser.uid);
  firestore
      .collection('users')
      .doc(currentUser.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data() as Map;
      Usuario user = Usuario(
        email: data['email'],
        password: data["password"],
        name: data['name'],
        passos: data['passos'],
      );
      String userdata = json.encode(user);
      prefs.setString('userdata', userdata);
    } else {
      ('Document does not exist on the database');
    }
  });

  String username = prefs.getString('userdata') ?? "";
  (username);
  Map<String, dynamic> decodedMap = json.decode(username);
  return decodedMap['passos'];
}

class _DashBoardState extends State<Dashboard> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '', _steps = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void teste(StepCount event) {
    (event.steps);
  }

  void onStepCount(StepCount event) {
    (event);
    updatePassos(event.steps.toString());
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    (event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    ('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    (_status);
  }

  void onStepCountError(error) {
    ('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    loadCounter()?.then((path) {
      passos = path;
    });
    (passos);
    (pedometer);
    total = passos + pedometer;
    double porcentagemPassos = (int.parse(_steps)) / 9000;
    double calorias = (int.parse(_steps)) * 0.03;
    double distancia = (int.parse(_steps)) * 0.3;
    var caloriasString = calorias.toStringAsFixed(1);
    var distanciaString = distancia.toStringAsFixed(1);
    (porcentagemPassos);
    if (porcentagemPassos > 1) {
      porcentagemPassos = 0;
    }
    (total);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor.withAlpha(50),
                ),
                child: Image.asset(
                  'assets/img/shoe.png',
                  width: 60,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Text(
                _steps,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 80,
                  fontFamily: 'Bebas',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '0 Passos'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '9000 Passos'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    LinearPercentIndicator(
                      lineHeight: 8.0,
                      percent: porcentagemPassos,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondary.withAlpha(30),
                      progressColor: Theme.of(context).primaryColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Text(
                      'Total de passos'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontFamily: 'Bebas',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 25,
                color: Colors.grey[300],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'DISTANCIA',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: distanciaString,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const TextSpan(
                                text: ' M',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'CALORIAS',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: caloriasString,
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: ' CAL',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 25,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'PROGRESSO',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/img/down_orange.png',
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                      ),
                      Text(
                        caloriasString,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 255,
                padding: const EdgeInsets.all(10),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    StatCard(
                      title: ' Calorias',
                      alcance: calorias.roundToDouble(),
                      total: 3000.0,
                      color: Colors.green,
                      image: Image.asset(
                        'assets/img/sausage.png',
                        width: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double alcance;
  final Image image;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.total,
    required this.alcance,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              alcance < total
                  ? Image.asset(
                      'assets/img/down_orange.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/img/up_red.png',
                      width: 20,
                    ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: alcance / (total < alcance ? alcance : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: alcance.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextSpan(
                  text: ' / $total',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
