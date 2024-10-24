// ignore_for_file: file_names
// class profileModel {
//   bool? success;
//   int? status;
//   String? message;
//   Data? data;

//   profileModel({this.success, this.status, this.message, this.data});

//   profileModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   String? userUniId;
//   String? email;
//   String? countryCode;
//   int? phone;
//   Null? emailVerifiedAt;
//   int? gender;
//   String? image;
//   int? isProfileComplete;
//   int? role;
//   Null? packageId;
//   Null? packageCreate;
//   Null? packageExpire;
//   int? trash;
//   int? isVerified;
//   String? createdAt;
//   String? updatedAt;
//   Address? address;
//   Wallet? wallet;

//   Data(
//       {this.id,
//       this.name,
//       this.userUniId,
//       this.email,
//       this.countryCode,
//       this.phone,
//       this.emailVerifiedAt,
//       this.gender,
//       this.image,
//       this.isProfileComplete,
//       this.role,
//       this.packageId,
//       this.packageCreate,
//       this.packageExpire,
//       this.trash,
//       this.isVerified,
//       this.createdAt,
//       this.updatedAt,
//       this.address,
//       this.wallet});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     userUniId = json['user_uni_id'];
//     email = json['email'];
//     countryCode = json['country_code'];
//     phone = json['phone'];
//     emailVerifiedAt = json['email_verified_at'];
//     gender = json['gender'];
//     image = json['image'];
//     isProfileComplete = json['is_profile_complete'];
//     role = json['role'];
//     packageId = json['package_id'];
//     packageCreate = json['package_create'];
//     packageExpire = json['package_expire'];
//     trash = json['trash'];
//     isVerified = json['is_verified'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     address =
//         json['address'] != null ? new Address.fromJson(json['address']) : null;
//     wallet =
//         json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['user_uni_id'] = this.userUniId;
//     data['email'] = this.email;
//     data['country_code'] = this.countryCode;
//     data['phone'] = this.phone;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['gender'] = this.gender;
//     data['image'] = this.image;
//     data['is_profile_complete'] = this.isProfileComplete;
//     data['role'] = this.role;
//     data['package_id'] = this.packageId;
//     data['package_create'] = this.packageCreate;
//     data['package_expire'] = this.packageExpire;
//     data['trash'] = this.trash;
//     data['is_verified'] = this.isVerified;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     if (this.wallet != null) {
//       data['wallet'] = this.wallet!.toJson();
//     }
//     return data;
//   }
// }

// class Address {
//   int? id;
//   String? userUniId;
//   String? address;
//   int? cityId;
//   int? stateId;
//   int? countryId;
//   int? pincode;
//   String? type;
//   int? isDefault;
//   String? createdAt;
//   String? updatedAt;
//   String? cityName;
//   String? stateName;
//   String? countryName;

//   Address(
//       {this.id,
//       this.userUniId,
//       this.address,
//       this.cityId,
//       this.stateId,
//       this.countryId,
//       this.pincode,
//       this.type,
//       this.isDefault,
//       this.createdAt,
//       this.updatedAt,
//       this.cityName,
//       this.stateName,
//       this.countryName});

//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userUniId = json['user_uni_id'];
//     address = json['address'];
//     cityId = json['city_id'];
//     stateId = json['state_id'];
//     countryId = json['country_id'];
//     pincode = json['pincode'];
//     type = json['type'];
//     isDefault = json['is_default'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     cityName = json['city_name'];
//     stateName = json['state_name'];
//     countryName = json['Country_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_uni_id'] = this.userUniId;
//     data['address'] = this.address;
//     data['city_id'] = this.cityId;
//     data['state_id'] = this.stateId;
//     data['country_id'] = this.countryId;
//     data['pincode'] = this.pincode;
//     data['type'] = this.type;
//     data['is_default'] = this.isDefault;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['city_name'] = this.cityName;
//     data['state_name'] = this.stateName;
//     data['Country_name'] = this.countryName;
//     return data;
//   }
// }

// class Wallet {
//   int? id;
//   String? userUniId;
//   String? amount;
//   int? status;
//   String? createdAt;
//   String? updatedAt;

//   Wallet(
//       {this.id,
//       this.userUniId,
//       this.amount,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Wallet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userUniId = json['user_uni_id'];
//     amount = json['amount'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_uni_id'] = this.userUniId;
//     data['amount'] = this.amount;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
