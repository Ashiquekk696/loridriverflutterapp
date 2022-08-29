class OrdersModel {
  bool? error;
  String? msg;
  List<BookingsModel>? bookings;

  OrdersModel({this.error, this.msg, this.bookings});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['bookings'] != null) {
      bookings = <BookingsModel>[];
      json['bookings'].forEach((v) {
        bookings!.add(new BookingsModel.fromJson(v));
      });
    }
  }
}

class BookingsModel {
  int? id;
  int? userId;
  int? typeId;
  int? pickupTimeId;
  int? deliveryTimeId;
  int? vehicleTypeId;
  int? packageTypeId;
  String? instructions;
  int? partnerId;
  int? deliveryDriverId;
  int? pickupDriverId;
  int? pickupCityId;
  int? deliveryCityId;
  int? statusId;
  String? pickupDate;
  String? deliveryDate;
  String? packageName;
  String? amount;
  String? actualAmount;
  int? lowestBid;
  int? active;
  Null? billingId;
  int? payType;
  int? cancelReview;
  String? statusCode;
  Null? response;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? paymentStatus;
  int? bookingStatus;
  String? pickupTime;
  String? deliveryTime;
  String? deliveryEmail;
  String? deliveryPhone;
  String? deliveryAddressType;
  String? deliveryAddressStreet;
  String? deliveryAddressNo;
  String? deliveryAddressBuilding;
  String? deliveryAddressFloor;
  String? deliveryAddressName;
  String? deliveryName;
  String? deliveryLatitude;
  String? deliveryLongitude;
  String? deliveryAddress;
  String? pickupEmail;
  String? pickupPhone;
  String? status;

  String? pickupAddressType;
  String? pickupAddressNo;
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
  String? pickUpAddressBuilding;
  String? pickUpAddressFloor;
  String? pickUpAddressName;
  String? pickUpName;
  String? pickupAddressStreet;
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
  String? orderPrice;
  List<PickedAttachmentsModel>? pickedAttachmentsModel = [];

  BookingsModel(
      {this.id,
      this.userId,
      this.typeId,
      this.pickupTimeId,
      this.deliveryTimeId,
      this.vehicleTypeId,
      this.packageTypeId,
      this.instructions,
      this.partnerId,
      this.deliveryDriverId,
      this.pickupDriverId,
      this.pickupCityId,
      this.deliveryCityId,
      this.statusId,
      this.pickupDate,
      this.deliveryDate,
      this.packageName,
      this.amount,
      this.actualAmount,
      this.deliveryAddressBuilding,
      this.deliveryAddressFloor,
      this.deliveryAddressName,
      this.lowestBid,
      this.active,
      this.billingId,
      this.paymentStatus,
      this.bookingStatus,
      this.pickupTime,
      this.deliveryTime,
      this.deliveryEmail,
      this.deliveryPhone,
      this.deliveryAddressType,
      this.deliveryAddressStreet,
      this.deliveryAddressNo,
      this.deliveryLatitude,
      this.deliveryLongitude,
      this.deliveryAddress,
      this.pickupEmail,
      this.pickupPhone,
      this.status,
      this.pickupAddressType,
      this.pickupAddressNo,
      this.pickupLatitude,
      this.pickupAddressStreet,
      this.pickupLongitude,
      this.pickUpAddressBuilding,
      this.pickUpAddressFloor,
      this.deliveryName,
      this.pickUpName,
      this.pickUpAddressName,
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
      this.pickedAttachmentsModel,
      this.orderPrice});

  BookingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeId = json['type_id'];
    pickupTimeId = json['pickup_time_id'];
    deliveryTimeId = json['delivery_time_id'];
    vehicleTypeId = json['vehicle_type_id'];
    packageTypeId = json['package_type_id'];
    instructions = json['instructions'];
    partnerId = json['partner_id'];
    deliveryDriverId = json['delivery_driver_id'];
    pickupDriverId = json['pickup_driver_id'];
    pickupCityId = json['pickup_city_id'];
    deliveryCityId = json['delivery_city_id'];
    statusId = json['status_id'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    packageName = json['package_name'];
    amount = json['amount'];
    actualAmount = json['actual_amount'];
    lowestBid = json['lowest_bid'];
    active = json['active'];
    billingId = json['billing_id'];
    deliveryAddressStreet = json['delivery_address_street'];
    payType = json['pay_type'];
    cancelReview = json['cancel_review'];
    pickupAddressStreet = json['pickup_address_street'];
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
    deliveryAddressType = json['delivery_address_type'];
    deliveryAddressNo = json['delivery_address_no'];
    deliveryAddressBuilding = json["delivery_address_building"];
    deliveryAddressFloor = json["delivery_address_floor"];
    deliveryAddressName = json["delivery_address_name"];
    //deliveryName = json["delivery_name"];

    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    deliveryAddress = json['delivery_address'];
    pickupEmail = json['pickup_email'];
    pickupPhone = json['pickup_phone'];
    status = json['status'];
    pickupAddressType = json['pickup_address_type'];
    pickupAddressNo = json['pickup_address_no'];
    pickupLatitude = json['pickup_latitude'];
    pickupLongitude = json['pickup_longitude'];
    pickupAddress = json['pickup_address'];
    pickupAddressStreet = json["pickup_address_street"];
    pickUpAddressFloor = json["pickup_address_floor"];
    pickUpAddressBuilding = json['pickup_address_building'];
    pickUpAddressName = json['pickup_address_name'];
    pickUpName = json["pickup_name"];
    deliveryName = json["delivery_name"];
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
    if (json['pickupattachments'] != null) {
      json['pickupattachments'].forEach((element) {
        pickedAttachmentsModel?.add(PickedAttachmentsModel.fromJson(element));
      });
      orderPrice = json['order_price'];
    }
  }
}

class PickedAttachmentsModel {
  var pickedAttachment;
  PickedAttachmentsModel(this.pickedAttachment);

  PickedAttachmentsModel.fromJson(json) {
    pickedAttachment = json['pickupattachment'];
  }
}
