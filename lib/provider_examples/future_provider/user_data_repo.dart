class UserDataRepository {

  Future<String> getUsername() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Your name';
  }
}