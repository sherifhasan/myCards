import 'package:challenge/application/app_constants.dart';
import 'package:challenge/infrastructure/login/datasource/remote_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl();
});

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == AppConstants.fakeEmail &&
        password == AppConstants.fakePassword) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
