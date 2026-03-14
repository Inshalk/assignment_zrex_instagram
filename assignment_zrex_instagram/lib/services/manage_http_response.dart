import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse(
  {
    required http.Response response,//The http response from the request
    required BuildContext context,//Context is to show snackbar 

    required VoidCallback onSuccess,//The callback is to execute successfull response
  
  }) {
    //Switch statements to handle http codes
    switch(response.statusCode){
      case 200: 
      onSuccess();
      break;

      case 400://Status code 400 indicates a bad request
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
     
      case 500://Status code 500 indicates a sever error
      showSnackBar(context, json.decode(response.body)['msg']);
      break;

      case 201://Status code 201 indicates a resouce was successfully created
      onSuccess();
      break;



    }
  }

  void showSnackBar(BuildContext context,String title){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));

  }