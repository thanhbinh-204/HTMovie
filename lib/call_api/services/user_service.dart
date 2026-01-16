import '../models/user_model.dart';
import '../api/api_client.dart';

class UserService {
  static final ApiClient _apiClient = ApiClient();

  static Future<UserModel> getProfile() async {
    final response = await _apiClient.get('/auth/me', requireAuth: true);

    if (response['data'] != null && response['data']['user'] != null) {
      return UserModel.fromJson(response['data']['user']);
    }

    throw Exception('User data not found');
  }
}
