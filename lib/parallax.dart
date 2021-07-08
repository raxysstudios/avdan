import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxPage extends StatefulWidget {
  const ParallaxPage({Key? key}) : super(key: key);

  @override
  _ParallaxPageState createState() => _ParallaxPageState();
}

class _ParallaxPageState extends State<ParallaxPage> {
  var images = [
    AssetImage('assets/images/fruits/apple.png'),
    AssetImage('assets/images/fruits/cherry.png'),
    AssetImage('assets/images/fruits/melon.png')
  ];

  var accelerometer = AccelerometerEvent(0, 0, 0);
  var textX = TextEditingController.fromValue(TextEditingValue(text: '5.0'));
  var textY = TextEditingController.fromValue(TextEditingValue(text: '-5.0'));
  var scaleX = 5.0;
  var scaleY = -5.0;

  Matrix4 computeTranslation(scale) {
    return Matrix4.translationValues(
      accelerometer.x * scale * scaleX,
      accelerometer.y * scale * scaleY,
      0,
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen(
      (event) => setState(() {
        accelerometer = event;
      }),
    );
    textX = TextEditingController();
    textX.text = scaleX.toString();
    textX.addListener(
      () => setState(() {
        scaleX = double.tryParse(textX.text) ?? 0;
      }),
    );
    textY = TextEditingController();
    textY.text = scaleY.toString();
    textY.addListener(
      () => setState(() {
        scaleY = double.tryParse(textY.text) ?? 0;
      }),
    );
  }

  @override
  void dispose() {
    textX.dispose();
    textY.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parallax Test'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textX,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.swap_horiz_outlined),
                      labelText: 'Horizontal scale',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: textY,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.swap_vert_outlined),
                      labelText: 'Vertical scale',
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                for (var i = 0; i < images.length; i++)
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      transform: computeTranslation(i + 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image(
                          image: images[i],
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) =>
                              Text('AEAEAE'),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
