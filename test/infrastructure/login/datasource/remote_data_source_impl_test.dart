import 'package:challenge/infrastructure/login/datasource/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  tearDown(() {
    resetMocktailState();
  });
  late MockRemoteDataSource mockRemoteDataSource;

  const String fakeEmailTest1 = 'user@test.com';
  const String fakePasswordTest1 = '123456';
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
  });
  test('Mock login api test passed', () async {
    when(() => mockRemoteDataSource.login(fakeEmailTest1, fakePasswordTest1))
        .thenAnswer((_) => Future.value(true));
   final status =await mockRemoteDataSource.login(fakeEmailTest1, fakePasswordTest1);
    expect(true, status);
  });
}
