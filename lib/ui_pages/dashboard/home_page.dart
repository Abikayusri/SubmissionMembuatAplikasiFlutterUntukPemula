import 'package:flutter/material.dart';
import 'package:submission_flutter_untuk_pemula/ui_pages/dashboard/car_detail_page.dart';
import 'package:submission_flutter_untuk_pemula/utils/snackbar_extension.dart';

import '../../model/pre_owned_car_data.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.showSuccessSnackBar(
        'Selamat datang, ${widget.username}! Login berhasil.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Hello, ${widget.username}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return PreOwnedCarList();
          } else if (constraints.maxWidth <= 1200) {
            return PreOwnedCarList();
            // return PreOwnedCarGrid(gridCount: 4);
          } else {
            return PreOwnedCarList();
            // return PreOwnedCarGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class PreOwnedCarList extends StatelessWidget {
  const PreOwnedCarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final car = preOwnedCarListData[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(car: car),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 140,
                      child: Image.network(
                        car.imageAssets,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Gambar tidak dapat dimuat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.teal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${car.name} (${car.buyYear})',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            car.brand,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            car.price,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: preOwnedCarListData.length,
      ),
    );
  }
}

class PreOwnedCarGrid extends StatelessWidget {
  final int gridCount;

  const PreOwnedCarGrid({super.key, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        children: preOwnedCarListData.map((car) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CarDetailPage(car: car);
                  },
                ),
              );
            },
            child: Card(child: Column()),
          );
        }).toList(),
      ),
    );
  }
}
