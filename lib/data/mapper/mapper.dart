import '/app/constants.dart';
import '/app/extensions.dart';
import '/data/response/response.dart';
import '/domain/models/auth_models.dart';
import '/domain/models/home_models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id?.orEmpty() ?? Constants.empty,
      name: this?.name?.orEmpty() ?? Constants.empty,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone?.orEmpty() ?? Constants.empty,
      email: this?.email?.orEmpty() ?? Constants.empty,
      link: this?.link?.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer.toDomain(),
      contacts: this?.contacts.toDomain(),
    );
  }
}

extension ForgotpasswordResponseMapper on ForgotpasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension RecipeResponseMapper on RecipeResponse? {
  Recipe toDomain() {
    return Recipe(
      id: this?.id?.orZero() ?? Constants.zero,
      name: this?.name?.orEmpty() ?? Constants.empty,
      ingredients: this?.ingredients ?? [],
      instructions: this?.instructions ?? [],
      prepTimeMinutes: this?.prepTimeMinutes?.orZero() ?? Constants.zero,
      cookTimeMinutes: this?.cookTimeMinutes?.orZero() ?? Constants.zero,
      servings: this?.servings?.orZero() ?? Constants.zero,
      difficulty: this?.difficulty?.orEmpty() ?? Constants.empty,
      cuisine: this?.cuisine?.orEmpty() ?? Constants.empty,
      caloriesPerServing: this?.caloriesPerServing?.orZero() ?? Constants.zero,
      tags: this?.tags ?? [],
      userId: this?.userId?.orZero() ?? Constants.zero,
      image: this?.image?.orEmpty() ?? Constants.empty,
      rating: this?.rating ?? 0.0,
      reviewCount: this?.reviewCount?.orZero() ?? Constants.zero,
      mealType: this?.mealType ?? [],
    );
  }
}

extension HomeRecipesResponseMapper on HomeRecipesResponse? {
  RecipesModel toDomain() {
    return RecipesModel(
      recipes: this?.recipes?.map((recipe) => recipe.toDomain()).toList() ?? [],
    );
  }
}
