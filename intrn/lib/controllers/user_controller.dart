import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intrn/data/repositories/user_repository.dart';
import 'package:intrn/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel(id: '', firstName: '', lastName: '', email: '', birthDate: '',phone: '', country: '', imageUrl: '',).obs;
  final _auth = FirebaseAuth.instance;
  final _repo = UserRepository();

   @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userData = await _repo.getUserById(currentUser.uid);
        user.value = userData;
      }
    } catch (e) {
      print("❌ Failed to load user: $e");
    }
  }
}