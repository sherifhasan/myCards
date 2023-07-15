import 'package:challenge/infrastructure/login/datasource/remote_data_source.dart';
import 'package:challenge/infrastructure/login/datasource/remote_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/login/login_repository.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(ref.watch(remoteDataSourceProvider));
});

class LoginRepositoryImpl extends LoginRepository {
  final RemoteDataSource _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }
}
