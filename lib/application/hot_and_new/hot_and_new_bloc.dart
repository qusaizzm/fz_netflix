import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:fz_netflix/domain/core/failures/main_failures.dart';
import 'package:fz_netflix/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:fz_netflix/domain/hot_and_new_resp/models/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService hotAndNewService;

  HotAndNewBloc(this.hotAndNewService) : super(HotAndNewState.initial()) {
    //get hot and new movie data
    on<LoadDataInComingSoon>((event, emit) async {
      //sent loading to ui
      emit(const HotAndNewState(
        comingSoonList: [],
        everyOneWatchingList: [],
        isLoading: true,
        hasError: false,
      ));

      // get data from remote
      final result = await hotAndNewService.getHotAndNewMovieData();

      // data to state
      final newState = result.fold(
        (MainFailures f) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: resp.results,
            everyOneWatchingList: state.everyOneWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });

    //get hot and new tv data
    on<LoadDataInEveryOneWatching>((event, emit) async {
            //sent loading to ui
      emit(const HotAndNewState(
        comingSoonList: [],
        everyOneWatchingList: [],
        isLoading: true,
        hasError: false,
      ));

      // get data from remote
      final result = await hotAndNewService.getHotAndNewTvData();

      // data to state
      final newState = result.fold(
        (MainFailures f) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyOneWatchingList: resp.results,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });
  }
}
