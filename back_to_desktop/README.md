# back_to_desktop
**仅支持android**  

模仿home键作用


## Getting Started

Import package: `package:back_to_desktop/back_to_desktop.dart';`

Example: [完整例子](./example/lib/main.dart)

```dart
import 'package:back_to_desktop/back_to_desktop.dart';

...

@override
Widget build(BuildContext context) {
var random = Random().nextInt(10);
return MaterialApp(
    home: WillPopScope(
    onWillPop: () async {
        await BackToDesktop.backToDesktop();
        //important
        return false;
    },
    child: Scaffold(
        appBar: AppBar(
        title: Text('Plugin example app'),
        ),
        body: Center(
        child: Text('Random:$random'),
        ),
    ),
    ),
);
}

```