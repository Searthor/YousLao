class HistoryModel {
  final int id;   
  final String shop;
  final int count;
  final int total_price;
  final int status;
  final String date;
 


  HistoryModel({
    required this.id,
    required this.shop,
    required this.count,
    required this.total_price,
    required this.status,
    required this.date,
   
    });
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      shop: json['shop'],
      count: json['count'],
      total_price: json['total_price'],
      status: json['status'],
      date: json['date'],
    );
  }
}


class HistoryDetailModel {
  final int id;
  final String shop;
  final int status;
  final String code;
  final List<Product> product;
  final int total;
  final String date;

  HistoryDetailModel({
    required this.id,
    required this.shop,
    required this.status,
    required this.code,
    required this.product,
    required this.total,
    required this.date,
  });

  // Factory constructor for creating an instance from JSON.
  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) {
    return HistoryDetailModel(
      id: json['id'],
      shop: json['shop'],
      status: json['status'],
      code: json['code'],
      product: (json['product'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      total: json['total'],
      date: json['date'],
    );
  }

  // Method to convert an instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop': shop,
      'status': status,
      'code': code,
      'product': product.map((p) => p.toJson()).toList(),
      'date': date,
      'total': total,
    };
  }
}

class Product {
  final int productId;
  final String name ;
  final String productPrice;
  final String total_price;
  final String qty;

  Product({
    required this.productId,
    required this.productPrice,
    required this.total_price,
    required this.name,
    required this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productPrice: json['product_price'],
      total_price: json['total_price'],
      name: json['product_name'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'product_price': productPrice,
      'total_price': total_price,
      'qty': qty,
  
    };
  }
}
