import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/plant_provider.dart';
import 'package:account/screens/plantform_screen.dart';
import 'package:account/screens/plantdetail_screen.dart';

class PlantHomeScreen extends StatelessWidget {
  const PlantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlantProvider>(builder: (context, provider, child) {
        if (provider.plants.isEmpty) {
          return const Center(child: Text('ไม่มีต้นไม้ในระบบ'));
        } else {
          return ListView.builder(
            itemCount: provider.plants.length,
            itemBuilder: (context, index) {
              var plant = provider.plants[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListTile(
                  title: Text(plant.name),
                  subtitle: Text(plant.scientificName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.deletePlant(plant.id);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailScreen(plant: plant),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlantFormScreen(), // สำหรับการเพิ่มต้นไม้ใหม่
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
