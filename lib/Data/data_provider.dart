import 'package:crud_app/Data/responsitory.dart';
import 'package:crud_app/Domain/task_model.dart';
import 'package:riverpod/riverpod.dart';

final getProvider = FutureProvider<List<Task>>((ref) async {
  return ref.watch(getTaskProvider).getTask();
});
