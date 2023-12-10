import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget{
 const CategoryPage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 20, mainAxisSpacing: 20, ) ,
        children: const [
          Column(
            children: [
              Text("1", style:  TextStyle(color: Colors.white),),
              Text("1", style:  TextStyle(color: Colors.white),),
              Text("1", style:  TextStyle(color: Colors.white),),
              Text("1", style:  TextStyle(color: Colors.white),),
              Text("1", style:  TextStyle(color: Colors.white),),

            ],
          )
        ],
      ),
    );
  }

}