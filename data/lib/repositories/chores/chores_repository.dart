import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ChoresRepository {
  const ChoresRepository({required this.client, required this.authService});

  final ApiClient client;
  final AuthService authService;

  static const basePath = 'chores';

  String get _uid {
    return authService.currentProfile.uid;
  }

  Future<Chore> createChore({required Chore chore}) async {
    switch (chore) {
      case WeeklyChore weeklyChore:
        return createWeeklyChore(weeklyChore: weeklyChore);
      default:
        return createWeeklyChore(weeklyChore: chore);
    }
  }

  Future<Chore> createWeeklyChore({required Chore weeklyChore}) async {
    var newChoreJson = ChoreResponse.fromModel(weeklyChore).toJson();

    newChoreJson['createdAt'] = DateTime.now().toUtc().toIso8601String();

    var createdChoreJson = await client.post(
      path: basePath,
      data: newChoreJson,
    );

    return ChoreResponse.fromJson(createdChoreJson).toModel();
  }

  Stream<List<Chore>?> getUserChores() {
    return client.getStreamList(path: '$basePath/$_uid').map((data) {
      if (data == null) {
        return null;
      }

      return data.map((choreResponse) {
        return ChoreResponse.fromJson(choreResponse).toModel();
      }).toList();
    });
  }
}
