import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newpizzeria/BottomNavigator.dart';
import 'package:path/path.dart';
import 'BottomNavigator.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}
enum SingingCharacter { OneOption, MultiOptions, }

class _ProductPageState extends State<ProductPage> {
  SingingCharacter _character = SingingCharacter.OneOption;
  bool Option =false;

  File _image;
  String imageurl = 'hi';
  String _uploadedFileURL;
  /// Get from gallery
  _getFromGallery() async {

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        uploadFile1();
      });
    }
  }
  Future uploadFile1() async {
    print('here');
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('Album').child(TitleCo.value.text).child('${basename(_image.path)}}');
    var uploadTask = await storageReference.putFile(_image);
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        imageurl = fileURL;

        print("Url is $imageurl");

      });
    });




  }


  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  List<SizedClass> SizedArray = [];
  List<String> SubVariation = [];
  List<VariationClass> VariationArrray = [];

  final TitleCo = TextEditingController();
  final DescriptionCo = TextEditingController();
  final AddSize = TextEditingController();
  final SizePrice = TextEditingController();
  final VariationName = TextEditingController();
  final AddSubVariation = TextEditingController();
  bool startupload = false;

  UploadData()
  {
    startupload = true;
    FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(TitleCo.value.text).set(
        {
          'Name':TitleCo.value.text,
          'Description':DescriptionCo.value.text,
          'ImageUrl':imageurl

        });
    for(var i =0;i<SizedArray.length;i++)
      {
        FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(TitleCo.value.text).child('Sized').child(SizedArray[i].SizeName).set(
            {
              'Name':SizedArray[i].SizeName,
              'Price':SizedArray[i].SizePrice,

            });

      }

  }
  AddVariation()
  {
    for(var i =0;i<VariationArrray.length;i++)
    {
      FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(TitleCo.value.text).child('Variation').child(VariationArrray[i].VariationName).set(
          {
            'MultiOption':VariationArrray[i].Options,

          });
      print('lenght${VariationArrray.length}');
      // for(var x;x<VariationArrray[i].SubVariation.length;x++)
      // {
      //
      // }
    }
  }
  AddSubvariation() async
  {
      for(var i = 0;i<VariationArrray.length;i++)
      {
        for(var x =0;x<VariationArrray[i].SubVariation.length;x++)
          {
            FirebaseDatabase.instance.reference().child('FoodMenu').child('Traditional').child(TitleCo.value.text).child('Variation').child(VariationArrray[i].VariationName).child(VariationArrray[i].SubVariation[x]).update(
                {
                  'Name':VariationArrray[i].SubVariation[x]
                });
            print('Sub${VariationArrray[i].SubVariation[x]}');
          }
        if(i==VariationArrray.length -1)
          {
           setState(() {
             startupload = false;
             showDialog<void>(
               barrierDismissible: false, // user must tap button!
               builder: (BuildContext context) {
                 return AlertDialog(
                   title: const Text('Done'),
                   content: Text('Please Go to the menu.'),
                   actions: <Widget>[
                     TextButton(
                       child: const Text('Done'),
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                     ),
                   ],
                 );
               },
             );
           });
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: startupload?Center(child: LinearProgressIndicator(),):Column(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  _getFromGallery();
                });
              },
              child: Stack(
                children: [
                  Container(
                    height: Height/2.881,
                    width: Width,
                    child:  _image != null
                        ? Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                        : Container(

                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _image != null?true:false,
                    child: Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Center(child: Icon(Icons.delete,color: Colors.white,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height:10),
            Padding(
              padding:  EdgeInsets.only(left: 10,right: 10),
              child: Container(
                width: Width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: TitleCo,
                      decoration: InputDecoration(
                          hintText: 'Title'
                      ),
                    ),
                    SizedBox(height:10),
                    TextField(
                      controller: DescriptionCo,
                      decoration: InputDecoration(
                          hintText: 'Description'
                      ),
                    ),
                    SizedBox(height:10),
                    Text('Sized',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child:   TextField(
                            controller: AddSize,
                            decoration: InputDecoration(
                                hintText: 'Add Size'
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          width: 100,
                          child:   TextField(
                            controller: SizePrice,
                            decoration: InputDecoration(
                                hintText: 'Add Price'
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        InkWell(
                            onTap: (){
                              setState(() {
                                if(AddSize.value.text.isEmpty || SizePrice.value.text.isEmpty)
                                  {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text('Please Fill All Size Data.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Done'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }else
                                    {
                                      SizedArray.add(SizedClass(SizeName: AddSize.value.text,SizePrice: double.parse(SizePrice.value.text)));

                                      AddSize.text='';
                                      SizePrice.text='';
                                    }
                              });
                            },
                            child: Icon(Icons.add))


                      ],
                    ),
                    SizedBox(height:10),
                    Container(
                      width: Width,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: SizedArray.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 40,
                              color: index.isEven?Colors.grey:Color(0XFFFAFAFA),
                              child: Row(
                                children: [
                                  Text(SizedArray[index].SizeName,style: TextStyle(fontSize: 15),),
                                  SizedBox(width: 20,),
                                  Text('${SizedArray[index].SizePrice} JD',style: TextStyle(fontSize: 15)),
                                  Spacer(),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          SizedArray.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete)),


                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height:10),

                    Text('Variation',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
                      color: Colors.transparent,

                      child: TextField(
                        controller: VariationName,
                        decoration: InputDecoration(
                            hintText: 'Variation Name'
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    Text('Sub Variation',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child:   TextField(
                            controller: AddSubVariation,
                            decoration: InputDecoration(
                                hintText: 'Add Sub Variation'
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                if(AddSubVariation.value.text.isEmpty)
                                  {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text('Please Fill All Sub Variation .'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Done'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }else
                                    {
                                      SubVariation.add(AddSubVariation.value.text);
                                      AddSubVariation.text ='';
                                    }
                              });
                            },
                            child: Icon(Icons.add))
                      ],
                    ),
                    SizedBox(height:10),
                    Container(
                      width: Width,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: SubVariation.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 40,
                              color: index.isEven?Colors.grey:Color(0XFFFAFAFA),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(SubVariation[index],style: TextStyle(fontSize: 15),),

                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          SubVariation.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.delete)),


                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.grey
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: Radio<SingingCharacter>(
                              activeColor: Colors.red,

                              value: SingingCharacter.OneOption,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                  Option = false;
                                });
                              },
                            ),
                          ),
                        ),
                        Text('One Option',style: TextStyle(fontSize: 18,color: Colors.black),)
                      ],
                    ),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Colors.grey
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: Radio<SingingCharacter>(
                              activeColor: Colors.red,

                              value: SingingCharacter.MultiOptions,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                  Option = true;

                                });
                              },
                            ),
                          ),
                        ),
                        Text('Multi Options',style: TextStyle(fontSize: 18,color: Colors.black),)
                      ],
                    ),
                    SizedBox(height:10),
                    InkWell(
                      onTap: (){
                        setState(() {
                          VariationArrray.add(VariationClass(VariationName: VariationName.value.text,SubVariation: SubVariation,Options: Option));
                          VariationName.text = '';
                          SubVariation=[];

                        });
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10,bottom: 10),
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(child: Text('Add Variation',style: TextStyle(fontSize: 15,color: Colors.white),)),
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
                      width: Width,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: VariationArrray.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              color: index.isEven?Colors.grey:Color(0XFFFAFAFA),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(VariationArrray[index].VariationName,style: TextStyle(fontSize: 15),),
                                      Text(VariationArrray[index].Options?'Multi Option':'One Option',style: TextStyle(fontSize: 15),),

                                      InkWell(
                                          onTap: (){
                                            setState(() {
                                              VariationArrray.removeAt(index);

                                            });
                                          },
                                          child: Icon(Icons.delete)),


                                    ],
                                  ),
                                  Container(
                                    width: Width,
                                    height: 100,
                                    child: ListView.builder(
                                      itemCount: VariationArrray[index].SubVariation.length,
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                          title: Text(VariationArrray[index].SubVariation[i]),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height:10),
                    InkWell(
                      onTap: () async{
                        await UploadData();
                        await AddVariation();
                        await AddSubvariation();
                         SizedArray = [];
                         SubVariation = [];
                         VariationArrray = [];



                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10,bottom: 10),
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(child: Text('Add Product',style: TextStyle(fontSize: 15,color: Colors.white),)),
                        ),
                      ),
                    ),
                    SizedBox(height:10),






                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
class SizedClass
{
  String SizeName;
  double SizePrice;
  SizedClass({this.SizeName,this.SizePrice});
}
class VariationClass
{
  String VariationName;
  List<String> SubVariation;
  bool Options;
  VariationClass({this.VariationName,this.SubVariation,this.Options});

}
