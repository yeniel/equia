abstract class ApiClient {
  Future<Map<String, dynamic>> get({required String path});
  Stream<Map<String, dynamic>> getStream({required String path});
  Stream<List<Map<String, dynamic>>> getStreamList({required String path});

  Future<void> post({required String path, required Map<String, dynamic>data, bool merge = true});

  Future<void> put({required String path, required Map<String, dynamic>data, bool merge = true});

  Future<void> patch({required String path, required Map<String, dynamic>data});

  Future<void> patchArray({required String path, required String fieldName, required List<dynamic> values});

  String generateId({required String path});
}