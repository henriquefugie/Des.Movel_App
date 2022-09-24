import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2022/08/26094036/5555E820-01D0-4475-AFCF-4765925B4873-1024x683.jpeg'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Joao',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sep, 23, 2022',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            child: Stack(
              children: <Widget>[
                Container(
                  width: 50,
                  child: const Icon(Icons.notifications),
                  color: Theme.of(context).accentColor,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  width: 20,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red,
                    ),
                    width: 20,
                    height: 20,
                    child: const Center(
                      child: Text(
                        '99',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
        child: Container(
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
                '6522',
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
                      percent: 0.7,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor:
                          Theme.of(context).accentColor.withAlpha(30),
                      progressColor: Theme.of(context).primaryColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Text(
                      'Total de passos'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Bebas',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Caminhou durante 13000 minutos hoje',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 25,
                color: Colors.grey[300],
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'DISTANCIA',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '9999',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
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
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CALORIAS',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '2',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor,
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
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'BATIMENTO CARDIACO',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '300',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const TextSpan(
                                  text: ' BPM',
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
              ),
              Divider(
                height: 25,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'PROGRESSO',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
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
                      const Text(
                        '2 Calorias',
                        style: TextStyle(
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
                padding: EdgeInsets.all(10),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    StatCard(
                      title: ' Carboidratos',
                      alcance: 200.0,
                      total: 350.0,
                      color: Colors.orange,
                      image: Image.asset(
                        'assets/img/bolt.png',
                        width: 20,
                      ),
                    ),
                    StatCard(
                      title: ' Proteinas',
                      alcance: 50.0,
                      total: 150.0,
                      color: Theme.of(context).primaryColor,
                      image: Image.asset(
                        'assets/img/fish.png',
                        width: 20,
                      ),
                    ),
                    StatCard(
                      title: ' Calorias',
                      alcance: 3000.0,
                      total: 2000.0,
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
                  color: Theme.of(context).accentColor.withAlpha(100),
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
                    color: Theme.of(context).accentColor,
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
