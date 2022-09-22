import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Connexion ave google

  Future<UserCredential> signInWithGoogle() async {
    //Déclencher le flux d'authentification
    final googleUser = await _googleSignIn.signIn();

    //obtenir les détails d'autorisation de la démande
    final googleAuth = await googleUser!.authentication;

    //Creer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //Une fois connecter renvoyé l'id de l'utilisateur.
    return await _auth.signInWithCredential(credential);
  }

  //L'état de l'utilisateur en temp réel
  Stream<User?> get user => _auth.authStateChanges();

  //Déconnexion
  Future<void> signOut()async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
