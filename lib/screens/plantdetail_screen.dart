import 'package:flutter/material.dart';
import 'package:account/models/plants.dart';
import 'package:account/screens/plantform_screen.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({required this.plant, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantFormScreen(plant: plant),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ชื่อทางวิทยาศาสตร์: ${plant.scientificName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('ประเภท: ${plant.type}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('ถิ่นกำเนิด: ${plant.habitat}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('รูปทรง: ${plant.shape}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('มีดอก: ${plant.hasFlowers ? "ใช่" : "ไม่ใช่"}', style: const TextStyle(fontSize: 18)),
            if (plant.hasFlowers) ...[
              const SizedBox(height: 8),
              Text('ขนาดของดอก: ${plant.flowerSize ?? "N/A"}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('สีของดอก: ${plant.flowerColor ?? "N/A"}', style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
