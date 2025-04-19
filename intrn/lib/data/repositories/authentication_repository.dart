import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intrn/pages/main_page/main_page.dart';
import 'package:intrn/pages/onboarding_page/onboarding_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final Rx<User?> _firebaseUser;

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Or get just the UID (optional convenience)
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Or get email
  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  // Called when controller is ready
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  // Handle navigation based on auth state
  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => OnboardingPage());
    } else {
      Get.offAll(() => MainPage());
    }
  }

  // Register user
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Create user
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Get current user
      final user = _auth.currentUser;

      // Save user info in Firestore
      if (user != null) {
        await _fireStore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": user.email,
        });
      }
    } on FirebaseAuthException catch (e) {
      _showFirebaseError(e);
    } catch (e) {
      Get.snackbar("Error", "An unknown error occurred.");
    }
  }

  // Login user
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Get current user
      final user = _auth.currentUser;

      // Save user info in Firestore
      if (user != null) {
        await _fireStore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "email": user.email,
        }, SetOptions(merge: true));
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e));
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Helper: handle Firebase error messages
  void _showFirebaseError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'email-already-in-use':
        message = 'Email already in use.';
        break;
      case 'weak-password':
        message = 'Password is too weak.';
        break;
      case 'invalid-email':
        message = 'Invalid email address.';
        break;
      default:
        message = e.message ?? 'Something went wrong.';
    }

    

    Get.snackbar("Authentication Error", message,
        snackPosition: SnackPosition.BOTTOM);
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Password Reset", "Password reset link sent to $email",
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      _showFirebaseError(e);
    }
  }

  // Verify OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      // You can implement your actual verification logic here,
      // for example, checking the OTP code from Firestore or a secure server

      // Placeholder for actual logic — you should replace this
      final storedOtp = await _getOtpFromServerOrDatabase(email); // Implement this
      return storedOtp == otp;
    } catch (e) {
      Get.snackbar("Error", "OTP verification failed",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  // Example placeholder function
  Future<String> _getOtpFromServerOrDatabase(String email) async {
    // Simulate a backend/database call — replace this with real logic
    return "123456"; // <-- Replace with actual retrieval logic
  }
  
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;

    if (user != null) {
      await user.updatePassword(newPassword);
      await user.reload();
    } else {
      throw FirebaseAuthException(code: "user-not-found", message: "User not logged in.");
    }
  }

}