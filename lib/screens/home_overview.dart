import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import './home.dart';
import './map.dart';
import './profile.dart';
import './leaders.dart';
import './singleArticle.dart';
class HomeOverView extends StatefulWidget {
  static const pageRoute='/overview';
  @override
  _HomeOverViewState createState() => _HomeOverViewState();
}

class _HomeOverViewState extends State<HomeOverView> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _children = [Home(), Leaders(), MapScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentIndex==1?Text('Top Contrubiteur') :Text('مع بعضنا تونس احلى'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.person_pin), onPressed: (){
          Navigator.of(context).pushNamed(Profile.pageRoute);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SingleItem.pageRoute);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        currentIndex: currentIndex,
        hasInk: true,
        elevation: 8,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        onTap: _onItemTapped,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              icon: new Icon(
                Icons.home,
                color: Colors.black,
              ),
              backgroundColor: Colors.red,
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text('home')),
          BubbleBottomBarItem(
              icon: new Icon(
                Icons.outlined_flag,
                color: Colors.black,
              ),
              title: Text('Leaders'),
              activeIcon: Icon(Icons.outlined_flag),
              backgroundColor: Colors.purple),
          BubbleBottomBarItem(
              icon: Icon(
                Icons.map,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.map,
                color: Colors.green,
              ),
              backgroundColor: Colors.green,
              title: Text('Map'))
        ],
        opacity: .2,
      ),
      body: _children[currentIndex],
    );
  }
}
