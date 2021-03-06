class ApiEndpoints {
  static const String _baseUrl =
      'https://us-central1-jolobbi-staging.cloudfunctions.net';

  static const String createWalletPin = _baseUrl + '/createUserWalletPin';
  static const String updateWalletPin = _baseUrl + '/updateUserWalletPin';

  static const String verifyTrans = _baseUrl + '/verifyPayment';
  static const String transferToVendor = _baseUrl + '/transferToBusinessByTag';
}
