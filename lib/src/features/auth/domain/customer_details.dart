class CustomerDetails {
  final String customerNumber;


  CustomerDetails(
      {required this.customerNumber,});

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
        customerNumber: json['customer_name'],);

  }
}
class VerifyProfileDetails {
  final CustomerDetails customerDetails;


  VerifyProfileDetails(
      {required this.customerDetails,});

  factory VerifyProfileDetails.fromJson(Map<String, dynamic> json) {
    return VerifyProfileDetails(
        customerDetails: CustomerDetails.fromJson(json['customer_details']));

  }
}
