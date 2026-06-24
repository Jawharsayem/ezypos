class CustomerModel {
  String customerName;
  String phoneNumber;
  String type;
  String profilePicture;
  String? emailAddress;
  String? customerAddress;
  String dueAmount;

  CustomerModel({
    required this.customerName,
    required this.phoneNumber,
    required this.type,
    required this.profilePicture,
    this.emailAddress,
    this.customerAddress,
    this.dueAmount = '0', // Default value for due amount
  });

  factory CustomerModel.fromJson(Map<dynamic, dynamic> json) {
    return CustomerModel(
      customerName: json['customerName']?.toString() ?? '', // Handle null and conversion
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Retailer', // Default type
      profilePicture: json['profilePicture']?.toString() ?? '', // Empty if no picture
      emailAddress: json['emailAddress']?.toString(),
      customerAddress: json['customerAddress']?.toString(),
      dueAmount: json['due']?.toString() ?? '0', // Default to '0' if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'type': type,
      'profilePicture': profilePicture,
      'emailAddress': emailAddress,
      'customerAddress': customerAddress,
      'due': dueAmount,
    };
  }
}
