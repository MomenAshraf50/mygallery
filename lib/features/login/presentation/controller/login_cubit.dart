import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygallery/core/error/failures.dart';
import 'package:mygallery/features/login/domain/usecase/login_usecase.dart';
import 'package:mygallery/features/login/presentation/controller/login_states.dart';

class LogInCubit extends Cubit<LogInStates> {
  final LogInUseCase _logInUseCase;

  LogInCubit({required LogInUseCase logInUseCase})
      : _logInUseCase = logInUseCase,
        super(LogInInitialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  void logIn(LogInParams params) async{
    emit(LogInLoadingState());

    final result = await _logInUseCase(params);

    result.fold((failure){
      emit(LogInErrorState(mapFailureToMessage(failure)));
    }, (data){
      emit(LogInSuccessState(data));
    });
  }
}
