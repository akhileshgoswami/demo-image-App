import 'dart:convert';
import 'dart:developer';
import 'package:demo/comman/api_urls.dart';
import 'package:demo/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  int pageLimit = 1;
  RxInt totalPageCount = 0.obs;
  RxInt totalCount =  0.obs;
  RxList<Products> productsList = <Products>[].obs;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() async{

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   scrollController.addListener((){

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (pageLimit <= totalPageCount.value) {
        getImage(pageLimit);
      }
    }
   });
    
     });
 await getImage(1);
    // TODO: implement onInit
    super.onInit();
  }

  Future getImage(int page) async {

    if(pageLimit == 1){
     totalCount.value = 0;
    }
    String url = APIUrls.products + "?limit=10&skip=${totalCount.value}#";
    var response = await http.get(Uri.parse(url));
    log(response.body.toString());
    ImageModel responseData = ImageModel.fromJson(jsonDecode(response.body));

     totalPageCount.value =  responseData.total!;
    if (page == 1) {
      productsList.value = responseData.products!;
    } else {
      productsList.addAll(responseData.products!);
    }
   if(pageLimit==1){
     totalCount.value += responseData.products!.length + 1;
   }else{
     totalCount.value += responseData.products!.length;
   }
    pageLimit = ++page;
   
  }
}
