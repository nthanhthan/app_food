import 'package:app_food/controllers/myOrdered_controller.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/widgets/shimmer.dart';
import 'package:app_food/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/colors.dart';
import 'myOrderedByType_page.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrderController>(builder: (myOrdered) {
      return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: controller,
              labelStyle: const TextStyle(fontSize: 10),
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              tabs: const [
                Tab(text: "Đã đặt"),
                Tab(
                  text: "Đang xử lí",
                ),
                Tab(
                  text: "Đang giao",
                ),
                Tab(
                  text: "Đã giao",
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteHelper.homepage, (route) => false),
            ),
            backgroundColor: AppColors.mainColor,
            title: const Text("Đơn hàng của tôi"),
            centerTitle: true,
          ),
          body: Navigator(
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => TabBarView(
                controller: controller,
                children: [
                  myOrdered.isLoaded
                      ? MyOrderedByType(data: myOrdered.listMyOrderedOrdered)
                      : const ShimmerLoad(),
                  myOrdered.isLoaded
                      ? MyOrderedByType(data: myOrdered.listMyOrderedProcessing)
                      : const ShimmerLoad(),
                  myOrdered.isLoaded
                      ? MyOrderedByType(data: myOrdered.listMyOrderedDelivering)
                      : const ShimmerLoad(),
                  myOrdered.isLoaded
                      ? MyOrderedByType(data: myOrdered.listMyOrderedDelivered)
                      :const ShimmerLoad(),
                ],
              ),
            ),
          ));
    });
  }
}
