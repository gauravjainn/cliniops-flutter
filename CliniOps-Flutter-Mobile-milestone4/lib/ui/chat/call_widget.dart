import 'dart:io';
import 'package:clini_app/data/constants/app_color.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class OpenTokConfig {
  final String API_KEY;
  final String SESSION_ID;
  final String TOKEN;
  OpenTokConfig({
    required this.API_KEY,
    required this.SESSION_ID,
    required this.TOKEN,
  });
}

class CallWidget extends StatefulWidget {
  CallWidget({Key? key, this.title, this.config}) : super(key: key);
  final String? title;
  final OpenTokConfig? config;

  @override
  _CallWidgetState createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  SdkState _sdkState = SdkState.LOGGED_OUT;
  bool _publishAudio = true;
  bool _publishVideo = true;

  static const platformMethodChannel = const MethodChannel('com.vonage');

  _CallWidgetState() {
    platformMethodChannel.setMethodCallHandler(methodCallHandler);

    _initSession();
  }

  Future<dynamic> methodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'updateState':
        {
          setState(() {
            var arguments = 'SdkState.${methodCall.arguments}';
            _sdkState = SdkState.values.firstWhere((v) {
              return v.toString() == arguments;
            });
          });
        }
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  Future<void> _initSession() async {
    await requestPermissions();

    String token = "ALICE_TOKEN";
    dynamic params = {
      'apiKey': widget.config!.API_KEY,
      'sessionId': widget.config!.SESSION_ID,
      'token': widget.config!.TOKEN
    };

    try {
      await platformMethodChannel.invokeMethod('initSession', params);

      
    } on PlatformException catch (e) {
      print(e);
    } 
  }

    Future<void> requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<void> _swapCamera() async {
    try {
      await platformMethodChannel.invokeMethod('swapCamera');
    } on PlatformException catch (e) {}
  }

  Future<void> _toggleAudio() async {
    _publishAudio = !_publishAudio;

    dynamic params = {'publishAudio': _publishAudio};

    try {
      print(params);

      await platformMethodChannel.invokeMethod('toggleAudio', params);
      setState(() {});
    } on PlatformException catch (e) {}
  }

  Future<void> _toggleVideo() async {
    _publishVideo = !_publishVideo;
    _updateView();

    dynamic params = {'publishVideo': _publishVideo};

    try {
      await platformMethodChannel.invokeMethod('toggleVideo', params);
      setState(() {});
    } on PlatformException catch (e) {}
  }

  Future<void> destorySession() async {
    try {
      await platformMethodChannel.invokeMethod('destory');
    } on PlatformException catch (e) {}
  }

  @override
  void dispose() {
    destorySession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title ?? 'NA'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          backgroundColor: const Color(0xff12999E),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child:_updateView(),
        ));
  }

  Widget _updateView() {
    bool? toggleVideoPressed = false;

    if (_sdkState == SdkState.LOGGED_OUT) {
      return ElevatedButton(
          onPressed: () {
            _initSession();
          },
          child: Text("Reload"));
    } else if (_sdkState == SdkState.WAIT) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_sdkState == SdkState.LOGGED_IN) {
      return Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: Platform.isAndroid
                ? PlatformViewLink(
                    viewType:
                        'opentok-video-container', // custom platform-view-type
                    surfaceFactory: (BuildContext context,
                        PlatformViewController controller) {
                      return AndroidViewSurface(
                        controller: controller as AndroidViewController,
                        gestureRecognizers: const <
                            Factory<OneSequenceGestureRecognizer>>{},
                        hitTestBehavior:
                            PlatformViewHitTestBehavior.transparent,
                      );
                    },
                    onCreatePlatformView: (PlatformViewCreationParams params) {
                      return PlatformViewsService.initSurfaceAndroidView(
                        id: params.id,
                        viewType: 'opentok-video-container',
                        // custom platform-view-type,
                        layoutDirection: TextDirection.ltr,

                        creationParams: {},
                        creationParamsCodec: const StandardMessageCodec(),
                      )
                        ..addOnPlatformViewCreatedListener(
                            params.onPlatformViewCreated)
                        ..create();
                    },
                  )
                : UiKitView(
                    viewType: 'opentok-video-container',
                    layoutDirection: TextDirection.ltr,
                    creationParams: {},
                    creationParamsCodec: const StandardMessageCodec(),
                    onPlatformViewCreated: (int id) {},
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    heroTag: const Hero(
                      tag: '1',
                      child: Icon(
                        Icons.cameraswitch,
                        size: 36,
                      ),
                    ),
                    child: const Icon(
                      Icons.cameraswitch,
                      size: 36,
                    ),
                    onPressed: () {
                      _swapCamera();
                    },
                    backgroundColor: AppColors.appPrimary,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _toggleAudio();
                    },
                    backgroundColor: AppColors.appPrimary,
                    heroTag: Hero(
                        tag: '2',
                        child: Icon(
                          !_publishAudio ? Icons.mic_off : Icons.mic,
                          size: 36,
                        )),
                    child: Icon(
                      !_publishAudio ? Icons.mic_off : Icons.mic,
                      size: 36,
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        _toggleVideo();
                      },
                      backgroundColor: AppColors.appPrimary,
                      child: Icon(
                        !_publishVideo
                            ? Icons.videocam_off_outlined
                            : Icons.videocam_outlined,
                        size: 36,
                      ),
                      heroTag: Hero(
                          tag: '3',
                          child: Icon(
                            !_publishVideo
                                ? Icons.videocam_off_outlined
                                : Icons.videocam_outlined,
                            size: 36,
                          ))),
                  FloatingActionButton(
                      onPressed: () async {
                        await destorySession();
                        AppEnvironment.navigator.pop();
                      },
                      backgroundColor: AppColors.redOrangePrimary,
                      child: const Icon(
                        Icons.call_end,
                        size: 36,
                      ),
                      heroTag: const Hero(
                          tag: '4',
                          child: Icon(
                            Icons.call_end,
                            size: 36,
                          ))),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return const Center(child: Text("ERROR"));
    }
  }
}

enum SdkState { LOGGED_OUT, LOGGED_IN, WAIT, ON_CALL, ERROR }
