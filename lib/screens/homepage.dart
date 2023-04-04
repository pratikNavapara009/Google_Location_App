import 'package:flutter/material.dart';
import 'package:google_map_app/globals/global.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  locationpermission() async {
    PermissionStatus status = await Permission.location.request();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${status}"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    locationpermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Locator",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 1),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              children: allceo
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed("detail page", arguments: e);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height / 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue,
                                offset: Offset(2, -2),
                                spreadRadius: 3,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "${e['image']}",
                                fit: BoxFit.fill,
                                scale: 2.8,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${e['cname']}",
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "${e['ceoname']}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage("${e['ceoimage']}")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
