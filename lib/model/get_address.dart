// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetAdress {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  GetAdress({this.success, this.status, this.message, this.data});

  GetAdress.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userUniId;
  String? address;
  int? cityId;
  int? stateId;
  int? countryId;
  int? pincode;
  String? type;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  String? cityName;
  String? stateName;
  String? countryName;
  String? completeAddress;

  Data(
      {this.id,
      this.userUniId,
      this.address,
      this.cityId,
      this.stateId,
      this.countryId,
      this.pincode,
      this.type,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.cityName,
      this.stateName,
      this.countryName,
      this.completeAddress});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    address = json['address'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    pincode = json['pincode'];
    type = json['type'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    countryName = json['Country_name'];
    completeAddress = json['complete_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_uni_id'] = this.userUniId;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    data['pincode'] = this.pincode;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['Country_name'] = this.countryName;
    data['complete_address'] = this.completeAddress;
    return data;
  }
}
