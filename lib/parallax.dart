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

  Matrix4 computeTranslation(double scale) {
    return Matrix4.translationValues(
      accelerometer.x * scale,
      accelerometer.y * -scale,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parallax Test'),
      ),
      body: Stack(
        children: [
          for (var i = 0; i < images.length; i++)
            Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                transform: computeTranslation(8.0 * (i + 1)),
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
            )
        ],
      ),
    );
  }
}
