import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripusfrontend/data/models/user.dart';
import 'package:tripusfrontend/data/repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepositoryImpl userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is ResetStateEvent){
        emit(UserInitial());
      }

     if (event is UserPostRegister) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            UserModel user = await userRepository.register(
              event.name,
              event.email,
              event.password,
            );

            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          var err = e.toString().replaceAll('Exception: ', '');
          emit(UserPostError(err));
        }
     }

      if (event is UserVerifyEvent) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            await userRepository.verify(event.otpCode);

            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          var err = e.toString().replaceAll('Exception: ', '');
          emit(UserPostError(err));
        }
      }


    });
  }
}
