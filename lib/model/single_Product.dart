// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unnecessary_new, prefer_collection_literals, unnecessary_this

import 'package:project/model/ProductModel.dart';

class SingleProduct {
  bool? success;
  var status;
  String? message;
  Data? data;

  SingleProduct({this.success, this.status, this.message, this.data});

  SingleProduct.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ProductDetails? productDetails;
  List<Products>? products;

  Data({this.productDetails, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  int? id;
  String? productUniId;
  String? userUniId;
  String? categoryId;
  String? subCategoryId;
  String? product;
  String? image;
  String? price;
  String? discount;
  String? description;
  String? quantity;
  String? unitType;
  int? stock;
  int? status;
  int? trash;
  String? createdAt;
  String? updatedAt;

  ProductDetails(
      {this.id,
      this.productUniId,
      this.userUniId,
      this.categoryId,
      this.subCategoryId,
      this.product,
      this.image,
      this.price,
      this.discount,
      this.description,
      this.quantity,
      this.unitType,
      this.stock,
      this.status,
      this.trash,
      this.createdAt,
      this.updatedAt});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productUniId = json['product_uni_id'];
    userUniId = json['user_uni_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    product = json['product'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    description = json['description'];
    quantity = json['quantity'];
    unitType = json['unit_Type'];
    stock = json['stock'];
    status = json['status'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_uni_id'] = this.productUniId;
    data['user_uni_id'] = this.userUniId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product'] = this.product;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['unit_Type'] = this.unitType;
    data['stock'] = this.stock;
    data['status'] = this.status;
    data['trash'] = this.trash;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
