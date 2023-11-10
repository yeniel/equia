abstract class ApiClient {
  Future<Map<String, dynamic>> get({required String path});
  Future<void> post({required String path, required Map<String, dynamic>data, bool merge = true});
  Stream<Map<String, dynamic>> getStream({required String path});
  Stream<List<Map<String, dynamic>>> getStreamList({required String path});
  String generateId({required String path});
}