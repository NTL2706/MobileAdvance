import 'package:final_project_advanced_mobile/feature/post_a_project/views/project_post_1.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your projects",style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.5,
                        
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ProjectPost_1();
                        },));
                      },
                      child: Text("Post a jobs",style: TextStyle(
                        color: Colors.black
                      ),)
                    )
                  ],
                ),
                Row(

                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text("Welcom, ")),
                  )
                )
              ],
            ),
          ),
        ),
      );
  }

}