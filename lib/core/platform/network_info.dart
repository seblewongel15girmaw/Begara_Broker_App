
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class Network{
  Future<bool> isConnected();
}

class NetworkImpl extends Network{
  final Connectivity connectivity;
  NetworkImpl(this.connectivity);
  @override
  Future<bool> isConnected() async {
    final connection= await connectivity.checkConnectivity();
    if(connection.contains(ConnectivityResult.none)){
      return false;
    }
    else{
      return true;
    }
  
  }

}