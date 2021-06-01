import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/config/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddToCardWidget extends StatelessWidget {

  AddToCardWidget({
    @required this.onPressDecreasing,
    @required this.onPressIncreasing,
    @required this.onPressAdd,
    @required this.count
  });

  final Function onPressDecreasing;
  final Function onPressIncreasing;
  final Function onPressAdd;
  final int count;

  @override
  Widget build(BuildContext context) {
//    final cartRepository = Provider.of<CartRepository>(context);

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.width * 0.15,
      child: Row(
        children: [
          Flexible(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_circle, color: AppTheme.primaryColor, size: 30,),
                      onPressed: onPressDecreasing,
                  ),
                  Text(count.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  IconButton(
                      icon: Icon(Icons.add_circle, color: AppTheme.primaryColor, size: 30,),
                      onPressed: onPressIncreasing,
                  )
                ],
              )
          ),
          Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                    color: count <= 0 ? Colors.grey : AppTheme.primaryColor,
                    splashColor: AppTheme.primaryColor,
                    onPressed: onPressAdd,
                    child: Text(AppLocalizations.of(context).addToCart, style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}


