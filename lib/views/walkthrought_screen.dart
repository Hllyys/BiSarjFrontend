import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_bisarj/model/walkthrough_model.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import '../utils/app_assets.dart';
import 'authe/login/login_screen.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<WalkthroughModel> list = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    super.initState();
    list.add(
      WalkthroughModel(
        title: 'Easily find Ev charging\nstation around you',
        image: ic_walkthrough1,
        subTitle:
            'Effortlessly locate EV charging stations near you and stay powered on the go.',
      ),
    );
    list.add(
      WalkthroughModel(
        title: 'Fast and simple to make\nreservation & check in',
        image: ic_walkthrough2,
        subTitle:
            'Quick and easy reservations,seamless check-in at your fingertips.',
      ),
    );
    list.add(
      WalkthroughModel(
        title: 'Make payment safely &\nquickly with EV Charging',
        image: ic_walkthrough3,
        subTitle:
            'Secure and swift payments,tailored for your EV charging needs.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Color(0xffD96767).withOpacity(0.2),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: list.length,
                onPageChanged: (val) {
                  currentIndex = val;
                  setState(() {});
                },
                allowImplicitScrolling: true,
                itemBuilder: (_, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Image.asset(
                          height: 300,
                          list[index].image!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        list[index].title!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          list[index].subTitle!,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(list.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  height: 8,
                  width: index == currentIndex ? 24 : 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: index == currentIndex
                        ? Colors.green
                        : Colors.grey.withOpacity(0.4),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (currentIndex < list.length - 1) {
                  controller.nextPage(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutQuart,
                  );
                } else if (currentIndex == 2) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (_) => false,
                  );
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 350),
                      tween: Tween<double>(
                        begin: 0.0,
                        end: (currentIndex + 1) / 3,
                      ),
                      builder: (_, val, __) {
                        return CircularProgressIndicator(
                          color: Colors.green,
                          value: val,
                          strokeWidth: 2,
                        );
                      },
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
