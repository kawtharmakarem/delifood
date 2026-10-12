// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  CustomerResponse(this.id, this.name);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse customer;
  @JsonKey(name: "contacts")
  ContactsResponse contacts;
  AuthenticationResponse(this.customer, this.contacts);
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotpasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgotpasswordResponse(this.support);
  factory ForgotpasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotpasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotpasswordResponseToJson(this);
}

@JsonSerializable()
class RecipeResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "ingredients")
  List<String>? ingredients;

  @JsonKey(name: "instructions")
  List<String>? instructions;

  @JsonKey(name: "prepTimeMinutes")
  int? prepTimeMinutes;

  @JsonKey(name: "cookTimeMinutes")
  int? cookTimeMinutes;

  @JsonKey(name: "servings")
  int? servings;

  @JsonKey(name: "difficulty")
  String? difficulty;

  @JsonKey(name: "cuisine")
  String? cuisine;

  @JsonKey(name: "caloriesPerServing")
  int? caloriesPerServing;

  @JsonKey(name: "tags")
  List<String>? tags;

  @JsonKey(name: "userId")
  int? userId;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "rating")
  double? rating;

  @JsonKey(name: "reviewCount")
  int? reviewCount;

  @JsonKey(name: "mealType")
  List<String>? mealType;
  RecipeResponse({
    this.id,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
  });
  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}

@JsonSerializable()
class HomeRecipesResponse extends BaseResponse {
  @JsonKey(name: "recipes")
  List<RecipeResponse>? recipes;
  HomeRecipesResponse(this.recipes);
  factory HomeRecipesResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeRecipesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeRecipesResponseToJson(this);
}
