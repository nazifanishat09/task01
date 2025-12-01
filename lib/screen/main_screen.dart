import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:task01/api/api_1.dart';
import 'package:task01/api/datebase.dart';
import 'package:task01/screen/searchber.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;
  List qData = [];

  loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    qData = (await Api().ApiData())["data"];
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1FAF5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Motivational Quotation",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),

      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator(color: Colors.teal))
          : qData.isEmpty
          ? Center(child: Text("No data found"))
          : Column(
              children: [
                SearchBer(),
                //SizedBox(height:0),
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.teal,
                    onRefresh: () async {
                      qData = (await Api().ApiData())["data"];
                      setState(() {});
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      itemCount: qData.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 100,
                          // width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image(
                                      image: AssetImage("assets/inverted.png"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${qData[index]["quote"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${qData[index]["author"]}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
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
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
