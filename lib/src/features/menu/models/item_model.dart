class ItemModel {
  final String name;
  final int price;
  final String? imagePath;

  const ItemModel({
    required this.name,
    required this.price,
    this.imagePath,
  });

  factory ItemModel.fromJSON(Map<String, dynamic> json) {
    return ItemModel(
      imagePath: json['imagePath'],
      name: json['name'],
      price: json['price'],
    );
  }

}