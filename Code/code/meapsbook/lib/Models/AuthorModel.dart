class AuthorModel{
  String? hovaten;
  String? namsinh;
  String? quequan;
  String? coverImage;

  AuthorModel({this.hovaten, this.namsinh, this.quequan, this.coverImage});

  AuthorModel.fromJson(Map<String, dynamic>json) {
    if (json["hovaten"] is String ){
      hovaten = json["hovaten"];
    }
     if (json["namsinh"] is String) {
      namsinh = json["namsinh"];
    }
    if (json["quequan"] is String) {
      quequan = json["quequan"];
    }
     if (json["coverImage"] is String) {
      coverImage = json["coverImage"];
    }
  }

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> _data=<String,dynamic> {};
      _data["hovaten"] = hovaten;
      _data["namsinh"] = namsinh;
      _data["quequan"] = quequan;
      _data["coverImage"] = coverImage;
      return _data;

  }



 
}