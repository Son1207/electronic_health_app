import 'package:electronic_health_app/models/global_user_info.dart';
import 'package:electronic_health_app/models/observer_pattern.dart';
import 'package:electronic_health_app/page/Home/Components/category_home.dart';
import 'package:electronic_health_app/page/Home/Components/home_actions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> implements Observer {
  @override
  String observerName = 'homepage';

  String username = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        username = GlobalUserInfo.instance.info!.fullName;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[900],
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                shadowColor: Colors.black,
                backgroundColor: Colors.blue[900],
                leading: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Image.asset(
                      'assets/images/icons.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  'Hello $username',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.blue[300])),
                        onPressed: () {},
                        icon: const Icon(
                          size: 30,
                          Icons.notifications,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryHome(MediaQuery.of(context).size),
              ),
              const InformationHome()
            ],
          ),
        ));
  }

  @override
  void whenNotified() {
    if (mounted) {
      username = GlobalUserInfo.instance.info!.fullName;
      setState(() {});
      debugPrint("notified $observerName");
    }
  }
}
