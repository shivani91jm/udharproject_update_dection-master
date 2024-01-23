import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udharproject/Activity/HomeItemProfilePage.dart';
import 'package:udharproject/Api/AllAPIBooking.dart';
import 'package:udharproject/Widget/RatingBarWidget.dart';
import 'package:udharproject/Widget/SearchWidget.dart';
import 'package:udharproject/model/Book.dart';
import 'package:udharproject/model/SocialMediaLogin/GetStaffUser.dart';
import 'package:udharproject/model/SocialMediaLogin/SocialInfo.dart';

class BookCollectionsScreen extends StatefulWidget {
  @override
  _BookCollectionsScreenState createState() => _BookCollectionsScreenState();
}

class _BookCollectionsScreenState extends State<BookCollectionsScreen> {

  double rating = 3.5;
  List<Book> books = [];


  String query = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    init();
  }
  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }
  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);
    print("printdata"+books.toString());
    setState(() => this.books = books);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: Column(
            children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildSearch(),
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0,10,10,30),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                // final item=itemssss[index];
                if (books.length == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepOrangeAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  );
                } else {
                  return  buildBook(book);
                }
                return buildBook(book);
              },
            ),
          ),)
        ]
      ));
  }
  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Search......',
    onChanged: searchBook,
  );

  Future searchBook(String query) async => debounce(() async {
    final books = await BooksApi.getBooks(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.books = books;
    });
  });
  Widget buildBook(Book book) => Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(2.0,10,2.0,10),
      child: ListTile(
         onTap: ()  {

          var url = book.urlImage;
          var username=book.author;
          var amount= "20000";
          var rating="4.5";
          var status="panding";
          var  email="testing@gmail.com";
           Navigator.push(context, MaterialPageRoute(builder: (context) =>   HomeItemProfilePage(url,username,rating,amount,email,status)),);
         },
        leading: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(book.urlImage),
            ),
          ],
        ),
        title: Text(book.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rs.2000",style: TextStyle(
                color:  Colors.black54,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),),
            Text("Panding",style: TextStyle(
                color:  Colors.black54,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),),
            new StarRating(
              rating: rating,
              onRatingChanged: (rating) => setState(() => this.rating = rating),
            ),
          ],
        ),
        trailing: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded,
          color:   Color.fromRGBO(143, 148, 251, 1),size: 20,),
          onPressed: (){},),
      ),
    ),
  );
}


