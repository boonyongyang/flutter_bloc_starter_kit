import '../core/network/api_client.dart';
import '../core/network/dio_client.dart';

class SampleRepository {
  final ApiClient _apiClient;

  SampleRepository() : _apiClient = ApiClient(DioClient().dio);

  Future<String> fetchData() async {
    try {
      return await _apiClient.getSampleData();
    } catch (e) {
      // Handle errors appropriately
      return 'Error fetching data: $e';
    }
  }
}
