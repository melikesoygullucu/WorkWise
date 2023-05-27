import 'package:WorkWise/screens/MainPage/Profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/theme_provider.dart';
import '../screens/Login/login.dart';

void settingpage() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class irem extends StatefulWidget {
  const irem({Key? key}) : super(key: key);

  @override
  State<irem> createState() => _iremState();
}

class _iremState extends State<irem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Enter your e-mail and we'll send you a password reset link to your email. ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => themeProvider(ThemeData.dark())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SettingPageUI(),
      ),
    );
  }
}

class SettingPageUI extends StatefulWidget {
  @override
  _SettingPageUIState createState() => _SettingPageUIState();
}

class _SettingPageUIState extends State<SettingPageUI> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("$command bulunamadı");
    }
  }

  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;
  bool _iconBool = false;

  IconData _iconLight = Icons.wb_sunny;

  IconData _iconDark = Icons.nights_stay;
  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
  );

  ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );

  onChangeFunction(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Settings", style: TextStyle(fontSize: 22)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPasswordPage();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    " Change Password ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Suggestions and Opinions",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  customLaunch("mailto:helloworld@gmail.com");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "     E mail     ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  customLaunch("tel:05071931635");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    " Telephone  ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.nights_stay,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              IconButton(
                onPressed: () => theme.setTheme(ThemeData.dark()),
                icon: Icon(Icons.nights_stay),
                /* setState(() {
          _iconBool = !_iconBool;
        });*/
                /* icon: Icon(_iconBool ? _iconDark : _iconLight),*/
              ),
              IconButton(
                onPressed: () => theme.setTheme(ThemeData.light()),
                icon: Icon(Icons.wb_sunny),
              ),
              SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          showRegisterPage: () {},
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildLanguageOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dil ayarları sayfasını açmak için gerekli işlemleri burada yapın
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dil Seçimi",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Icon(Icons.arrow_forward, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  GestureDetector buildRegionOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Region'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Perform necessary actions for Turkey selection
                        print('Turkey selected');
                      },
                      child: Text('Turkey'),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Perform necessary actions for Germany selection
                        print('Germany selected');
                      },
                      child: Text('Germany'),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Perform necessary actions for France selection
                        print('France selected');
                      },
                      child: Text('France'),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Perform necessary actions for USA selection
                        print('USA selected');
                      },
                      child: Text('United States'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.blue,
        child: Text(
          "Region Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Option1"), Text("Option2")],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"))
              ],
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
          Icon(Icons.arrow_forward, color: Colors.grey[600]),
        ],
      ),
    ),
  );
}
