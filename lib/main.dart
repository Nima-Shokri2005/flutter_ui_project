import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      theme: _themeMode == ThemeMode.light
          ? ThemeConfig.light().getTheme(_locale.languageCode)
          : ThemeConfig.dark().getTheme(_locale.languageCode),
      home: Nima(
        toggle: () {
          setState(
            () {
              if (_themeMode == ThemeMode.dark) {
                _themeMode = ThemeMode.light;
              } else {
                _themeMode = ThemeMode.dark;
              }
            },
          );
        },
        language: () {
          setState(
            () {
              if (_locale == const Locale('en')) {
                _locale = const Locale('fa');
              } else {
                _locale = const Locale('en');
              }
            },
          );
        },
      ),
    );
  }
}

class Nima extends StatefulWidget {
  Function() toggle;
  Function() language;

  Nima({super.key, required this.toggle, required this.language});

  @override
  State<Nima> createState() => _NimaState();
}

enum Item {
  photoshop,
  xd,
  illustrator,
  afterEffect,
  lightRoom,
}

enum _Language {
  en,
  fa,
}

class _NimaState extends State<Nima> {
  Item _item = Item.photoshop;

  void onTap(Item x) {
    setState(() {
      _item = x;
    });
  }

  bool like = true;

  void changeLike() {
    setState(() {
      like = !like;
    });
  }

  bool theme = true;

  void changeTheme() {
    setState(() {
      theme = !theme;
    });
  }

  _Language _language = _Language.en;

  void updateSelectedLanguage(_Language value) {
    setState(() {
      _language = value;
      widget.language();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.profileTitle,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'iranyekan'),
        ),
        actions: [
          const Icon(
            CupertinoIcons.chat_bubble,
          ),
          SizedBox(
            width: width * 0.03,
          ),
          InkWell(
            onTap: () {
              widget.toggle();
              changeTheme();
            },
            child: theme
                ? const Icon(
                    Icons.light_mode,
                  )
                : const Icon(
                    Icons.dark_mode,
                  ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.02, width * 0.04, height * 0.015),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/profile_image.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localization.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(localization.job),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                Text(localization.location),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeLike();
                        },
                        child: like
                            ? const Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                size: 18,
                                color: Colors.red,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, 0, width * 0.04, height * 0.003),
              child: Text(
                localization.summary,
                textAlign: TextAlign.justify,
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.015, width * 0.04, height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.selectedLanguage,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: width * 0.45,
                    height: height * 0.045,
                    child: CupertinoSegmentedControl<_Language>(
                        unselectedColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        selectedColor: Colors.pink,
                        pressedColor: Theme.of(context).dividerColor,
                        borderColor: Theme.of(context).dividerColor,
                        groupValue: _language,
                        children: {
                          _Language.en: Text(
                            localization.enLanguage,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          _Language.fa: Text(localization.faLanguage,
                              style: Theme.of(context).textTheme.bodyMedium),
                        },
                        onValueChanged: (value) {
                          updateSelectedLanguage(value);
                        }),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, 0, width * 0.04, height * 0.01),
              child: Row(
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  const Icon(
                    Icons.expand_more,
                    size: 16,
                  ),
                ],
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: width * 0.035,
              runSpacing: height * 0.015,
              children: [
                SkillItem(
                  type: Item.photoshop,
                  title: 'Photoshop',
                  imagePath: 'assets/images/app_icon_01.png',
                  isActive: _item == Item.photoshop,
                  shadowColor: Colors.blue,
                  onTap: () {
                    onTap(Item.photoshop);
                  },
                ),
                SkillItem(
                  type: Item.xd,
                  title: 'Adobe XD',
                  imagePath: 'assets/images/app_icon_05.png',
                  isActive: _item == Item.xd,
                  shadowColor: Colors.pink,
                  onTap: () {
                    onTap(Item.xd);
                  },
                ),
                SkillItem(
                  type: Item.illustrator,
                  title: 'Illustrator',
                  imagePath: 'assets/images/app_icon_04.png',
                  isActive: _item == Item.illustrator,
                  shadowColor: Colors.orange.shade100,
                  onTap: () {
                    onTap(Item.illustrator);
                  },
                ),
                SkillItem(
                  type: Item.afterEffect,
                  title: 'After Effect',
                  imagePath: 'assets/images/app_icon_03.png',
                  isActive: _item == Item.afterEffect,
                  shadowColor: Colors.blue.shade800,
                  onTap: () {
                    onTap(Item.afterEffect);
                  },
                ),
                SkillItem(
                  type: Item.lightRoom,
                  title: 'Lightroom',
                  imagePath: 'assets/images/app_icon_02.png',
                  isActive: _item == Item.lightRoom,
                  shadowColor: Colors.blue,
                  onTap: () {
                    onTap(Item.lightRoom);
                  },
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.01, width * 0.04, height * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(localization.personalInformation,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: const Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.password,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localization.save,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isActive;
  final Color shadowColor;
  final Item type;
  final Function() onTap;

  const SkillItem(
      {super.key,
      required this.type,
      required this.title,
      required this.imagePath,
      required this.isActive,
      required this.shadowColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    BorderRadius defaultBorderRadius = BorderRadius.circular(12);
    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        width: height * 0.12,
        height: height * 0.12,
        decoration: isActive
            ? BoxDecoration(
                borderRadius: defaultBorderRadius,
                color: Theme.of(context).dividerColor,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: shadowColor.withOpacity(0.5), blurRadius: 20),
                    ])
                  : null,
              child: Image.asset(
                imagePath,
                width: height * 0.065,
                height: height * 0.065,
              ),
            ),
            SizedBox(
              height: height * 0.012,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
