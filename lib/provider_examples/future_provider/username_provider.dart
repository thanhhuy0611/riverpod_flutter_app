import 'package:flutter_app_riverpod/provider_examples/future_provider/user_data_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create userDataRepositoryProvider to apply singleton patern
final userDataRepositoryProvider = Provider((ref) => UserDataRepository());

final usernameProvider = FutureProvider.autoDispose<String>((ref) async {
  final repository = ref.read(userDataRepositoryProvider);
  
  return await repository.getUsername();
});