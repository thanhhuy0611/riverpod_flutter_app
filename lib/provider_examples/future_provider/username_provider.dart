import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_app_riverpod/repository/user_data_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create userDataRepositoryProvider to apply singleton patern
final userDataRepositoryProvider = Provider((ref) => UserDataRepository());

final usernameProvider = FutureProvider.family.autoDispose<Either<String, HttpException>, UserDataRepository>((ref, userRepo) async {
  return await userRepo.getUsername();
});