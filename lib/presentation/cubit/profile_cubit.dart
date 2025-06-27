import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/user/get_user_profile.dart';
import '../../domain/usecases/user/update_user_profile_image.dart';
import 'profile_state.dart';
import 'dart:io';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile getUserProfile;
  final UpdateUserProfileImage updateUserProfileImage;

  ProfileCubit(this.getUserProfile, this.updateUserProfileImage)
      : super(const ProfileState());

  Future<void> fetchUserProfile() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final user = await getUserProfile();
      emit(state.copyWith(user: user, loading: false, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }

  Future<void> uploadProfileImage(File image) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final user = await updateUserProfileImage(image);
      emit(state.copyWith(user: user, loading: false, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }
}
