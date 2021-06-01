import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chabhuoy/models/home_model.dart';
import 'package:flutter_chabhuoy/repository/home_repository.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:flutter_chabhuoy/widgets/banner_widget.dart';
import 'package:flutter_chabhuoy/widgets/category_widget.dart';
import 'package:flutter_chabhuoy/widgets/product_grid_widget.dart';
import 'package:flutter_chabhuoy/widgets/scroll_product_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  int activeBanner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);
    final homeRepository = Provider.of<HomeRepository>(context);
    if (homeRepository.countBanner == 0 ||
        homeRepository.countCategory == 0 ||
        homeRepository.countProduct == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        homeRepository.getHome(localizationService.locale);
      });
    }

    return homeRepository.countBanner == 0 || homeRepository.countCategory == 0 || homeRepository.countProduct == 0 ? Center(
      child: CircularProgressIndicator(),
    ) : SingleChildScrollView(
        child: NotificationListener<ScrollEndNotification>(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerWidget(banners: homeRepository.banners),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AppLocalizations.of(context).category,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 10),
                CategoryWidget(data: homeRepository.categories),
                Text(AppLocalizations.of(context).product,
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 20),
                ProductGridWidget(
                    products: homeRepository.products,
                    scrollController: _scrollController),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
