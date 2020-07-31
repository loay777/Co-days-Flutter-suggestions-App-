import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spin_the_wheel/board_view.dart';
import 'spin_the_wheel/model.dart';


class SpinTheWheelScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _SpinTheWheelScreenState();
  }
}

class _SpinTheWheelScreenState extends State<SpinTheWheelScreen>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  List<Luck> _items ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    final lucks = Provider.of<List<Luck>>(context);
    _items= lucks;
/*    lucks.forEach((luck){ // for debugging
    print(luck.suggestion);
    print(luck.color.toString());
    });
    int index=0;*/ // fpr debugging

    return Container(
      padding: EdgeInsets.all(0.0),
      height:450 ,
        child: AnimatedBuilder(
            animation: _ani,
            builder: (context, child) {
              final _value = _ani.value;
              final _angle = _value * this._angle;
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[

              Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
              alignment: Alignment.topCenter,
              child: Text('Spin For Random Suggeestion',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
              ),
              ),
                  BoardView(items: lucks, current: _current, angle: _angle),
                  _buildGo(),
                  _buildResult(_value),

                ],
              );
            }),
      );
  }

  _buildGo() {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "GO",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: _animation,
      ),
    );
  }

  _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  int _calIndex(value) {
    var _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
    String _asset = _items[_index].suggestion;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(_asset,style: TextStyle(color: Colors.limeAccent,fontSize: 28.0,fontWeight: FontWeight.bold),),
      ),
    );
  }

}
