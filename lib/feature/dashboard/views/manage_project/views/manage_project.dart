import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/material.dart';

class ManageProject extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasicPage(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: CustomTabBar(
                lengOfTabBar: 4,
                tabs: [
                  Text("Proposals",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Detail",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Message",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Hired",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                ],
                 tab_views: [
                  Container(child: Center(child: Text("Proposals"),)),
                  Container(child: Center(child: Text("Detail"),)),
                  Container(child: Center(child: Text("Message"),)),
                  Container(child: Center(child: Text("Hired"),)),
                ],
              ),
            ),
          ],
        ),
      ),
    ) ;
  }

}