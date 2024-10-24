// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class Categrory {
  bool? success;
  int? status;
  String? message;
  List<CategroryData>? data;

  Categrory({this.success, this.status, this.message, this.data});

  Categrory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategroryData>[];
      json['data'].forEach((v) {
        data!.add( CategroryData.fromJson(v));
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

class CategroryData {
  int? id;
  String? name;
  String? image;
  String? des;
  String? trash;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<SubCategory>? subCategory;

  CategroryData(
      {this.id,
      this.name,
      this.image,
      this.des,
      this.trash,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subCategory});

  CategroryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    des = json['des'];
    trash = json['trash'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['des'] = this.des;
    data['trash'] = this.trash;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int? id;
  String? categoryId;
  String? subcategories;
  String? trash;
  String? status;
  String? createdAt;
  String? updatedAt;

  SubCategory(
      {this.id,
      this.categoryId,
      this.subcategories,
      this.trash,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategories = json['subcategories'];
    trash = json['trash'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategories'] = this.subcategories;
    data['trash'] = this.trash;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
