import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newpizzeria/Details.dart';
import 'package:newpizzeria/HomeProvider.dart';
import 'package:newpizzeria/ProductPage.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool Traditional = true;
  bool Sides = false;
  bool Beverage = false;
  List<MenuClass> MenuArray = [];


  fetchData()
  {
    FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').once().then((DataSnapshot PizzaName) {
      var PizzaNames = PizzaName.value.keys;
      for(var PName in PizzaNames)
      {
        FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(PName).once().then((DataSnapshot FirstData){
          var values = FirstData.value;
          print('Value Name${values['Description']}');
          setState(() {
            MenuArray.add(MenuClass(Name: values['Name'],Description: values['Description'],ImageUrl: values['ImageUrl'],Price: values['Price']));

          });

        });

      }

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Consumer<HomeProvider>(builder: (conext,model,_){
      return  Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: Height/2.881,
              width: Width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/PizzaDesh.jpeg')
                  )
              ),
            ),
            Container(
              width: Width,
              padding: EdgeInsets.only(top: 20,left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap:(){
                      model.chageModel(TapbarselectedBool(true, false, false));

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Traditional',style: TextStyle(fontSize: 20,color:model.selectedValue.Traditional?Colors.red:Colors.grey ),),
                        Container(
                            height: 1,
                            width: 92,
                            color:model.selectedValue.Traditional?Colors.red:Colors.grey
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Width/13.8,
                  ),
                  InkWell(
                    onTap: (){
                      model.chageModel(TapbarselectedBool(false, true, false));

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Side',style: TextStyle(fontSize: 20,color:model.selectedValue.Sides?Colors.red:Colors.grey ),),
                        Container(
                            height: 1,
                            width: 46,
                            color:model.selectedValue.Sides?Colors.red:Colors.grey
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Width/13.8,
                  ),
                  InkWell(
                    onTap: (){
                      model.chageModel(TapbarselectedBool(false, false, true));

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Beverage',style: TextStyle(fontSize: 20,color:model.selectedValue.Beverage?Colors.red:Colors.grey ),),
                        Container(
                            height: 1,
                            width: 86,
                            color:model.selectedValue.Beverage?Colors.red:Colors.grey
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: Container(
                width: Width,
                padding: EdgeInsets.only(right: 20,left: 20),
                child: ListView.builder(
                  itemCount: MenuArray.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> secanimation,Widget child){
                                return FadeTransition(opacity: animation,child: child,);
                              },
                              pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secanimation){
                                return Details(PizzaName: MenuArray[i].Name,ImageUrl:  MenuArray[i].ImageUrl,Description: MenuArray[i].Description);
                              }));
                        },
                        child: Container(
                          height: 117,
                          width: Width,
                          child: Row(
                            children: [
                              Container(
                                height: 177,
                                width: 133,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(MenuArray[i].ImageUrl)
                                  )
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  height: 117,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(MenuArray[i].Name,style: TextStyle(fontSize: 20),),
                                      Text('${MenuArray[i].Description}',style: TextStyle(fontSize: 12,color: Colors.grey),maxLines: 2,),


                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),

      );
    });
  }
}
class MenuClass
{
  String Name;
  String Description;
  String ImageUrl;
  double Price;
  
  MenuClass({this.Name,this.Description,this.ImageUrl,this.Price});
}

