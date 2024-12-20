class ProfileModel {
  int? id;
  String? phone;
  String? fullname;
  String? image;

  ProfileModel(
      {this.id,
      this.phone,
      this.fullname,
      this.image,
      });
  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    fullname = json['fullname'];
    image = json['image'] ?? '';
  }
}