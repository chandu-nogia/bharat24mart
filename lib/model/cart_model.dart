// ignore_for_file: unnecessary_this, prefer_typing_uninitialized_variables, unnecessary_new, prefer_collection_literals

class GetCartModel {
  bool? success;
  int? status;
  String? message;
  GetCartModelData? data;

  GetCartModel({this.success, this.status, this.message, this.data});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? GetCartModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetCartModelData {
  List<Cart>? cart;
  var totalDiscountCartAmount;
  var totalCartAmount;
  List<Product>? product;

  GetCartModelData(
      {this.cart,
      this.totalDiscountCartAmount,
      this.totalCartAmount,
      this.product});

  GetCartModelData.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    totalDiscountCartAmount = json['total_discount_cart_amount'];
    totalCartAmount = json['total_cart_amount'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['total_discount_cart_amount'] = this.totalDiscountCartAmount;
    data['total_cart_amount'] = this.totalCartAmount;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  String? userUniId;
  String? productSellerId;
  String? productUniId;
  String? productName;
  String? productAmount;
  String? totalAmount;
  String? totalDiscount;
  int? productQuantity;
  int? trash;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Cart(
      {this.id,
      this.userUniId,
      this.productSellerId,
      this.productUniId,
      this.productName,
      this.productAmount,
      this.totalAmount,
      this.totalDiscount,
      this.productQuantity,
      this.trash,
      this.createdAt,
      this.updatedAt,
      this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    productSellerId = json['product_seller_id'];
    productUniId = json['product_uni_id'];
    productName = json['product_name'];
    productAmount = json['product_amount'];
    totalAmount = json['total_amount'];
    totalDiscount = json['total_discount'];
    productQuantity = json['product_quantity'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_uni_id'] = this.userUniId;
    data['product_seller_id'] = this.productSellerId;
    data['product_uni_id'] = this.productUniId;
    data['product_name'] = this.productName;
    data['product_amount'] = this.productAmount;
    data['total_amount'] = this.totalAmount;
    data['total_discount'] = this.totalDiscount;
    data['product_quantity'] = this.productQuantity;
    data['trash'] = this.trash;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
