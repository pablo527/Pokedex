import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:poke_app/pages/pokemonDetail_page.dart';
import 'dart:convert';
import 'package:poke_app/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Pokehub pokehub;

  var url = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  @override
  void initState() {
    
    super.initState();
    fetchData();
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeDex'),
        backgroundColor: Colors.black,
      ),
      body: pokehub == null ? Center( child: CircularProgressIndicator()) 
      : GridView.count(
        crossAxisCount: 2,
        children: pokehub.pokemon.map((poke) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(

            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    pokemon: poke,
                  ),
                )
                );
            },


             child: Hero(
               tag: poke.img,
               child: Card(
                elevation: 3.0,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img)
                          )
                      ),
                    ),
                    Text(
                      poke.name,
                      style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      
                    )
                  ],
                ),
            ),
             ),
          ),
        )).toList()
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.black,
        onPressed: (){

        }
        ),
    );
    
  }



  fetchData() async{
    var res = await http.get(url);
    var decodeJson = jsonDecode(res.body);
    pokehub = Pokehub.fromJson(decodeJson);
    setState(() {
      
    });
  }
}