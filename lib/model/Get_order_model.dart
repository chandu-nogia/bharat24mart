class GetOrder {
  bool? success;
  int? status;
  String? message;
  Data? data;

  GetOrder({this.success, this.status, this.message, this.data});

  GetOrder.fromJson(Map<String, dynamic> json) {
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
  List<ActiveOrder>? activeOrder;
  int? active;
  List<Pastorder>? pastorder;
  int? pasttotal;

  Data({this.activeOrder, this.active, this.pastorder, this.pasttotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['active_order'] != null) {
      activeOrder = <ActiveOrder>[];
      json['active_order'].forEach((v) {
        activeOrder!.add(new ActiveOrder.fromJson(v));
      });
    }
    active = json['active'];
    if (json['pastorder'] != null) {
      pastorder = <Pastorder>[];
      json['pastorder'].forEach((v) {
        pastorder!.add(new Pastorder.fromJson(v));
      });
    }
    pasttotal = json['pasttotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeOrder != null) {
      data['active_order'] = this.activeOrder!.map((v) => v.toJson()).toList();
    }
    data['active'] = this.active;
    if (this.pastorder != null) {
      data['pastorder'] = this.pastorder!.map((v) => v.toJson()).toList();
    }
    data['pasttotal'] = this.pasttotal;
    return data;
  }
}

class ActiveOrder {
  String? orderId;
  String? createdAt;
  int? id;
  int? orderStatus;
  String? amount;
  List<Items>? items;

  ActiveOrder(
      {this.orderId,
      this.createdAt,
      this.id,
      this.orderStatus,
      this.amount,
      this.items});

  ActiveOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['created_at'];
    id = json['id'];
    orderStatus = json['order_status'];
    amount = json['amount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['order_status'] = this.orderStatus;
    data['amount'] = this.amount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? productUniId;
  String? orderId;
  String? totalAmount;
  String? image;
  int? quantity;

  Items({this.name, this.orderId, this.totalAmount, this.image, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productUniId = json['product_uni_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['product_uni_id'] = this.productUniId;
    data['order_id'] = this.orderId;
    data['total_amount'] = this.totalAmount;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Pastorder {
  String? orderId;

  String? createdAt;
  int? id;
  int? orderStatus;
  String? amount;
  List<Items>? items;

  Pastorder(
      {this.orderId,
      this.createdAt,
      this.id,
      this.orderStatus,
      this.amount,
      this.items});

  Pastorder.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['created_at'];
    id = json['id'];
    orderStatus = json['order_status'];
    amount = json['amount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['order_status'] = this.orderStatus;
    data['amount'] = this.amount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Itemss {
  String? name;
  String? productUniId;
  String? orderId;
  String? totalAmount;
  String? image;
  int? quantity;

  Itemss(
      {this.name, this.orderId, this.totalAmount, this.image, this.quantity});

  Itemss.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productUniId = json['product_uni_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['product_uni_id'] = this.productUniId;
    data['order_id'] = this.orderId;
    data['total_amount'] = this.totalAmount;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    return data;
  }
}
