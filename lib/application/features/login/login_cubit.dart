import 'package:bloc/bloc.dart';
import 'package:challenge/domain/login/login_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginCubit(this._repository) : super(const LoginState.initial());

  Future<bool> login(String email, String password) async {
    emit(const LoginState.loading());
    final status = await _repository.login(email, password);
    if (status) {
      emit(const LoginState.initial());
      return true;
    } else {
      emit(const LoginState.initial());
      return false;
    }
  }
}
