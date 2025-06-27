enum ProductCategory {
  phones,
  laptops,
  tablets,
  headphones,
  speakers,
  cameras,
  gaming,
  smartwatches,
  smarthome,
  other,
}

class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final ProductCategory category;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.isFavourite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
      price: double.parse(json['price'].toString()),
      category: _categoryFromString(json['category']),
    );
  }

  static ProductCategory _categoryFromString(String category) {
    switch (category) {
      case 'phones':
        return ProductCategory.phones;
      case 'laptops':
        return ProductCategory.laptops;
      case 'tablets':
        return ProductCategory.tablets;
      case 'headphones':
        return ProductCategory.headphones;
      case 'speakers':
        return ProductCategory.speakers;
      case 'cameras':
        return ProductCategory.cameras;
      case 'gaming':
        return ProductCategory.gaming;
      case 'smartwatches':
        return ProductCategory.smartwatches;
      case 'smarthome':
        return ProductCategory.smarthome;
      default:
        return ProductCategory.other;
    }
  }
} 
