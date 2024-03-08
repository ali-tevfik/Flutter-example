import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final TextStyle menuStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0XFF343442);

class MenuDashBoard extends StatefulWidget {
  const MenuDashBoard({super.key});

  @override
  State<MenuDashBoard> createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<MenuDashBoard>
    with SingleTickerProviderStateMixin {
  double screenHeight = 0;
  double screenWidht = 0;
  bool isMenuOpen = false;
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<double>? _scaleMenuAnimation;
  Animation<Offset>? _menuOffsetAnimation;
  final Duration duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    if (_controller != null) {
      _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller!);
      _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
      _menuOffsetAnimation = Tween(
              begin: const Offset(-1, 0), end: const Offset(0, 0))
          .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn));
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[createMenu(context), createDashboard(context)],
        ),
      ),
    );
  }

  Widget createDashboard(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isMenuOpen ? 0.4 * screenWidht : 0,
      right: isMenuOpen ? -0.4 * screenWidht : 0,
      duration: duration,
      child: ScaleTransition(
        scale: _scaleAnimation ??
            Tween(begin: 1.0, end: 0.6).animate(_controller!),
        child: Material(
          borderRadius:
              isMenuOpen ? const BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (_controller != null) {
                                if (isMenuOpen) {
                                  _controller!.reverse();
                                } else {
                                  _controller!.forward();
                                }
                              }
                              isMenuOpen = !isMenuOpen;
                            });
                          },
                          child: const Icon(Icons.menu, color: Colors.white)),
                      const Text(
                        "My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const Icon(Icons.add_circle_outline_outlined,
                          color: Colors.white)
                    ],
                  ),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(top: 10),
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.green,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.yellow,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text("student $index"),
                          trailing: const Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Create menu with animation
  /// You have to make 2 steps:
  /// 1->Add menu item
  /// 2->When you click menu icon you have use   _controller!.forward(); or   _controller!.reverse()

  Widget createMenu(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation!,
      child: ScaleTransition(
        scale: _scaleMenuAnimation ??
            Tween(begin: 0.0, end: 1.0).animate(_controller!),
        child: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /**
                 * Menu item here
                 * For:Text("dashboard", style: menuStyle)
                 * Than if you need more space use:
                 *  const SizedBox(height:10)              
                 *  
                 */
                TextButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Text("dashboard",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Text(
                          "data",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: null,
                    child: Row(
                      children: [Text("data")],
                    )),
                TextButton(
                    onPressed: null,
                    child: Row(
                      children: [Text("data")],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
