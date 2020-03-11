import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class Leaders extends StatelessWidget {
  static const pageRoute = '/Leaders';
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context).users;
    return Container(
      width: double.infinity,
      child: ListView(

        children: <Widget>[
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage:users[0].photo ),
              title: Text(users[0].name,style: TextStyle(fontWeight:FontWeight.bold),),
              subtitle: Text(users[0].city),
              trailing: Text(users[0].score.toString(),style: TextStyle(color:Colors.red),),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage:users[1].photo),
              title: Text(users[1].name,style: TextStyle(fontWeight:FontWeight.bold),),
              subtitle: Text(users[1].city),
              trailing: Text(users[1].score.toString(),style: TextStyle(color:Colors.red),),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar( backgroundImage: users[2].photo ),
              title: Text(users[2].name,style: TextStyle(fontWeight:FontWeight.bold),),
              subtitle: Text(users[2].city),
              trailing: Text(users[2].score.toString(),style: TextStyle(color:Colors.red),),
            ),
          ),
        ],
        itemExtent: 70,
      ),
    );
  }
}
