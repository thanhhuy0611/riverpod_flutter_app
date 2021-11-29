import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserDataRepository {

  Future<Either<String, HttpException>> getUsername() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      return const Left('Your name');
    } on HttpException catch (e) {
      return Right(e);
    }
  }
}