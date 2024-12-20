class AllRestaurantModel {
  final int id;  
  final int ? menu;  
  final String name;
  final String phone;
  final String? image;
  final String? province;
  final String? district;
  final String? village;


  AllRestaurantModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.menu,
    this.image,
    this.province,
    this.village,
    this.district


    });

  factory AllRestaurantModel.fromJson(Map<String, dynamic> json) {
    return AllRestaurantModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      menu: json['menu'],
      image: json['image'],
      province: json['province'],
      district: json['District'],
      village: json['Village'],
    );
  }
}

class getRestaurant {
  final int id;  
  final String name;
  final String phone;
  final String? image;
  final String? avatar;
  final String? province;
  final String? district;
  final String? village;
  

  getRestaurant({
    required this.id,
    required this.name,
    required this.phone,
    this.image,
    this.avatar,
    this.province,
    this.village,
    this.district
    });
  factory getRestaurant.fromJson(Map<String, dynamic> json) {
    return getRestaurant(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      avatar: json['avatar'],
      province: json['province'],
      district: json['District'],
      village: json['Village'],
    );
  }
}


class getRestaurantmenu {
  final int id;  
  final String price;  
  final String name;
  final String? image;
  
  getRestaurantmenu({
    required this.id,
    required this.price,
    required this.name,
    this.image,

    });
  factory getRestaurantmenu.fromJson(Map<String, dynamic> json) {
    return getRestaurantmenu(
      id: json['id'],
      price: json['total_price'],
      name: json['name'],
      image: json['image']
    );
  }
}