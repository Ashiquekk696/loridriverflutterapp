// import 'dart:convert';

// import 'package:loridriverflutterapp/models/orders_model.dart';

// class NotificationsModel {
//   List<OrdersModel> pastData = [];
//   List<OrdersModel> upcomingData = [];

//   NotificationsModel.fromJson(json) {
//     if (json['past'] != null) {
//       json['past'].forEach((element) {
//         print(json['past']);
//         pastData.add(OrdersModel.fromJson(element));
//       });
//     }

//     if (json['upcoming'] != null) {
//       json['upcoming'].forEach((element) {
//         upcomingData.add(OrdersModel.fromJson(element));
//       });
//     }
//   }
// }
import 'package:loridriverflutterapp/models/orders_model.dart';

class NotificationsModel {
  bool? error;
  String? msg;
  List<NotificationsDataModel>? upcoming;
  List<NotificationsDataModel>? past;
  //List<Bookings>? bookings;

  NotificationsModel({
    this.error,
    this.msg,
    this.upcoming,
    this.past,
  });

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['upcoming'] != null) {
      upcoming = <NotificationsDataModel>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(new NotificationsDataModel.fromJson(v));
      });
    }
    if (json['past'] != null) {
      past = <NotificationsDataModel>[];
      json['past'].forEach((v) {
        past!.add(new NotificationsDataModel.fromJson(v));
      });
    }
    // if (json['bookings'] != null) {
    //   bookings = <Bookings>[];
    //   json['bookings'].forEach((v) {
    //     bookings!.add(new Bookings.fromJson(v));
    //   });
    // }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['error'] = this.error;
  //   data['msg'] = this.msg;
  //   if (this.upcoming != null) {
  //     data['upcoming'] = this.upcoming!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.past != null) {
  //     data['past'] = this.past!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.bookings != null) {
  //     data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class NotificationsDataModel {
  int? id;
  int? userId;
  int? typeId;
  int? pickupTimeId;
  int? pickupDriverId;
  int? deliveryDriverId;
  int? deliveryTimeId;
  int? vehicleTypeId;
  int? pickupCityId;
  int? deliveryCityId;
  int? packageTypeId;
  int? statusId;
  int? partnerId;
  String? instructions;
  String? pickupDate;
  String? deliveryDate;
  String? packageName;
  int? payType;
  dynamic amount;
  int? lowestBid;
  dynamic actualAmount;
  int? cancelReview;
  String? orderPrice;
  int? active;
  String? billingId;
  String? statusCode;
  String? response;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? paymentStatus;
  int? bookingStatus;
  String? pickupTime;
  String? deliveryTime;
  String? deliveryEmail;
  String? deliveryPhone;
  String? deliveryName;
  String? pickupName;
  String? deliveryAddressType;
  String? deliveryAddressNo;
  String? deliveryAddressStreet;
  String? deliveryAddressBuilding;
  String? deliveryAddressFloor;
  String? deliveryAddressName;
  String? deliveryLatitude;
  String? deliveryLongitude;
  String? deliveryAddress;
  String? pickupEmail;
  String? pickupPhone;
  String? status;
  String? pickupAddressType;
  String? pickupAddressNo;
  String? pickupAddressStreet;
  String? pickupAddressBuilding;
  String? pickupAddressFloor;
  String? pickupAddressName;
  String? pickupLatitude;
  String? pickupLongitude;
  String? pickupAddress;
  String? packageImage;
  String? vehicleImage;
  String? vehicleCategory;
  String? packageCategory;
  String? weight;
  String? dimension;
  String? pickupCity;
  String? deliveryCity;
  bool? pickup;
  bool? delivery;
  int? userTypeId;
  String? userType;
  String? userPickupTime;
  String? userDeliveryTime;
  String? vehicleThumbnail;
  String? packageThumbnail;
  String? bookingType;
  List<Bookingattachments>? bookingattachments;
  List<Pickupattachments>? pickupattachments;
  List<Null>? deliveryattachments;

  NotificationsDataModel(
      {this.id,
      this.userId,
      this.typeId,
      this.pickupTimeId,
      this.pickupDriverId,
      this.deliveryDriverId,
      this.deliveryTimeId,
      this.vehicleTypeId,
      this.pickupCityId,
      this.deliveryCityId,
      this.packageTypeId,
      this.statusId,
      this.partnerId,
      this.instructions,
      this.pickupDate,
      this.deliveryDate,
      this.packageName,
      this.payType,
      this.amount,
      this.lowestBid,
      this.actualAmount,
      this.cancelReview,
      this.orderPrice,
      this.active,
      this.billingId,
      this.statusCode,
      this.response,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.paymentStatus,
      this.bookingStatus,
      this.pickupTime,
      this.deliveryTime,
      this.deliveryEmail,
      this.deliveryPhone,
      this.deliveryName,
      this.pickupName,
      this.deliveryAddressType,
      this.deliveryAddressNo,
      this.deliveryAddressStreet,
      this.deliveryAddressBuilding,
      this.deliveryAddressFloor,
      this.deliveryAddressName,
      this.deliveryLatitude,
      this.deliveryLongitude,
      this.deliveryAddress,
      this.pickupEmail,
      this.pickupPhone,
      this.status,
      this.pickupAddressType,
      this.pickupAddressNo,
      this.pickupAddressStreet,
      this.pickupAddressBuilding,
      this.pickupAddressFloor,
      this.pickupAddressName,
      this.pickupLatitude,
      this.pickupLongitude,
      this.pickupAddress,
      this.packageImage,
      this.vehicleImage,
      this.vehicleCategory,
      this.packageCategory,
      this.weight,
      this.dimension,
      this.pickupCity,
      this.deliveryCity,
      this.pickup,
      this.delivery,
      this.userTypeId,
      this.userType,
      this.userPickupTime,
      this.userDeliveryTime,
      this.vehicleThumbnail,
      this.packageThumbnail,
      this.bookingType,
      this.bookingattachments,
      this.pickupattachments,
      this.deliveryattachments});

  NotificationsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeId = json['type_id'];
    pickupTimeId = json['pickup_time_id'];
    pickupDriverId = json['pickup_driver_id'];
    deliveryDriverId = json['delivery_driver_id'];
    deliveryTimeId = json['delivery_time_id'];
    vehicleTypeId = json['vehicle_type_id'];
    pickupCityId = json['pickup_city_id'];
    deliveryCityId = json['delivery_city_id'];
    packageTypeId = json['package_type_id'];
    statusId = json['status_id'];
    partnerId = json['partner_id'];
    instructions = json['instructions'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    packageName = json['package_name'];
    payType = json['pay_type'];
    amount = json['amount'];
    lowestBid = json['lowest_bid'];
    actualAmount = json['actual_amount'];
    cancelReview = json['cancel_review'];
    orderPrice = json['order_price'];
    active = json['active'];
    billingId = json['billing_id'];
    statusCode = json['status_code'];
    response = json['response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    paymentStatus = json['payment_status'];
    bookingStatus = json['booking_status'];
    pickupTime = json['pickup_time'];
    deliveryTime = json['delivery_time'];
    deliveryEmail = json['delivery_email'];
    deliveryPhone = json['delivery_phone'];
    deliveryName = json['delivery_name'];
    pickupName = json['pickup_name'];
    deliveryAddressType = json['delivery_address_type'];
    deliveryAddressNo = json['delivery_address_no'];
    deliveryAddressStreet = json['delivery_address_street'];
    deliveryAddressBuilding = json['delivery_address_building'];
    deliveryAddressFloor = json['delivery_address_floor'];
    deliveryAddressName = json['delivery_address_name'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    deliveryAddress = json['delivery_address'];
    pickupEmail = json['pickup_email'];
    pickupPhone = json['pickup_phone'];
    status = json['status'];
    pickupAddressType = json['pickup_address_type'];
    pickupAddressNo = json['pickup_address_no'];
    pickupAddressStreet = json['pickup_address_street'];
    pickupAddressBuilding = json['pickup_address_building'];
    pickupAddressFloor = json['pickup_address_floor'];
    pickupAddressName = json['pickup_address_name'];
    pickupLatitude = json['pickup_latitude'];
    pickupLongitude = json['pickup_longitude'];
    pickupAddress = json['pickup_address'];
    packageImage = json['package_image'];
    vehicleImage = json['vehicle_image'];
    vehicleCategory = json['vehicle_category'];
    packageCategory = json['package_category'];
    weight = json['weight'];
    dimension = json['dimension'];
    pickupCity = json['pickup_city'];
    deliveryCity = json['delivery_city'];
    pickup = json['pickup'];
    delivery = json['delivery'];
    userTypeId = json['user_type_id'];
    userType = json['user_type'];
    userPickupTime = json['user_pickup_time'];
    userDeliveryTime = json['user_delivery_time'];
    vehicleThumbnail = json['vehicle_thumbnail'];
    packageThumbnail = json['package_thumbnail'];
    bookingType = json['booking_type'];
    if (json['bookingattachments'] != null) {
      bookingattachments = <Bookingattachments>[];
      json['bookingattachments'].forEach((v) {
        bookingattachments!.add(new Bookingattachments.fromJson(v));
      });
    }
    if (json['pickupattachments'] != null) {
      pickupattachments = <Pickupattachments>[];
      json['pickupattachments'].forEach((v) {
        pickupattachments!.add(new Pickupattachments.fromJson(v));
      });
    }
    // if (json['deliveryattachments'] != null) {
    //   deliveryattachments = <Null>[];
    //   json['deliveryattachments'].forEach((v) {
    //     deliveryattachments!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type_id'] = this.typeId;
    data['pickup_time_id'] = this.pickupTimeId;
    data['pickup_driver_id'] = this.pickupDriverId;
    data['delivery_driver_id'] = this.deliveryDriverId;
    data['delivery_time_id'] = this.deliveryTimeId;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['pickup_city_id'] = this.pickupCityId;
    data['delivery_city_id'] = this.deliveryCityId;
    data['package_type_id'] = this.packageTypeId;
    data['status_id'] = this.statusId;
    data['partner_id'] = this.partnerId;
    data['instructions'] = this.instructions;
    data['pickup_date'] = this.pickupDate;
    data['delivery_date'] = this.deliveryDate;
    data['package_name'] = this.packageName;
    data['pay_type'] = this.payType;
    data['amount'] = this.amount;
    data['lowest_bid'] = this.lowestBid;
    data['actual_amount'] = this.actualAmount;
    data['cancel_review'] = this.cancelReview;
    data['order_price'] = this.orderPrice;
    data['active'] = this.active;
    data['billing_id'] = this.billingId;
    data['status_code'] = this.statusCode;
    data['response'] = this.response;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['payment_status'] = this.paymentStatus;
    data['booking_status'] = this.bookingStatus;
    data['pickup_time'] = this.pickupTime;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_email'] = this.deliveryEmail;
    data['delivery_phone'] = this.deliveryPhone;
    data['delivery_name'] = this.deliveryName;
    data['pickup_name'] = this.pickupName;
    data['delivery_address_type'] = this.deliveryAddressType;
    data['delivery_address_no'] = this.deliveryAddressNo;
    data['delivery_address_street'] = this.deliveryAddressStreet;
    data['delivery_address_building'] = this.deliveryAddressBuilding;
    data['delivery_address_floor'] = this.deliveryAddressFloor;
    data['delivery_address_name'] = this.deliveryAddressName;
    data['delivery_latitude'] = this.deliveryLatitude;
    data['delivery_longitude'] = this.deliveryLongitude;
    data['delivery_address'] = this.deliveryAddress;
    data['pickup_email'] = this.pickupEmail;
    data['pickup_phone'] = this.pickupPhone;
    data['status'] = this.status;
    data['pickup_address_type'] = this.pickupAddressType;
    data['pickup_address_no'] = this.pickupAddressNo;
    data['pickup_address_street'] = this.pickupAddressStreet;
    data['pickup_address_building'] = this.pickupAddressBuilding;
    data['pickup_address_floor'] = this.pickupAddressFloor;
    data['pickup_address_name'] = this.pickupAddressName;
    data['pickup_latitude'] = this.pickupLatitude;
    data['pickup_longitude'] = this.pickupLongitude;
    data['pickup_address'] = this.pickupAddress;
    data['package_image'] = this.packageImage;
    data['vehicle_image'] = this.vehicleImage;
    data['vehicle_category'] = this.vehicleCategory;
    data['package_category'] = this.packageCategory;
    data['weight'] = this.weight;
    data['dimension'] = this.dimension;
    data['pickup_city'] = this.pickupCity;
    data['delivery_city'] = this.deliveryCity;
    data['pickup'] = this.pickup;
    data['delivery'] = this.delivery;
    data['user_type_id'] = this.userTypeId;
    data['user_type'] = this.userType;
    data['user_pickup_time'] = this.userPickupTime;
    data['user_delivery_time'] = this.userDeliveryTime;
    data['vehicle_thumbnail'] = this.vehicleThumbnail;
    data['package_thumbnail'] = this.packageThumbnail;
    data['booking_type'] = this.bookingType;
    if (this.bookingattachments != null) {
      data['bookingattachments'] =
          this.bookingattachments!.map((v) => v.toJson()).toList();
    }
    if (this.pickupattachments != null) {
      data['pickupattachments'] =
          this.pickupattachments!.map((v) => v.toJson()).toList();
    }
    // if (this.deliveryattachments != null) {
    //   data['deliveryattachments'] =
    //       this.deliveryattachments!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Bookingattachments {
  String? attachmentfile;

  Bookingattachments({this.attachmentfile});

  Bookingattachments.fromJson(Map<String, dynamic> json) {
    attachmentfile = json['attachmentfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachmentfile'] = this.attachmentfile;
    return data;
  }
}

class Pickupattachments {
  String? pickupattachment;

  Pickupattachments({this.pickupattachment});

  Pickupattachments.fromJson(Map<String, dynamic> json) {
    pickupattachment = json['pickupattachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickupattachment'] = this.pickupattachment;
    return data;
  }
}
