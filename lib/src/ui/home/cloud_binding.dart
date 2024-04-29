import 'package:flutter_application_1/src/ui/home/clound_controller.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';

class CloudBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => CloudController());
  }
}