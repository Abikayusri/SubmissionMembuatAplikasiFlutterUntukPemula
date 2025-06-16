import 'package:flutter/material.dart';

import '../../model/pre_owned_car_data.dart';

class CarDetailPage extends StatelessWidget {
  final PreOwnedCarListData car;

  const CarDetailPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(car.imageAssets, fit: BoxFit.cover),

            SizedBox(height: 20),

            Text(
              '${car.name} (${car.buyYear})',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Ikhtisar',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ikhtisarData('Location', car.location),
                      _ikhtisarData('Transmition', car.fuelTransmission),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
              child: Text(
                'Description',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8),

            Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                car.description,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14),
              ),
            ),

            SizedBox(height: 12),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: car.imageUrl.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _ikhtisarData(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _getIconByTitle(title),

      SizedBox(width: 8),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(description),
        ],
      ),
    ],
  );
}

Widget _getIconByTitle(String title) {
  switch (title.toLowerCase()) {
    case 'seller':
      return Icon(Icons.person);
    case 'location':
      return Icon(Icons.location_on);
    default:
      return Icon(Icons.info);
  }
}
