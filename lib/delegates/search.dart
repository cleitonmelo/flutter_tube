import 'package:flutter/material.dart';
import 'package:flutter_tube/services/api.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((value) => close(context,query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isNotEmpty){
      return FutureBuilder<List>(
        future: Api().suggestions(query),
        builder: (context, snapshot){
          print(snapshot.hasData);
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data[index]),
                leading: Icon(Icons.play_arrow),
                onTap: (){
                  close(context, snapshot.data[index]);
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        },
      );
    }
    return Container();
  }

}
