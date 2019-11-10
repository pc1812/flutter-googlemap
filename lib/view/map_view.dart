
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter2019/bloc/geo_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapView extends StatelessWidget {
  final String title;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
      
  GoogleMapView({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    // var bloc = Provider.of<GeoBloc>(context, listen:true);

    return Consumer<GeoBloc> (
        builder: (context, bloc, child) => Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
          initialUrl: bloc.googleUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
            }
      ),
      floatingActionButton: (
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            if (_controller.isCompleted) {
              _controller.future.then((onValue) {
                print('google url '+bloc.googleUrl);
                onValue.reload();
              });
            }
          },
        )
      ),
    )
    );
  }
}