import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController _controller; //Flutter自定義的動畫控制器

  //每個State在開始的時候有一個initState函數,結束的時候有一個dispose函數
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,//這裡寫上this, 然後在State上面加上with SingleTickerProviderStateMixin
      // lowerBound: 3.0,//讓AnimationController產生3~5的數值, 因為在initState(), 所以不支援hotreload
      // upperBound: 5.0,//預設是從0~1
    ); //初始化AnimationController
    _controller.addListener(() {
      print("${_controller.value}");
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          // child: RotationTransition( //旋轉動畫
          // turns:_controller, //需要一個動畫形式的Double
          // child: FadeTransition( //透明度動畫
          //   opacity: _controller,
          child: ScaleTransition(  //大小動畫
            scale: _controller,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _controller.repeat(reverse:true);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
