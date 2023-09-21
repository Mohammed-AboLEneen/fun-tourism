class SignupEmailPassFailure {
  final String message;

  const SignupEmailPassFailure(this.message);

  factory SignupEmailPassFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignupEmailPassFailure('Plesae enter a strong password');
      case 'wrong-password':
        return const SignupEmailPassFailure('Plesae enter a strong password');
      case 'invalid-email':
        return const SignupEmailPassFailure(
            'Email in not valid or badly formatted');
      case 'email-already-in-use':
        return const SignupEmailPassFailure(
            'An account already exists with the same email');
      case 'operation-not-allowed':
        return const SignupEmailPassFailure(
            'Operation is not allowed, please contact support');
      case 'user-not-found':
        return const SignupEmailPassFailure(
            'This user has been deleted, create new account');
      case 'user-disabled':
        return const SignupEmailPassFailure(
            'This User has been disabled, please contact support for help');
      default:
        return const SignupEmailPassFailure('An unknown error has occurred. ');
    }
  }
}
