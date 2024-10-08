class Plant {
  int? id; // เปลี่ยนจาก keyID เป็น id
  final String name; // เปลี่ยนจาก title เป็น name
  final String scientificName; // ชื่อทางวิทยาศาสตร์
  final String type; // ประเภทต้นไม้
  final String habitat; // ถิ่นกำเนิด
  final String shape; // รูปทรงของต้นไม้
  final bool hasFlowers; // มีดอกหรือไม่
  final double? flowerSize; // ขนาดของดอก
  final String? flowerColor; // สีของดอก

  Plant({
    this.id,
    required this.name,
    required this.scientificName,
    required this.type,
    required this.habitat,
    required this.shape,
    required this.hasFlowers,
    this.flowerSize,
    this.flowerColor,
  });

  @override
  String toString() {
    return 'Plant{id: $id, name: $name, scientificName: $scientificName, type: $type, habitat: $habitat, shape: $shape, hasFlowers: $hasFlowers, flowerSize: $flowerSize, flowerColor: $flowerColor}';
  }
}
