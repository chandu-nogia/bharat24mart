// class CartEditModel {
//   bool? success;
//   int? status;
//   String? message;
//   List<CartEditModelData>? data;

//   CartEditModel({this.success, this.status, this.message, this.data});

//   CartEditModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <CartEditModelData>[];
//       json['data'].forEach((v) {
//         data!.add(new CartEditModelData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CartEditModelData {
//   int? id;
//   int? userId;
//   int? productId;
//   String? productName;
//   int? productAmount;
//   int? productQuantity;
//   int? totalAmount;
//   int? status;
//   int? trash;
//   String? createdAt;
//   String? updatedAt;
//   Product? product;

//   CartEditModelData(
//       {this.id,
//       this.userId,
//       this.productId,
//       this.productName,
//       this.productAmount,
//       this.productQuantity,
//       this.totalAmount,
//       this.status,
//       this.trash,
//       this.createdAt,
//       this.updatedAt,
//       this.product});

//   CartEditModelData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     productId = json['product_id'];
//     productName = json['product_name'];
//     productAmount = json['product_amount'];
//     productQuantity = json['product_quantity'];
//     totalAmount = json['total_amount'];
//     status = json['status'];
//     trash = json['trash'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     product =
//         json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['product_id'] = this.productId;
//     data['product_name'] = this.productName;
//     data['product_amount'] = this.productAmount;
//     data['product_quantity'] = this.productQuantity;
//     data['total_amount'] = this.totalAmount;
//     data['status'] = this.status;
//     data['trash'] = this.trash;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }

// class Product {
//   int? id;
//   String? categoryId;
//   String? subCategoryId;
//   String? product;
//   String? image;
//   int? price;
//   String? description;
//   int? status;
//   int? trash;
//   String? createdAt;
//   String? updatedAt;

//   Product(
//       {this.id,
//       this.categoryId,
//       this.subCategoryId,
//       this.product,
//       this.image,
//       this.price,
//       this.description,
//       this.status,
//       this.trash,
//       this.createdAt,
//       this.updatedAt});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     categoryId = json['category_id'];
//     subCategoryId = json['sub_category_id'];
//     product = json['product'];
//     image = json['image'];
//     price = json['price'];
//     description = json['description'];
//     status = json['status'];
//     trash = json['trash'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category_id'] = this.categoryId;
//     data['sub_category_id'] = this.subCategoryId;
//     data['product'] = this.product;
//     data['image'] = this.image;
//     data['price'] = this.price;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['trash'] = this.trash;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
