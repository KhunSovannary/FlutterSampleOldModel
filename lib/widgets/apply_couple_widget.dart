import 'package:flutter/material.dart';

class ApplyCouponWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.18,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.grey,
                      primaryColorDark: Colors.grey,
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                        hintText: 'Code',
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20)
                      ),
                    ),
                  )
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,

                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => {},
                    child: Text('Apply', style: TextStyle(
                      color: Colors.white, fontSize: 16
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
