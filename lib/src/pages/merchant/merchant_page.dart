import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/empty/empty_order_page.dart';
import 'package:van_transport/src/pages/merchant/pages/product_page.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class MerchantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<MerchantPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFloatingButton = false;

  var _pages = [
    EmptyOrderPage(),
    Container(color: mC),
    EmptyOrderPage(),
    ProductPage(),
    Container(color: mC),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      setState(() {
        _tabController.index == 3
            ? _showFloatingButton = true
            : _showFloatingButton = false;
      });
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
                onPressed: () =>
                    Get.toNamed(Routes.MERCHANT + Routes.CREATEGROUP),
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
          'merchant'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.MERCHANT + Routes.EDITMERCHANT),
            icon: Icon(
              Feather.edit_3,
              color: colorTitle,
              size: width / 16.0,
            ),
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
              width: Get.locale == Locale('vi', 'VN')
                  ? width * .265
                  : width * .305,
              child: Tab(
                text: 'waitForConfirm'.trArgs(),
              ),
            ),
            Container(
              width: width * .185,
              child: Tab(
                text: 'onGoing'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'history'.trArgs(),
              ),
            ),
            Container(
              width:
                  Get.locale == Locale('vi', 'VN') ? width * .18 : width * .16,
              child: Tab(
                text: 'product'.trArgs(),
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
