const bool usePaypal = true;
const bool usePaystack = true;
const bool usePaytm = true;
const bool useRazorpay = true;
const bool useFlutterwave = true;
const bool useStripe = true;
const bool useTap = true;
const bool useSslCommerz = true;
const bool useWebview = true;
const bool useCashOnDelivery = true;
const String defaultPaymentMethod = "Paypal";

// IMPORTANT: Do not commit real secrets. Replace these placeholders in a local-only copy.
// Paypal Settings
const String paypalClientId = 'REPLACE_WITH_PAYPAL_CLIENT_ID';
const String paypalClientSecret = 'REPLACE_WITH_PAYPAL_CLIENT_SECRET';
const bool sandbox = true;
const String paypalCurrency = 'USD';

// SSLCommerz Settings
const String storeId = 'REPLACE_WITH_SSLCOMMERZ_STORE_ID';
const String storePassword = 'REPLACE_WITH_SSLCOMMERZ_STORE_PASSWORD';
const bool sslSandbox = true;

// Razorpay Settings
const String razorpayid = 'REPLACE_WITH_RAZORPAY_ID';
const String razorpayCurrency = 'USD';

// Tap Payment Settings
const String tapApiId = 'REPLACE_WITH_TAP_API_KEY';

// Paystack Settings
const String paystackPublicId = 'REPLACE_WITH_PAYSTACK_PUBLIC_ID';
const String paystackSecretId = 'REPLACE_WITH_PAYSTACK_SECRET_ID';
const String payStackCurrency = 'ZAR';

// Flutterwave Settings
const String flutterwavePublicKey = 'REPLACE_WITH_FLUTTERWAVE_PUBLIC_KEY';
const String flutterwaveSecretKey = 'REPLACE_WITH_FLUTTERWAVE_SECRET_KEY';
const String flutterwaveEncryptionKey =
    'REPLACE_WITH_FLUTTERWAVE_ENCRYPTION_KEY';
const String flutterwaveCurrency = 'ZAR';

// Stripe Settings
const String stripePublishableKey = 'REPLACE_WITH_STRIPE_PUBLISHABLE_KEY';
const String stripeSecretKey = 'REPLACE_WITH_STRIPE_SECRET_KEY';
const String stripeCurrency = 'USD';
