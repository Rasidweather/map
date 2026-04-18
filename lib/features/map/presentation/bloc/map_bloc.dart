import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  @override
  MapState get initialState => Temperature();
  MapBloc() : super(Temperature()) {
    on<MapEvent>((event, emit) {});
    on<GetTempAndPrepForMap>((event, emit) {
      if (event.mapType == "PR0") {
        emit(Temperature());
      }
      // else if (event.mapType == 'precipitation_new') {
      //   emit(Precipitation());
      // } else if (event.mapType == 'wind_new'){
      //   emit(Windnew());
      // } else if (event.mapType == 'pressure_new'){
      //   emit(Pressurenew());
      // }else {
      //   emit(Cloudsnew());
      // }
    });
  }
}
