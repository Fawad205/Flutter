import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  String slectedValue = 'lahore';
  @override
  Widget build(BuildContext context ){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body:SafeArea(
          bottom: true,
          child:Column(
            children: [
              
              Expanded(
                child: Row(
                  children: [OutlinedButton(onPressed: () => {},
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.grey),
                  child: Text("Submit"),
                  ),

                TextButton(onPressed: ()=>{},
                style: TextButton.styleFrom(backgroundColor: Colors.black54),
                 child: Text("cencel"))
                ]
                ),
                
              ),
              
               Container(
                padding: EdgeInsets.fromLTRB(10, 15, 20, 25),
                width: 100,
                height: 100,
                color: Colors.black26,

                child: ListTile(
                  leading: Icon(Icons.abc_outlined),
                  title: const Text('Ahmad'),
                  subtitle: Text('how are u '),
                  
                ),
              ),
              SizedBox(width: 100,height: 100,),
              DropdownButton<String>(
                value: slectedValue,
                hint: Text('Select city'),
                items:[
                  DropdownMenuItem(
                    value: 'lahore',
                    child:Text('lahore') 
                    ),
                  DropdownMenuItem(
                    value: 'Faisalabad',
                    child:Text('Faisalabad') 
                    ),
                    DropdownMenuItem(
                    value: 'Multan',
                    child:Text('Multan') 
                    ),DropdownMenuItem(
                    value: 'Karachi',
                    child:Text('Karachi') 
                    ),
                ], onChanged: (newvalue){
                  setState(() {
                    slectedValue =newvalue!;
                  });
                }
                ),
                Expanded(
                  flex: 1,
                  child: 
              Container(height: 100,width: 100,color: Colors.amber,),
              ),
              Expanded(
                flex: 2,
                child: 
              Container(height: 100,width: 100,color: Colors.brown,),
              ),
            ],
          ),
           ) ,
      ),
    );
  }
}