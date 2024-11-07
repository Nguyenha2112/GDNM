

class TheLoaiModel {
  int? id;
  String? ten;
  String? coverImage;

  TheLoaiModel({this.id, required this.ten, required this.coverImage});

  TheLoaiModel.fromJson(Map<String, dynamic>json) {
    if (json["id"] is int ){
      id = json["id"];
    }
     if (json["ten"] is String) {
      ten = json["ten"];
    }
     if (json["coverImage"] is String) {
      coverImage = json["coverImage"];
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> _data = <String, dynamic>{};
      _data["id"] = id;
      _data["ten"] = ten;
      _data["coverImage"] = coverImage;
      return _data;
  }
  


}