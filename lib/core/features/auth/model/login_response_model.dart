// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final String? message;
  final Data? data;

  LoginResponseModel({this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  final User? user;
  final Subscription? subscription;
  final String? token;

  Data({this.user, this.subscription, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    subscription: json["subscription"] == null
        ? null
        : Subscription.fromJson(json["subscription"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "subscription": subscription?.toJson(),
    "token": token,
  };
}

class Subscription {
  final int? id;
  final int? subscriptionUserId;
  final String? userId;
  final DateTime? effectiveTime;
  final DateTime? expiryTime;
  final DateTime? updateTime;
  final String? isOtc;
  final String? productId;
  final String? serviceId;
  final String? spId;
  final String? statusCode;
  final String? chargeMode;
  final String? chargeNumber;
  final String? referenceId;
  final Details? details;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Subscription({
    this.id,
    this.subscriptionUserId,
    this.userId,
    this.effectiveTime,
    this.expiryTime,
    this.updateTime,
    this.isOtc,
    this.productId,
    this.serviceId,
    this.spId,
    this.statusCode,
    this.chargeMode,
    this.chargeNumber,
    this.referenceId,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    subscriptionUserId: json["user_id"],
    userId: json["userId"],
    effectiveTime: json["effectiveTime"] == null
        ? null
        : DateTime.parse(json["effectiveTime"]),
    expiryTime: json["expiryTime"] == null
        ? null
        : DateTime.parse(json["expiryTime"]),
    updateTime: json["updateTime"] == null
        ? null
        : DateTime.parse(json["updateTime"]),
    isOtc: json["isOTC"],
    productId: json["productId"],
    serviceId: json["serviceId"],
    spId: json["spId"],
    statusCode: json["statusCode"],
    chargeMode: json["chargeMode"],
    chargeNumber: json["chargeNumber"],
    referenceId: json["referenceId"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": subscriptionUserId,
    "userId": userId,
    "effectiveTime": effectiveTime?.toIso8601String(),
    "expiryTime": expiryTime?.toIso8601String(),
    "updateTime": updateTime?.toIso8601String(),
    "isOTC": isOtc,
    "productId": productId,
    "serviceId": serviceId,
    "spId": spId,
    "statusCode": statusCode,
    "chargeMode": chargeMode,
    "chargeNumber": chargeNumber,
    "referenceId": referenceId,
    "details": details?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Details {
  final int? id;
  final String? code;
  final String? title;
  final int? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Details({
    this.id,
    this.code,
    this.title,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    code: json["code"],
    title: json["title"],
    amount: json["amount"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "title": title,
    "amount": amount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? jollyEmail;
  final String? country;
  final List<String>? personalizations;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.jollyEmail,
    this.country,
    this.personalizations,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    jollyEmail: json["jolly_email"],
    country: json["country"],
    personalizations: json["personalizations"] == null
        ? []
        : List<String>.from(json["personalizations"]!.map((x) => x)),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
    "jolly_email": jollyEmail,
    "country": country,
    "personalizations": personalizations == null
        ? []
        : List<dynamic>.from(personalizations!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
