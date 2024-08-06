import 'package:flutter/material.dart';

class CardCarnet extends StatelessWidget {
  const CardCarnet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sena Card'),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.asset('images/1.jpg'),
                title: const Text('Juan Eduardo'),
                subtitle: const Text('Ochoa Cordoba'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Cc: 1.059.917.347', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('RH: 0+', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('Programa: ADSO', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Ficha: 2669742', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('Regional Cauca', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('C.T.P.I.', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}