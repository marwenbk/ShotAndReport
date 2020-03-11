import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/article.dart';

class Pub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final art = Provider.of<Article>(context);

    final deviceSize = MediaQuery.of(context).size;
    final snack = SnackBar(
      content: Text('You already Voted!'),
      duration: Duration(seconds: 2),
    );
    return Container(
      width: deviceSize.width * 0.8,
      height: deviceSize.height * 0.24,
      child: Card(
          margin: EdgeInsets.all(7),
          elevation: 5,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(0),
                  height: deviceSize.height * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        color: art.vote == 1
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        splashColor: Colors.green,
                        onPressed: () {
                          if (art.vote == 1) {
                            Scaffold.of(context).showSnackBar(snack);
                          } else {
                            art.toggeladd();
                          }
                        },
                      ),
                      Text(art.votes.toString()),
                      IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          splashColor: Colors.red,
                          color: art.vote == -1 ? Colors.red : Colors.black,
                          onPressed: () {
                            if (art.vote == -1) {
                              Scaffold.of(context).showSnackBar(snack);
                            } else {
                              art.del();
                            }
                          })
                    ],
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: deviceSize.width * 0.7,
                    height: deviceSize.height * 0.13,
                    child: ListTile(
                      title: Text(art.nom),
                      subtitle:
                          Flex(direction: Axis.horizontal, children: <Widget>[
                        Expanded(
                            child: Text(
                          art.description,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )),
                      ]),
                      leading: art.icon,
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                          child: Container(child: Image.file(art.image,fit: BoxFit.cover,),
                          height: 100,
                          width: 70,),),
                    ),
                  ),
                ])
              ])),
    );
  }
}
