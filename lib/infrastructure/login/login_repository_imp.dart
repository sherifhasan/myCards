import 'package:challenge/domain/login/login_repository.dart';
import 'package:challenge/infrastructure/login/datasource/remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepository {
  final RemoteDataSource _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }
}
