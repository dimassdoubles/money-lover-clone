abstract class AuthEvent {}

class Register extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  Register({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
