import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/plant_provider.dart';
import 'package:account/models/plants.dart';

class PlantFormScreen extends StatefulWidget {
  final Plant? plant; // เพิ่ม parameter สำหรับต้นไม้ที่มีอยู่

  const PlantFormScreen({this.plant, super.key});

  @override
  _PlantFormScreenState createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final scientificNameController = TextEditingController();
  final typeController = TextEditingController();
  final habitatController = TextEditingController();
  final shapeController = TextEditingController();

  bool hasFlowers = false;
  final flowerSizeController = TextEditingController();
  final flowerColorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.plant != null) {
      nameController.text = widget.plant!.name;
      scientificNameController.text = widget.plant!.scientificName;
      typeController.text = widget.plant!.type;
      habitatController.text = widget.plant!.habitat;
      shapeController.text = widget.plant!.shape;
      hasFlowers = widget.plant!.hasFlowers;
      if (hasFlowers) {
        flowerSizeController.text = widget.plant!.flowerSize?.toString() ?? '';
        flowerColorController.text = widget.plant!.flowerColor ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มต้นไม้'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อต้นไม้'),
                controller: nameController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกชื่อต้นไม้';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'ชื่อทางวิทยาศาสตร์'),
                controller: scientificNameController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกชื่อทางวิทยาศาสตร์';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ประเภทต้นไม้'),
                controller: typeController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกประเภทต้นไม้';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ถิ่นกำเนิด'),
                controller: habitatController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกถิ่นกำเนิด';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'รูปทรงของต้นไม้'),
                controller: shapeController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกรูปทรงของต้นไม้';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('ดอก'),
                value: hasFlowers,
                onChanged: (bool value) {
                  setState(() {
                    hasFlowers = value;
                  });
                },
              ),
              if (hasFlowers) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ขนาดของดอก'),
                  controller: flowerSizeController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกขนาดของดอก';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'สีของดอก'),
                  controller: flowerColorController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกสีของดอก';
                    }
                    return null;
                  },
                ),
              ],
              TextButton(
                child: const Text('บันทึก'),
                onPressed: () async {
                  // เปลี่ยนเป็น async
                  if (formKey.currentState!.validate()) {
                    final flowerSize =
                        double.tryParse(flowerSizeController.text);
                    if (hasFlowers && flowerSize == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('กรุณากรอกขนาดของดอกให้ถูกต้อง')),
                      );
                      return;
                    }

                    var plant = Plant(
                      id: widget.plant?.id,
                      name: nameController.text,
                      scientificName: scientificNameController.text,
                      type: typeController.text,
                      habitat: habitatController.text,
                      shape: shapeController.text,
                      hasFlowers: hasFlowers,
                      flowerSize: hasFlowers ? flowerSize : null,
                      flowerColor:
                          hasFlowers ? flowerColorController.text : null,
                    );

                    var provider =
                        Provider.of<PlantProvider>(context, listen: false);
                    if (widget.plant == null) {
                      await provider.addPlant(plant);
                    } else {
                      await provider.updatePlant(plant);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('บันทึกต้นไม้เรียบร้อยแล้ว')),
                    );

                    // กลับไปที่หน้า PlantHomeScreen
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
