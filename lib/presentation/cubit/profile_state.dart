import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool loading;
  final String? error;

  const ProfileState({
    this.user,
    this.loading = false,
    this.error,
  });

  ProfileState copyWith({
    User? user,
    bool? loading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, loading, error];
}
