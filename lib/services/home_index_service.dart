import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class HomeIndexService with ReactiveServiceMixin {
  //reactive, it is for detect if there exist a change
  RxValue<int> _index = RxValue<int>(initial: 1);

  HomeIndexService() {
    listenToReactiveValues([_index]);
  }

  int get index => _index.value;

  void setIndex(int index) {
    _index.value = index;
  }
}
