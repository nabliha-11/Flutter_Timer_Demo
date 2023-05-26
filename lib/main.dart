import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'time_out.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(
          title: 'Timer Demo',
          //stopAudio:stopAudio;
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;

  late AudioPlayer player;
  //bool _isRunninng=false;

  void loadAudio(){
    player.setAsset('audio/alarm.wav');
  }

  void playAudio() {
    player.play();
    playing=true;
  }

  void pauseAudio() {
    player.pause();
    playing=false;
  }

  void stopAudio() {
    player.stop();
    playing=false;
  }




  int _seconds = 10;
  double max_sec_=10;
  int hour_=0;
  int min_=0;
  int ssec=10;
  bool _isRunning = false;
  int _tempseconds = 0;
  bool playing=false;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    startTimer();
  }

  void startTimer() {
    if(!_isRunning) {
      const second = Duration(seconds: 1);
      _timer = Timer.periodic(second, (Timer timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _timer.cancel();
            _isRunning = false;
            loadAudio();
            playAudio();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimeOut(stopAudio: stopAudio),
              ),
            );

          }
        });
      });
    }
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      _tempseconds = _seconds;
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = ssec;
      _tempseconds = ssec;
      _isRunning = false;
    });
  }

  String getTimerText() {

    if(!_isRunning){
      _seconds = _tempseconds;
    }

    int hours = (_seconds ~/ 3600);
    int minutes = (_seconds ~/ 60) % 60;
    int seconds = _seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double getProgress() {
    return (_seconds) / max_sec_;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child : CircularProgressIndicator(
                value: getProgress(),
                color: Colors.deepPurpleAccent,
                strokeWidth: 30,
                backgroundColor: Colors.pink,
              ),
            ),
            Center(
              child: Text(
                getTimerText(),
                style: GoogleFonts.laila(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon:_isRunning? const Icon(Icons.stop):const Icon(Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        if (!_isRunning) {
                          startTimer();
                          _isRunning = true;
                        }
                        else {
                          resetTimer();
                          _isRunning = false;
                        }
                      });
                    }
                  ),
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      setState(() {
                        if (_isRunning) {
                          pauseTimer();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}