import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/services/localization_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {

  final List<dynamic> _lang = [
    {
      'locale' : Locale('en', ''),
      'name' : 'English'
    },
    {
      'locale' : Locale('km', ''),
      'name' : 'ខ្មែរ'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationService>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        title: Text(
          AppLocalizations.of(context).language,
          style: TextStyle(color: Colors.orange),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:  ListView.builder(
              itemCount: _lang.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    final langProvider =
                    Provider.of<LocalizationService>(context, listen: false);

                    langProvider.setLocale(_lang[index]['locale']);
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.black54),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_lang[index]['name']),
                        provider.locale == _lang[index]['locale'] ? Icon(Icons.check_circle_rounded, size: 18, color: Colors.orange,) : Text('')
                      ],
                    ),
                  ),
                );
              }
          )
      ),
    );
  }
}
