import '../api/api_endpoints.dart';
import '../api/api_client.dart';
import '../models/category_model.dart';


class CategoryService {
  final ApiClient _apiClient = ApiClient();

  Future <List<CategoryModel>> getCategories() async {
    final response = await _apiClient.get(ApiEndpoints.categories);
    final List list = response['genres'];

    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }
}


