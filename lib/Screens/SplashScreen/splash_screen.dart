// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_pos/Screens/SplashScreen/on_board.dart';
import 'package:mobile_pos/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import '../../GlobalComponents/license_verifier.dart';
import '../../currency.dart';
import '../../repository/subscription_repo.dart';
import '../Home/home.dart';
import '../language/language_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String newUpdateVersion = '1.1';

  bool isUpdateAvailable = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void getPermission() async {
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
  }

  final CurrentUserData currentUserData = CurrentUserData();

  // Future<void> getSubUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   isSubUser = prefs.getBool('isSubUser') ?? false;
  //   isSubUser ? currentUserData.getUserData() : null;
  // }

  @override
  void initState() {
    super.initState();
    init();
    getPermission();
    getCurrency();
    setLanguage();
    currentUserData.getUserData();
  }

  void setLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('savedLanguage') ?? 'English';
    selectedLanguage == 'English'
        ? context.read<LanguageChangeProvider>().changeLocale("en")
        : selectedLanguage == "Swahili"
            ? context.read<LanguageChangeProvider>().changeLocale("sw")
            : selectedLanguage == 'Arabic'
                ? context.read<LanguageChangeProvider>().changeLocale("ar")
                : selectedLanguage == 'Spanish'
                    ? context.read<LanguageChangeProvider>().changeLocale("es")
                    : selectedLanguage == 'Hindi'
                        ? context.read<LanguageChangeProvider>().changeLocale("hi")
                        : selectedLanguage == 'France'
                            ? context.read<LanguageChangeProvider>().changeLocale("fr")
                            : selectedLanguage == "Bengali"
                                ? context.read<LanguageChangeProvider>().changeLocale("bn")
                                : selectedLanguage == "Turkish"
                                    ? context.read<LanguageChangeProvider>().changeLocale("tr")
                                    : selectedLanguage == "Chinese"
                                        ? context.read<LanguageChangeProvider>().changeLocale("zh")
                                        : selectedLanguage == "Japanese"
                                            ? context.read<LanguageChangeProvider>().changeLocale("ja")
                                            : selectedLanguage == "Romanian"
                                                ? context.read<LanguageChangeProvider>().changeLocale("ro")
                                                : selectedLanguage == "Germany"
                                                    ? context.read<LanguageChangeProvider>().changeLocale("de")
                                                    : selectedLanguage == "Vietnamese"
                                                        ? context.read<LanguageChangeProvider>().changeLocale("vi")
                                                        : selectedLanguage == "Italian"
                                                            ? context.read<LanguageChangeProvider>().changeLocale("it")
                                                            : selectedLanguage == "Thai"
                                                                ? context.read<LanguageChangeProvider>().changeLocale("th")
                                                                : selectedLanguage == "Portuguese"
                                                                    ? context.read<LanguageChangeProvider>().changeLocale("pt")
                                                                    : selectedLanguage == "Hebrew"
                                                                        ? context.read<LanguageChangeProvider>().changeLocale("he")
                                                                        : selectedLanguage == "Polish"
                                                                            ? context.read<LanguageChangeProvider>().changeLocale("pl")
                                                                            : selectedLanguage == "Hungarian"
                                                                                ? context.read<LanguageChangeProvider>().changeLocale("hu")
                                                                                : selectedLanguage == "Finland"
                                                                                    ? context.read<LanguageChangeProvider>().changeLocale("fi")
                                                                                    : selectedLanguage == "Korean"
                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("ko")
                                                                                        : selectedLanguage == "Malay"
                                                                                            ? context.read<LanguageChangeProvider>().changeLocale("ms")
                                                                                            : selectedLanguage == "Indonesian"
                                                                                                ? context.read<LanguageChangeProvider>().changeLocale("id")
                                                                                                : selectedLanguage == "Ukrainian"
                                                                                                    ? context.read<LanguageChangeProvider>().changeLocale("uk")
                                                                                                    : selectedLanguage == "Bosnian"
                                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("bs")
                                                                                                        : selectedLanguage == "Greek"
                                                                                                            ? context.read<LanguageChangeProvider>().changeLocale("el")
                                                                                                            : selectedLanguage == "Dutch"
                                                                                                                ? context.read<LanguageChangeProvider>().changeLocale("nl")
                                                                                                                : selectedLanguage == "Urdu"
                                                                                                                    ? context.read<LanguageChangeProvider>().changeLocale("ur")
                                                                                                                    : selectedLanguage == "Sinhala"
                                                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("si")
                                                                                                                        : selectedLanguage == "Persian"
                                                                                                                            ? context
                                                                                                                                .read<LanguageChangeProvider>()
                                                                                                                                .changeLocale("fa")
                                                                                                                            : selectedLanguage == "Serbian"
                                                                                                                                ? context
                                                                                                                                    .read<LanguageChangeProvider>()
                                                                                                                                    .changeLocale("sr")
                                                                                                                                : selectedLanguage == "Khmer"
                                                                                                                                    ? context
                                                                                                                                        .read<LanguageChangeProvider>()
                                                                                                                                        .changeLocale("km")
                                                                                                                                    : selectedLanguage == "Lao"
                                                                                                                                        ? context
                                                                                                                                            .read<LanguageChangeProvider>()
                                                                                                                                            .changeLocale("lo")
                                                                                                                                        : selectedLanguage == "Russian"
                                                                                                                                            ? context
                                                                                                                                                .read<LanguageChangeProvider>()
                                                                                                                                                .changeLocale("ru")
                                                                                                                                            : selectedLanguage == "Kannada"
                                                                                                                                                ? context
                                                                                                                                                    .read<LanguageChangeProvider>()
                                                                                                                                                    .changeLocale("kn")
                                                                                                                                                : selectedLanguage == "Marathi"
                                                                                                                                                    ? context
                                                                                                                                                        .read<
                                                                                                                                                            LanguageChangeProvider>()
                                                                                                                                                        .changeLocale("mr")
                                                                                                                                                    : selectedLanguage == "Tamil"
                                                                                                                                                        ? context
                                                                                                                                                            .read<
                                                                                                                                                                LanguageChangeProvider>()
                                                                                                                                                            .changeLocale("ta")
                                                                                                                                                        : selectedLanguage ==
                                                                                                                                                                "Afrikaans"
                                                                                                                                                            ? context
                                                                                                                                                                .read<
                                                                                                                                                                    LanguageChangeProvider>()
                                                                                                                                                                .changeLocale("af")
                                                                                                                                                            : selectedLanguage ==
                                                                                                                                                                    "Czech"
                                                                                                                                                                ? context
                                                                                                                                                                    .read<
                                                                                                                                                                        LanguageChangeProvider>()
                                                                                                                                                                    .changeLocale(
                                                                                                                                                                        "cs")
                                                                                                                                                                : selectedLanguage ==
                                                                                                                                                                        "Swedish"
                                                                                                                                                                    ? context
                                                                                                                                                                        .read<
                                                                                                                                                                            LanguageChangeProvider>()
                                                                                                                                                                        .changeLocale(
                                                                                                                                                                            "sv")
                                                                                                                                                                    : selectedLanguage ==
                                                                                                                                                                            "Slovak"
                                                                                                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("sk")
                                                                                                                                                                        : selectedLanguage == "Swahili"
                                                                                                                                                                            ? context.read<LanguageChangeProvider>().changeLocale("sw")
                                                                                                                                                                            : selectedLanguage == "Burmese"
                                                                                                                                                                                ? context.read<LanguageChangeProvider>().changeLocale("my")
                                                                                                                                                                                : selectedLanguage == "Albanian"
                                                                                                                                                                                    ? context.read<LanguageChangeProvider>().changeLocale("sq")
                                                                                                                                                                                    : selectedLanguage == "Danish"
                                                                                                                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("da")
                                                                                                                                                                                        : selectedLanguage == "Azerbaijani"
                                                                                                                                                                                            ? context.read<LanguageChangeProvider>().changeLocale("az")
                                                                                                                                                                                            : selectedLanguage == "Kazakh"
                                                                                                                                                                                                ? context.read<LanguageChangeProvider>().changeLocale("kk")
                                                                                                                                                                                                : selectedLanguage == "Croatian"
                                                                                                                                                                                                    ? context.read<LanguageChangeProvider>().changeLocale("hr")
                                                                                                                                                                                                    : selectedLanguage == "Nepali"
                                                                                                                                                                                                        ? context.read<LanguageChangeProvider>().changeLocale("ne")
                                                                                                                                                                                                        : context.read<LanguageChangeProvider>().changeLocale("en");
    // selectedLanguage == 'Arabic' ? isArabic = true : isArabic = false;
  }

  getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency') ?? '\$';
    currencyName = prefs.getString('currencyName') ?? 'United States Dollar';
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  // bool isis = FirebaseAuth.instance.currentUser

  void init() async {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     const SplashScreen().launch(context, isNewTask: true);
    //   }
    // });
    setLanguage();
    final prefs = await SharedPreferences.getInstance();
    isPrintEnable = prefs.getBool('isPrintEnable') ?? true;
    final String? skipVersion = prefs.getString('skipVersion');
    final InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker.createInstance();
    bool result = await internetConnectionChecker.hasConnection;
    if (result) {
      bool isValid = await PurchaseModel().isActiveBuyer();
      if (isValid) {
        await Future.delayed(const Duration(seconds: 2), () {
          if (isUpdateAvailable && (skipVersion == null || skipVersion != newUpdateVersion)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Text(
                                    lang.S.of(context).anewUpdateAvailable,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await prefs.remove('skipVersion');
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: kMainColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        lang.S.of(context).updateNow,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await prefs.setBool('isSkipUpdate', false);
                                      await prefs.setString('skipVersion', newUpdateVersion);

                                      if (currentUser != null) {
                                        const Home().launch(context);
                                      } else {
                                        const OnBoard().launch(context);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: kMainColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        lang.S.of(context).skipTheUpdate,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (currentUser != null) {
                                        const Home().launch(context);
                                      } else {
                                        const OnBoard().launch(context);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: kMainColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        lang.S.of(context).rememberMeLater,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            // const RedeemConfirmationScreen().launch(context);
          } else {
            if (currentUser != null) {
              const Home().launch(context);
            } else {
              const OnBoard().launch(context);
            }
          }
        });
      } else {
        showLicense(context: context);
      }
    } else {
      await Future.delayed(const Duration(seconds: 2), () {
        if (isUpdateAvailable && (skipVersion == null || skipVersion != newUpdateVersion)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 10),
                                child: Text(
                                  lang.S.of(context).anewUpdateAvailable,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await prefs.remove('skipVersion');
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: kMainColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      lang.S.of(context).updateNow,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await prefs.setBool('isSkipUpdate', false);
                                    await prefs.setString('skipVersion', newUpdateVersion);

                                    if (currentUser != null) {
                                      const Home().launch(context);
                                    } else {
                                      const OnBoard().launch(context);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: kMainColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      lang.S.of(context).skipTheUpdate,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (currentUser != null) {
                                      const Home().launch(context);
                                    } else {
                                      const OnBoard().launch(context);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: kMainColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      lang.S.of(context).rememberMeLater,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          // const RedeemConfirmationScreen().launch(context);
        } else {
          if (currentUser != null) {
            const Home().launch(context);
          } else {
            const OnBoard().launch(context);
          }
        }
      });
    }
    defaultBlurRadius = 10.0;
    defaultSpreadRadius = 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.height() / 3,
            ),
            const Image(
              image: AssetImage('images/logoPos.png'),
            ),
            const Spacer(),
            Column(
              children: [
                Center(
                  child: Text(
                    lang.S.of(context).powerdedByAcnoo,
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20.0),
                  ),
                ),
                Center(
                  child: Text(
                    'V $appVersion',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
