
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../base/show_custom_snackbar.dart';

Future<void> connect(token) async {
    String url="https://takefooduserorder.azurewebsites.net/notifysocket";
    HubConnection hubConnection;
    hubConnection = HubConnectionBuilder().withUrl(url,options: HttpConnectionOptions(accessTokenFactory: () =>Future.value(token),requestTimeout: 15000))
        .build();
    await hubConnection.start();
    print(hubConnection.state);
    hubConnection.on("sendToUser", (value) { showCustomSnackBar(title: value![0].toString(),value![1].toString(),type: false);});
}
