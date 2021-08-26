import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Details extends StatefulWidget {
  String PizzaName;
  String ImageUrl;
  String Description;
  Details({this.PizzaName,this.ImageUrl,this.Description});

  @override
  _DetailsState createState() => _DetailsState();
}
enum SingingCharacter { OneOption, MultiOptions, }

class _DetailsState extends State<Details> {
  List<SizesClass> SizedArray =[];
  SingingCharacter _character = SingingCharacter.OneOption;
  List<String> SubVaration = [];
  List<VariationClasses> Variationarray = [];
  bool isChecked = false;

  fetchSized()
  {

    FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(widget.PizzaName).child('Sized').once().then((DataSnapshot SizedName) {
      var Names = SizedName.value.keys;
      print('Sized ${widget.PizzaName}');

      for(var Name in Names)
        {

          FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(widget.PizzaName).child('Sized').child(Name).once().then((DataSnapshot Sizedvalues)
          {
            var value = Sizedvalues.value;

            setState(() {
              SizedArray.add(SizesClass(Name: value['Name'],Price: value['Price']));
              print('Sized ${SizedArray.length}');

            });
          });
        }
    });
  }
  fetchVariation()
  {
    SubVaration = [];

    FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(widget.PizzaName).child('Variation').once().then((DataSnapshot VariationNamesSnapshot){
      var VariationNames = VariationNamesSnapshot.value.keys;
      for(var i in VariationNames){
        FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(widget.PizzaName).child('Variation').child(i).once().then((DataSnapshot FinalValues) {
          var value = FinalValues.value.keys;
          for(var VName in value)
            {
              print('Names $VName');
              if(VName != 'MultiOption' )
                {
                  SubVaration.add(VName);

                }
            }
          setState(() {
            print('VName $i SubArray $SubVaration Option ${FinalValues.value['MultiOption']}');
            Variationarray.add(VariationClasses(VariationName: i,SubVariation: SubVaration,Option: FinalValues.value['MultiOption']));
          });


        });

      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    fetchSized();
    fetchVariation();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Height/2.881,
            width: Width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.ImageUrl)
                )
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding:  EdgeInsets.only(left: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.PizzaName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10,),
                  Text(widget.Description,style: TextStyle(fontSize: 15),),
                  SizedBox(height: 10,),
                  Text('Sizes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10,),
                  Container(
                    width: Width,
                    height: 100,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: SizedArray.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.grey
                              ),
                              child: Transform.scale(
                                scale: 1.4,
                                child: Radio<SingingCharacter>(
                                  activeColor: Colors.red,

                                  value: index ==1 ?SingingCharacter.OneOption:SingingCharacter.MultiOptions,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text(SizedArray[index].Name,style: TextStyle(fontSize: 15),),
                            SizedBox(width: 10,),
                            Text('${SizedArray[index].Price} JD',style: TextStyle(fontSize: 15),),

                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Variation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10,),
                  Container(
                    width: Width,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: Variationarray.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Variationarray[index].VariationName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height: 10,),
                            Container(
                          width:Width,
                          height: 200,
                          child: ListView.builder(
                          itemCount: Variationarray[index].SubVariation.length,
                          itemBuilder: (BuildContext context,int i){
                            print(Variationarray[index].Option);
                          return   Row(
                            children: [
                              Variationarray[index].Option == false?Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.grey
                                ),
                                child: Transform.scale(
                                  scale: 1.4,
                                  child: Radio<SingingCharacter>(
                                    activeColor: Colors.red,

                                    value: index ==1 ?SingingCharacter.OneOption:SingingCharacter.MultiOptions,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                              ):
                            Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool value) {
                            setState(() {
                            isChecked = value;
                            });
                            },
                            ),
                              Text(Variationarray[index].SubVariation[i],style: TextStyle(fontSize: 15),),

                            ],
                          );
                          }
                          ),
                        ),


                          ],
                        );
                      },
                    ),
                  ),




                ],
              ),
            ),
          ),





        ],
      ),
    );
  }
}
class SizesClass
{
  String Name;
  int Price;
  SizesClass({this.Name,this.Price});
}
class VariationClasses
{
  String VariationName;
  List<String>SubVariation;
  bool Option;
  VariationClasses({this.VariationName,this.SubVariation,this.Option});
}