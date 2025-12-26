
class UserRegistrationModel {
  String fullName;
  String email;
  String phoneNumber;
  String password;
  String address;
  String? bloodGroup;
  DateTime? lastDonationDate;

  UserRegistrationModel({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.address = '',
    this.bloodGroup,
    this.lastDonationDate,
  });
}
