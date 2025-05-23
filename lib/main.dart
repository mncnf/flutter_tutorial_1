import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// エントリーポイント
void main() {
  // MyAppを起動
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // buildメソッドは、ウィジェットツリーを構築するためのメソッド
  // ChangeNotifierProviderは、状態管理のためのプロバイダを作成する
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// アプリの状態を管理するクラス
// ChangeNotifierを継承しているので、状態が変化したときに通知することができる
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners(); // 状態が変化したことを通知
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // watchメソッドを使って、MyAppStateの状態を監視する
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
            onPressed: () {
              appState.getNext(); // ボタンが押されたときにgetNextメソッドを呼び出す
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
