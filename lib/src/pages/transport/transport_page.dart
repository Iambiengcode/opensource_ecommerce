import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/pages/revenue_page.dart';
import 'package:van_transport/src/pages/sub_city/pages/manage_staff_page.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/pages/transport/pages/manage_order_page.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class TransportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<TransportPage>
    with SingleTickerProviderStateMixin {
  final transportController = Get.put(TransportController());
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFloatingButton = true;
  bool _createSubTransport = true;

  var _pages = [
    TransportManageOrderPage(pageName: 'Ongoing'),
    TransportManageOrderPage(pageName: 'Reject'),
    TransportManageOrderPage(pageName: 'History'),
    ManageStaffPage(),
    RevenuePage(),
  ];

  @override
  void initState() {
    super.initState();
    transportController.getTransport();
    _tabController = new TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      if (_tabController.index != 4) {
        setState(() {
          _showFloatingButton = true;
          _tabController.index != 3
              ? _createSubTransport = false
              : _createSubTransport = true;
        });
      } else {
        setState(() {
          _showFloatingButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showFloatingButton
          ? Container(
              height: width / 6.25,
              width: width / 6.25,
              child: FloatingActionButton(
                backgroundColor: colorTitle,
                child: Icon(
                  Feather.plus,
                  color: colorPrimaryTextOpacity,
                  size: width / 16.0,
                ),
                onPressed: () {
                  if (_createSubTransport) {
                    Get.toNamed(Routes.SUBCITY + Routes.REGISTERSTAFF);
                  } else {
                    // Go to create Subcity
                  }
                },
              ),
            )
          : null,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: 1.5,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'transportOwner'
              .trArgs()
              .replaceAll('For ', '')
              .replaceAll('Cho c', 'C'),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          StreamBuilder(
            stream: transportController.getTransportStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return IconButton(
                  onPressed: () => null,
                  icon: Icon(
                    Feather.edit_3,
                    color: colorTitle,
                    size: width / 16.0,
                  ),
                );
              }

              return IconButton(
                onPressed: () => Get.toNamed(
                  Routes.DELIVERY + Routes.EDITDELIVERY,
                  arguments: snapshot.data,
                ),
                icon: Icon(
                  Feather.edit_3,
                  color: colorTitle,
                  size: width / 16.0,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: colorPrimary,
          indicatorColor: colorPrimary,
          unselectedLabelColor: colorTitle.withOpacity(.825),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1.75,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width / 28.5,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width / 28.5,
          ),
          tabs: [
            Container(
              width: width * .185,
              child: Tab(
                text: 'onGoing'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'reject'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'history'.trArgs(),
              ),
            ),
            Container(
              width: Get.locale == Locale('vi', 'VN')
                  ? width * .265
                  : width * .305,
              child: Tab(
                text: 'manageStaff'.trArgs(),
              ),
            ),
            Container(
              width: width * .18,
              child: Tab(
                text: 'statistics'.trArgs(),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
