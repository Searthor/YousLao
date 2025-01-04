class ProductModel {
  final int id;
  final String price;
  final String name;
  final int qty;
  final String? image;

  ProductModel({
    required this.id,
    required this.price,
    required this.name,
    required this.qty,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      price: json['total_price'],
      name: json['name'],
      qty: json['qty'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_price': price,
      'name': name,
      'qty': qty,
      'image': image,
    };
  }
}

class TableProductModel {
  final int id;
  final String price;
  final String name;
  final String? image;
  final int qty;

  TableProductModel({
    required this.id,
    required this.price,
    required this.name,
    this.image,
    required this.qty,
  });

  factory TableProductModel.fromJson(Map<String, dynamic> json) {
    return TableProductModel(
      id: json['id'],
      price: json['total_price'],
      name: json['name'],
      image: json['image'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_price': price,
      'name': name,
      'image': image,
      'qty': qty,
    };
  }
}


class MenuNote {
  final int id;
  final String title;
  final String type;

  MenuNote({
    required this.id,
    required this.title,
    required this.type,
  });

  factory MenuNote.fromJson(Map<String, dynamic> json) {
    return MenuNote(
      id: json['id'],
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
    };
  }
}
