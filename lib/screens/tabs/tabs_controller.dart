
import 'package:get/get.dart';
import '../../base/controller/base_controller.dart';

class TabsController extends BaseController {
  // final ChatAPI _chatAPI = ChatAPI();

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changeTab(int index){
    if(_currentIndex.value != index){
      _currentIndex.value = index;
    }
  }

}
