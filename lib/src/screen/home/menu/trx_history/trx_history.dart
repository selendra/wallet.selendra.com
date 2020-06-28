import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class TrxHistory extends StatefulWidget{

  final String _walletKey;

  TrxHistory(this._walletKey);

  @override
  State<StatefulWidget> createState() {
    return TrxHistoryState();
  }
}

class TrxHistoryState extends State<TrxHistory>{

  final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true; bool isLogout = false;

  List<dynamic> _history = [];
  List<dynamic> _trxSend = [];
  List<dynamic> _trxReceived = [];

  GetRequest _getRequest = GetRequest();

  InstanceTrxOrder _instanceTrxAllOrder;
  InstanceTrxOrder _instanceTrxSendOrder;
  InstanceTrxOrder _instanceTrxReceivedOrder;

  @override
  void initState() {
    _instanceTrxAllOrder = InstanceTrxOrder();
    _instanceTrxSendOrder = InstanceTrxOrder();
    _instanceTrxReceivedOrder = InstanceTrxOrder();
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    await _getRequest.trxUserHistory().then((_response) async { /* Get Response Data */
      if ( (_response.runtimeType.toString()) != "List<dynamic>" && (_response.runtimeType.toString()) != "_GrowableList<dynamic>" ){ /* If Response DataType Not List<dynamic> */ 
        if (_response.containsKey("error")){
          if (this.mounted){ /* Prevent Future SetState */
            setState(() {
              _history = null; /* Set Portfolio Equal Null To Close Loading Process */
            });
          }
        }
      } else {
        if (this.mounted) { /* Prevent Future SetState */
          collectByTrxType(_response);
          setState(() {
            _history = _response;
          });
        }
      } 
    });
  }

  void collectByTrxType(List _trxHistory){ // Collect Transaction By Type "Send", And Received
    _trxHistory.forEach((element) {
      if (element.containsKey('from') && widget._walletKey == element['from']){
        _trxSend.add(element);
      } else if (widget._walletKey != element['from'] && element['type'] != "manage_offer") { /* Send Trx If Source Account Address Not Equal Wallet Adddress */ 
        _trxReceived.add(element);
      }
    });
    sortByDate(_trxSend, _instanceTrxSendOrder);
    sortByDate(_trxHistory, _instanceTrxAllOrder);
    sortByDate(_trxReceived, _instanceTrxReceivedOrder);
    // print(_trxSend.length);
    // print(_trxHistory.length);
    // print(_trxReceived.length);
  }

  void sortByDate(List _trxHistory, InstanceTrxOrder _instanceTrxOrder){
    _instanceTrxOrder = AppUtils.trxMonthOrder(_trxHistory);
  }

  /* Scroll Refresh */
  void reFresh() {
    setState(() {
      isProgress = true;
    });
    fetchHistoryUser();
    _refreshController.refreshCompleted();
  }

  void popScreen() {
    Navigator.pop(context, {});
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        key: _globalKey,
        body: SafeArea(
          child: trxHistoryBody(
            context,  
            _trxSend,
            _history,
            _trxReceived,
            _instanceTrxSendOrder,
            _instanceTrxAllOrder,
            _instanceTrxReceivedOrder,
            widget._walletKey, 
            popScreen
          ),
        ),
      ),
    );
  }
}
