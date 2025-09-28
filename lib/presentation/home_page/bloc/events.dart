abstract class HomeEvent {
  const HomeEvent();
}

class HomeLoadDataEvent extends HomeEvent {
  final String? search;
  final int offset;
  const HomeLoadDataEvent({this.search, this.offset = 0});
}
