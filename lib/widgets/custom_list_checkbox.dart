import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_chabhuoy/repository/open_shop_repository.dart';
import 'package:provider/provider.dart';

class CustomListCheckBox extends StatefulWidget {

  CustomListCheckBox({@required this.data, @required this.function, @required this.stringType, @required this.title});

  final dynamic data;
  final String stringType;
  final String title;
  final Function function;

  @override
  _CustomListCheckXoxState createState() => _CustomListCheckXoxState();
}

class _CustomListCheckXoxState extends State<CustomListCheckBox> {

  int _group;

  @override
  Widget build(BuildContext context) {
    final openShopRepository = Provider.of<OpenShopRepository>(context);

    return AlertDialog(
      title: Text(widget.title ?? ''),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListBody(
            children: widget.data.map<Widget>((item) => customRadioButton(
                title: item.name,
                value: item.id,
                groupValue: _group,
                onChanged: (newValue) {
                  if (widget.stringType == 'city') {
                    openShopRepository.setCity(id: item.id, name: item.name);
                    openShopRepository.setDistrict(id: null, name: null);
                  }
                  if (widget.stringType == 'membership') {
                    openShopRepository.setMembership(id: item.id, name: item.name);
                    openShopRepository.setSupplier(id: null, name: null);
                  }

                  if (widget.stringType == 'district') {
                    openShopRepository.setDistrict(id: item.id, name: item.name);
                    openShopRepository.setSupplier(id: null, name: null);
                  }

                  if (widget.stringType == 'supplier') {
                    openShopRepository.setSupplier(id: item.id, name: item.name);
                  }

                  setState(() {
                    _group = newValue;
                  });
                  Navigator.pop(context);
                }
            )).toList(),
          ),
        ),
      ),
    );
  }

  Widget customRadioButton({String title, int value,int groupValue, Function onChanged}) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: AppTheme.primaryColor
      ),
      child: RadioListTile(
        contentPadding: const EdgeInsets.all(0),
        activeColor: AppTheme.primaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }
}
