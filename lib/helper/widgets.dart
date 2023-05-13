import 'package:finalauth_news/views/article_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/signin_screen.dart';



PreferredSizeWidget MyAppBar(BuildContext context){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text("MobileFirst", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        Text("News", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600))
      ],
    ),
    actions: [
      IconButton(onPressed: () async {
        final SharedPreferences prefs =
            await SharedPreferences.getInstance();
        prefs.clear();
        FirebaseAuth.instance.signOut().then((value){
          print('Signed Out');
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> SignInScreen()));
        });
      }, icon: Icon(Icons.logout,color: Colors.black,) )
    ],
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  const NewsTile({required this.imgUrl, required this.desc, required this.title, required this.content, required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(postUrl: posturl))),
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    imgUrl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
              ),
              SizedBox(height: 12,),
              Text(title, maxLines: 2, style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: 4,),
              Text(desc, maxLines: 2, style: TextStyle(color: Colors.black54, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}