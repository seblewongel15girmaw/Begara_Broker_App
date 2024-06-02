abstract class LocationEvent{}
class SearchEvent extends LocationEvent{
  String query;
  SearchEvent({required this.query});
}

class ClearSearch extends LocationEvent{}