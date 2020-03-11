import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/articles.dart';
import '../widget/pub.dart';
class Home extends StatelessWidget {
  static const pageRoute='/home';
  @override
  Widget build(BuildContext context) {
    final artcilesData=Provider.of<Articles>(context);
    return artcilesData.articles.length>0?ListView.builder(
      itemBuilder:(_,i)=>ChangeNotifierProvider.value(
       value: artcilesData.articles[i],
       child: Pub(),),
      itemCount:artcilesData.articles.length,      
    ):Center(child: Text('aucun post'));
  }
}