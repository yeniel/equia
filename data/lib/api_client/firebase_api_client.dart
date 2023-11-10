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

    return docRef.get(const GetOptions(source: source))
      .then((DocumentSnapshot document) {
        return document.data() as Map<String, dynamic>;
      },
      onError: (error) {
        throw NetworkException();
      }
    );
  }

  @override
  Future<void> post({required String path, required Map<String, dynamic> data, bool merge = true}) async {
    return client.doc(path).set(data, SetOptions(merge: merge))
        .onError((error, stackTrace) => throw NetworkException());
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
  String generateId({required String path}) {
    return client.collection(path).doc().id;
  }
}
