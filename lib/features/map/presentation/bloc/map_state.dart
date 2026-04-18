part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class Temperature extends MapState {}

class Precipitation extends MapState {}

class Windnew extends MapState {}
class Cloudsnew extends MapState {}
class Pressurenew extends MapState {}
