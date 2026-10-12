// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(json['id'] as String?, json['name'] as String?);

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      json['phone'] as String?,
      json['email'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'link': instance.link,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
  Map<String, dynamic> json,
) =>
    AuthenticationResponse(
        CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
        ContactsResponse.fromJson(json['contacts'] as Map<String, dynamic>),
      )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
  AuthenticationResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'customer': instance.customer,
  'contacts': instance.contacts,
};

ForgotpasswordResponse _$ForgotpasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotpasswordResponse(json['support'] as String?)
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$ForgotpasswordResponseToJson(
  ForgotpasswordResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'support': instance.support,
};

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) =>
    RecipeResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt(),
      cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt(),
      servings: (json['servings'] as num?)?.toInt(),
      difficulty: json['difficulty'] as String?,
      cuisine: json['cuisine'] as String?,
      caloriesPerServing: (json['caloriesPerServing'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userId: (json['userId'] as num?)?.toInt(),
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      mealType: (json['mealType'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'cookTimeMinutes': instance.cookTimeMinutes,
      'servings': instance.servings,
      'difficulty': instance.difficulty,
      'cuisine': instance.cuisine,
      'caloriesPerServing': instance.caloriesPerServing,
      'tags': instance.tags,
      'userId': instance.userId,
      'image': instance.image,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'mealType': instance.mealType,
    };

HomeRecipesResponse _$HomeRecipesResponseFromJson(Map<String, dynamic> json) =>
    HomeRecipesResponse(
        (json['recipes'] as List<dynamic>?)
            ?.map((e) => RecipeResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
      )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$HomeRecipesResponseToJson(
  HomeRecipesResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'recipes': instance.recipes,
};
