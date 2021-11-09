import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store',
      initialRoute: '',
      routes: {
        '': (context) => const MyHomePage(title: ''),
        '/game': (context) => const SkyWarriorsPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class SkyWarriorsPage extends StatelessWidget {
  const SkyWarriorsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GamePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Hero(
              tag: "SkyWarriors",
              child: Container(
                width: 355,
                height: 250,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("../images/SkyWarriors.jpg"),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyModel extends ChangeNotifier {
  int _games = 0;

  void addGame() {
    _games += 1;
    notifyListeners();
  }

  void removeGames() {
    _games = 0;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _likedGames = 0;

  final _inactiveColor = Colors.grey;

  late ScrollController _scrollController;

  void setLikedGames(isToAdd) {
    if (isToAdd) {
      setState(() {
        _likedGames += 1;
      });
    } else {
      setState(() {
        _likedGames -= 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 48,
      backgroundColor: Colors.black,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.favorite_border),
          title: const Text('Today'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.search),
          title: const Text('Games'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.content_copy),
          title: const Text('Applications'),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.emoji_events),
          title: const Text('Arcade'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.search),
          title: const Text('Search'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Drawer Header'),
            ),
            const GamesToBuy(),
            Text("You liked $_likedGames games")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: _scrollToTop,
      ),
      bottomNavigationBar: _buildBottomBar(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Games",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                        size: 30,
                      )),
                ],
              ),
              const Divider(color: Colors.grey),
              Column(
                children: [
                  Row(children: const [
                    Text(
                      "NEW GAME",
                      style: TextStyle(fontSize: 10, color: Colors.blue),
                    )
                  ]),
                  Row(children: const [
                    Text(
                      "Sky Warriors: aircraft battles",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ]),
                  Row(children: const [
                    Text(
                      "Hot battles in the air",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ]),
                  Hero(
                    tag: "SkyWarriors",
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.all(0))),
                      onPressed: () {
                        Navigator.push(context,
                            CustomPageRoute((const SkyWarriorsPage())));
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              "../images/SkyWarriors.jpg",
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('What we play',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    Text('Show all',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker.jpg",
                  title: "Arena of Valor",
                  type: "Величайшая битва в режиме 5v5",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_1.jpg",
                  title: "F1 Mobile Racing",
                  type: "Официальная игра F1 2021 года",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_2.jpg",
                  title: "Mario Kart Tour",
                  type: "Экшен",
                  setLikedGames:setLikedGames),
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('You may like',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    Text('Show all',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_3.jpg",
                  title: "Oceanhorn 2",
                  type: "Рыцари забытого коро..",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_4.jpg",
                  title: "Samurai Jack",
                  type: "Battle Though Time",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_5.jpg",
                  title: "Don't Starve: Pocke..",
                  type: "Приключения",
                  setLikedGames:setLikedGames),
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Top Games',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    Text('Show all',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_6.jpg",
                  title: "Minecraft",
                  type: "Приключения",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_7.jpg",
                  title: "Plague Inc.",
                  type: "Сможете заразить весь мир?",
                  setLikedGames:setLikedGames),
              GameInStore(
                  imagePath: "../images/ezgif.com-gif-maker_8.jpg",
                  title: "GTA San Andreas",
                  type: "Экшен",
                  setLikedGames:setLikedGames),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const NavButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => {},
          child: Column(
            children: <Widget>[
              Icon(icon, color: Colors.white),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class GameInStore extends StatelessWidget {
  final String imagePath;
  final String title;
  final String type;
  final void Function(bool)? setLikedGames;

  const GameInStore({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.type,
    this.setLikedGames
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
                            child: Row(
                              children: [
                                Text(
                                  type,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFF212121),
                            border: Border.all(
                              color: const Color(0xFF212121),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextButton(
                              onPressed: () => {
                                Provider.of<MyModel>(context, listen: false).addGame()
                              },
                              child: const Text(
                                'PURCHASE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            )

                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text("In-game purchases",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey,
                              )),
                        ),
                        LikeButton(setLikedGames:setLikedGames)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GamesToBuy extends StatelessWidget {
  const GamesToBuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyModel>(
        builder: (context, myModel, child) {
        return Column(
          children: <Widget>[
            Text('You bought ${myModel._games} games'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () => {
                    myModel.removeGames()
                  },
                  child: Column(
                    children: const <Widget>[
                      Text(
                        "Sell games",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
      child: const GameInStore(
          imagePath: "../images/ezgif.com-gif-maker.jpg",
          title: "Arena of Valor",
          type: "Величайшая битва в режиме 5v5"
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final void Function(bool)? setLikedGames;

  const LikeButton({Key? key, this.setLikedGames}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState(setLikedGames);
}

class _LikeButtonState extends State<LikeButton> {
    final void Function(bool)? setLikedGames;

    _LikeButtonState(this.setLikedGames);

    bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => {
            setState(() {
              _isLiked = !_isLiked;
            }),
            setLikedGames!(_isLiked)
          },
          icon: const Icon(Icons.favorite),
          color: _isLiked ? Colors.red : Colors.white,
        ),
      ],
    );
  }
}

class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF212121),
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        height: double.maxFinite,
        duration: const Duration(microseconds: 250),
        decoration: BoxDecoration(
          color: const Color(0xFF212121),
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? Colors.white : Colors.grey),
                  child: item.icon,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                      maxLines: 1,
                      textAlign: item.textAlign,
                      child: item.title,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;

  CustomPageRoute(this.child);

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
