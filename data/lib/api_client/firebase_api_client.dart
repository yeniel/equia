import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class FirebaseApiClient implements ApiClient {
  FirebaseApiClient() {
    client = FirebaseFirestore.instance;
  }

  late FirebaseFirestore client;

  @override
  Future<Map<String, dynamic>> get({required String path}) async {
    final docRef = client.doc(path);
    const source = Source.cache;

    return docRef.get(const GetOptions(source: source)).then((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }, onError: (error) {
      throw NetworkException();
    });
  }

  @override
  Stream<Map<String, dynamic>> getStream({required String path}) {
    final docRef = client.doc(path);

    return docRef.snapshots().map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    });
  }

  @override
  Stream<List<Map<String, dynamic>>> getStreamList({required String path}) {
    final collectionRef = client.collection(path);

    return collectionRef.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((DocumentSnapshot document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
    });
  }

  @override
  Future<Map<String, dynamic>> post(
      {required String path, required Map<String, dynamic> data, bool merge = true}) async {
    var collectionRef = client.collection(path);
    DocumentReference docRef;

    if (data.keys.contains('id') && data['id'].isEmpty) {
      docRef = collectionRef.doc();
      data['id'] = docRef.id;
    } else {
      docRef = collectionRef.doc(data['id']);
    }

    docRef.set(data, SetOptions(merge: merge)).onError((error, stackTrace) => throw NetworkException());

    return data;
  }

  @override
  Future<Map<String, dynamic>> put(
      {required String path, required Map<String, dynamic> data, bool merge = true}) async {
    var docRef = client.doc(path);

    docRef.set(data, SetOptions(merge: merge)).onError((error, stackTrace) => throw NetworkException());

    return data;
  }

  @override
  Future<Map<String, dynamic>> patch({required String path, required Map<String, dynamic> data}) async {
    var docRef = client.doc(path);

    docRef.update(data).onError((error, stackTrace) => throw NetworkException());

    return data;
  }

  @override
  Future<Map<String, dynamic>> patchArray({
    required String path,
    required String fieldName,
    required List<dynamic> values,
  }) async {
    var docRef = client.doc(path);

    docRef.update({fieldName: FieldValue.arrayUnion(values)}).onError((error, stackTrace) => throw NetworkException());

    return {fieldName: values};
  }

  @override
  String generateId({required String path}) {
    return client.collection(path).doc().id;
  }
}
