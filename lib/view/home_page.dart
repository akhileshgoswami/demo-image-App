import 'package:demo/controller/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageController pageController = ImageController();

  @override
  void initState() {
    pageController = Get.put(ImageController());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ImageController>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Image App")),
      body: Column(
        children: [
          Expanded(
              child: Obx(()=>
           pageController.productsList.isNotEmpty?   ListView.builder(
                    itemCount: pageController.productsList.length,
                    controller: pageController.scrollController,
                    shrinkWrap: true,
                  
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(children: [
                          Text(pageController.productsList[index].title!),
                          pageController.productsList[index].images!.isNotEmpty
                              ? Image.network(
                                  pageController.productsList[index].images![0],
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: Colors.blue.shade100,
                                  ),
                                )
                              : const  SizedBox()
                        ]),
                      );
                    }): const  SizedBox(child: Center(child: CircularProgressIndicator()),),
              ))
        ],
      ),
    );
  }
}
