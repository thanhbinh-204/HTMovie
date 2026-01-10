import '../models/user_model.dart';
import '../api/api_client.dart';

class UserService {
  static final ApiClient _apiClient = ApiClient();

  static Future<UserModel> getProfile() async {
    final data = await _apiClient.get(
      '/auth/me',
      requireAuth: true,
    );

    if (data['user'] != null) {
      return UserModel.fromJson(data['user']);
    }

    throw Exception('User data not found');
  }
}
