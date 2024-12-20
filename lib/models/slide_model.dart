class SlideModel {
  final int id;   
  final String image;
 


  SlideModel({
    required this.id,
    required this.image,
   
    });
  factory SlideModel.fromJson(Map<String, dynamic> json) {
    return SlideModel(
      id: json['id'],
      image: json['image'],
    );
  }
}