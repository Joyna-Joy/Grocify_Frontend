import 'package:flutter/material.dart';
import 'package:grocify_frontend/Customer/CustomerPages/Login_Page.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/GorceryItems.dart';
import 'package:grocify_frontend/RecipeForm/FormPages/Recipe_Form.dart';

  class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
  }

  class _WelcomePageState extends State<WelcomePage> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/WelcomePage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],

                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            'GROCIFY',
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Instant Delivery",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Get Started Button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                            child: Text(
                              'Product Purchase',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return LoginPage();
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xfff83801),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: OutlinedButton(
                            child: Text(
                              'Flavor Forum',
                              style: TextStyle(
                                color:Color(0xfff83801),
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return RecipeForm();
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                            child: Text(
                              'Shoping List',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return GroceryListScreen();
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xfff83801),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        // CheckboxListTile(
                        //   value: _rememberMe,
                        //   onChanged: (value) {
                        //     if (value == null) return;
                        //     setState(() {
                        //       _rememberMe = value;
                        //     });
                        //   },
                        //   title: const Text('By joining Grocify, you agree to our Terms of service and Privacy policy',style: TextStyle( fontWeight: FontWeight.w900,color: Colors.white),),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   dense: true,
                        //   activeColor: Colors.deepOrange,
                        //   contentPadding: const EdgeInsets.all(0),
                        //  ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  }

