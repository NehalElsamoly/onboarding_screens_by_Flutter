import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login.dart';
class OnboardingModel{
  final String image;
  final String title;
  OnboardingModel(
      {
        required this.image,
    required this.title
});
}
class Onboarding extends StatefulWidget {
   Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
List<OnboardingModel>boarding=[
  OnboardingModel(image: 'assets/images/wheather1.png', title: 'page1'),
  OnboardingModel(image: 'assets/images/wheather2.png', title: 'page2'),
  OnboardingModel(image: 'assets/images/wheather3.png', title: 'page3'),

];

bool is_last=false;

var boardcontrol=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          MaterialButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) =>Login()), (route){
              return true;
            });
          },
            child:Text("SKIP")
          )
        ]
      ),
      body:Column(
        children:[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PageView.builder(
                itemBuilder: (context,index)=>onboardingItem(boarding[index]),
                controller: boardcontrol,
                itemCount: boarding.length,
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState(() {
                      is_last=true;
                    });
                  }else{
                    setState(() {
                      is_last=false;
                    });
                  }
                }
                ,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:[


             SmoothPageIndicator(controller: boardcontrol,
                 count: boarding.length,
                 effect: ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   activeDotColor: Colors.cyan,
                   dotHeight: 10,
                   dotWidth: 10,
                   expansionFactor: 4,
                   spacing:5
                 ),
             ),
                Spacer(),
                Container(
                  width:50,
                  height: 50,
                  child: FloatingActionButton(onPressed: (){
                    if(is_last==true){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) =>Login()), (route){
                        return false;
                      });
                    }else{
                      boardcontrol.nextPage(duration: Duration(
                          milliseconds: 200
                      ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                    },
                    

                    backgroundColor: Colors.cyan,
                    child:Icon(Icons.arrow_forward_ios,color: Colors.white,),

                  ),
                )
    ]
            ),
          )
        ]
      )
    );
  }

  Widget onboardingItem(OnboardingModel model){
    return Column(
        children:[
          Expanded(child:
          Image(image:
          AssetImage('${model.image}'),)),
          SizedBox(height:10),
          Text('${model.title}',style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        ]
    );
  }
}
