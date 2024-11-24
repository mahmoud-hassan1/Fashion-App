import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';
import 'package:online_shopping/Features/auth/domain/repositories/auth_repo.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override   
  Future<UserClass?> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     if(!firebaseAuth.currentUser!.emailVerified){
   throw Exception("Verify your email");
   }
   else{
    final user = userCredential.user;
    if (user != null) {
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
   }
  }
  Future<void> sendVerficationLink () async{
   await firebaseAuth.currentUser?.sendEmailVerification();
  }
  @override
  Future<UserClass?> signup(String name,String email, String password) async {
   final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await sendVerficationLink();
    final user = userCredential.user;
    if (user != null) {
       user.updateDisplayName(name);
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
  }
  
  @override
  Future<UserClass?> loginWithGoogle() async{
    final googleUser= await GoogleSignIn().signIn();
    final googleAuth=await googleUser!.authentication;
    final credential= GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );
   final userCredential= await firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;
    
    if (user != null) {
       user.updateDisplayName(googleUser.displayName);
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
   
  }
  
  @override
void logout() {
    final user = firebaseAuth.currentUser;
    if ( user!.providerData.any((provider) => provider.providerId == 'google.com')) {
        GoogleSignIn().signOut();
    }
  firebaseAuth.signOut();
  }
  
  @override
  Future<void> sendPasswordResetLink(String email) async{
   await firebaseAuth.sendPasswordResetEmail(email: email);

  }
}