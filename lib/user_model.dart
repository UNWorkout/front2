class UserModel {
  final String name;
  final String lastName;
  final String birthDate;
  final String gender;
  final String cellPhone;
  final String email;
  final String passwordHash;

  UserModel(
      {required this.name,
      required this.lastName,
      required this.birthDate,
      required this.gender,
      required this.cellPhone,
      required this.email,
      required this.passwordHash});

  static UserModel fromMap({required Map map}) => UserModel(
        name: map['name'],
        lastName: map['lastName'],
        birthDate: map['birthDate'],
        gender: map['gender'],
        cellPhone: map['cellPhone'],
        email: map['email'],
        passwordHash: map['passwordHash'],
      );
}
