import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/auth/login/login_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/add_event/add_event.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/utils/app_color.dart';
import 'package:evently_app/ui/utils/app_route.dart';
import 'package:evently_app/ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

extension ScreenUtils on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = context.watch<LanguageProvider>();
    var themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoardingPage(),
      //initialRoute: AppRoute.homeRouteName,
      routes: {
        AppRoute.homeRouteName: (context) => const HomeScreen(),
        AppRoute.loginRouteName: (context) => const LoginScreen(),
        AppRoute.registerRouteName: (context) => const RegisterScreen(),
        AppRoute.addEventRouteName: (context) =>  AddEvent(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = context.watch<LanguageProvider>();
    var themeProvider = context.watch<ThemeProvider>();
    bool isEnglish = languageProvider.appLanguage == 'en';

    List<Map<String, String>> pageData = [
      {
        "image": themeProvider.isDark ? "assets/images/being-creative-dark.png" : "assets/images/being-creative.png",
        "title": AppLocalizations.of(context)?.personalize ?? "",
        "body": AppLocalizations.of(context)?.content ?? "",
      },
      {
        "image": themeProvider.isDark ? "assets/images/hot-trending-dark.png" : "assets/images/hot-trending.png",
        "title": AppLocalizations.of(context)?.personalize2 ?? "",
        "body": AppLocalizations.of(context)?.content2 ?? "",
      },
      {
        "image": themeProvider.isDark ? "assets/images/2ndBGdk.png" : "assets/images/2ndBG.png",
        "title": AppLocalizations.of(context)?.personalize3 ?? "",
        "body": AppLocalizations.of(context)?.content3 ?? "",
      },
      {
        "image": themeProvider.isDark ? "assets/images/3rdBGdk.png" : "assets/images/3rdBG.png",
        "title": AppLocalizations.of(context)?.personalize4 ?? "",
        "body": AppLocalizations.of(context)?.content4 ?? "",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: Column(
            children: [
              SizedBox(height: context.height * 0.02),

              // Logo + Skip
              Stack(
                children: [
                  // اللوجو على اليسار
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: context.height * 0.08,
                    ),
                  ),

                  // Skip على اليمين، يظهر من الصفحة الثانية
                  if (currentPage > 0)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * 0.03,
                            vertical: context.height * 0.008,
                          ),
                          child: Text(
                            AppLocalizations.of(context)?.skip ?? "Skip",
                            style: TextStyle(
                              fontSize: context.height * 0.018,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF246BFD),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: context.height * 0.01),

              SizedBox(height: context.height * 0.01),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pageData.length,
                  onPageChanged: (index) => setState(() => currentPage = index),
                  itemBuilder: (context, index) {
                    var data = pageData[index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            data["image"]!,
                            height: context.height * 0.35,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: context.height * 0.02),
                      
                          // Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(pageData.length, (dotIndex) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: context.width * 0.01),
                                width: currentPage == dotIndex
                                    ? context.width * 0.05
                                    : context.width * 0.02,
                                height: context.height * 0.01,
                                decoration: BoxDecoration(
                                  color: currentPage == dotIndex
                                      ? const Color(0xFF246BFD)
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: context.height * 0.015),
                      
                          Text(
                            data["title"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeProvider.isDark ? AppColors.whiteColor : AppColors.blackColor,
                                fontSize: context.height * 0.028,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: context.height * 0.01),
                      
                          Text(
                            data["body"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeProvider.isDark? AppColors.whiteDarkColor : AppColors.greyColor,
                                fontSize: context.height * 0.018),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // اللغة والثيم للصفحة الأولى فقط
              if (currentPage == 0) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.height * 0.02 ,
                      color: themeProvider.isDark? AppColors.whiteColor : AppColors.mainColorlight

                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => languageProvider.changeLanguage('en'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.width * 0.04,
                                vertical: context.height * 0.008),
                            decoration: BoxDecoration(
                              color: isEnglish
                                  ? themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.mainColorlight),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.english,
                              style: TextStyle(
                                  color: isEnglish
                                      ? Colors.white
                                      : themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight,
                                  fontSize: context.height * 0.018),
                            ),
                          ),
                        ),
                        SizedBox(width: context.width * 0.02),
                        GestureDetector(
                          onTap: () => languageProvider.changeLanguage('ar'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.width * 0.04,
                                vertical: context.height * 0.008),
                            decoration: BoxDecoration(
                              color: !isEnglish
                                  ? themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.arabic,
                              style: TextStyle(
                                  color: !isEnglish
                                      ? Colors.white
                                      : themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight,
                                  fontSize: context.height * 0.018),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.height * 0.02 ,
                          color: themeProvider.isDark? AppColors.whiteColor : AppColors.mainColorlight
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => themeProvider.changeTheme(ThemeMode.light),
                          child: Container(
                            padding: EdgeInsets.all(context.height * 0.008),
                            decoration: BoxDecoration(
                              color: !themeProvider.isDark
                                  ? themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.light_mode,
                              size: context.height * 0.022,
                              color: !themeProvider.isDark ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: context.width * 0.02),
                        GestureDetector(
                          onTap: () => themeProvider.changeTheme(ThemeMode.dark),
                          child: Container(
                            padding: EdgeInsets.all(context.height * 0.008),
                            decoration: BoxDecoration(
                              color: themeProvider.isDark
                                  ?  themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.dark_mode,
                              size: context.height * 0.022,
                              color: themeProvider.isDark ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],

              SizedBox(height: context.height * 0.02),
              SizedBox(
                width: double.infinity,
                height: context.height * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < pageData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  themeProvider.isDark? AppColors.mainColordark : AppColors.mainColorlight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentPage == 0
                        ? AppLocalizations.of(context)!.letsStart
                        : currentPage == pageData.length - 1
                        ? AppLocalizations.of(context)!.getStart
                        : AppLocalizations.of(context)?.next ?? "Next",
                    style: TextStyle(
                        fontSize: context.height * 0.022,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}