class TableModel {
  final int id;   
  final String name;
  final int branch_id;
  final String branch_name;
  final int status;



  TableModel({
    required this.id,
    required this.name,
    required this.branch_id,
    required this.branch_name,
    required this.status,

    });
  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      name: json['name'],
      branch_id: json['branch_id'],
      branch_name: json['branch_name'],
      status: json['status'],
    );
  }
}