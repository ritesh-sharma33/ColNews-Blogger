import 'dart:math';

import 'package:college_news_blog/pages/blog_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class NewsCard extends StatefulWidget {

  final String title, subtitle, image, body, date;
  NewsCard({this.title, this.subtitle, this.image, this.body, this.date});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  int generateRandomNumber(int min, max) {
    Random rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  @override
  void initState() {
    
    views = generateRandomNumber(1, 1000);
    likes = generateRandomNumber(1, views);
    super.initState();
  }

  int views, likes;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 3,
      child: InkWell(
        onDoubleTap: () {
          if (!this.isLiked) {
            setState(() {
              this.likes++;
              this.isLiked = true;
            });
          } else {
            setState(() {
              this.likes--;
              this.isLiked = false;
            });
          }
        },
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => BlogDetailsPage(
                body: widget.body,
                title: widget.title,
                subtitle: widget.subtitle,
                date: widget.date,
                image: widget.image,
                likes: this.likes,
                views: this.views,
              )
            )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.image != null
              ? Stack(
                children: <Widget>[
                  Container(
                    height: deviceHeight * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.image
                        )
                      )
                    ),
                  ),
                  Container(
                    height: deviceHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.center,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.black.withOpacity(0.15)
                        ],
                        stops: [
                          0.5,
                          3.8
                        ]
                      )
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.125, left: 8.0, right: 8.0),
                          child: Html(
                            data: widget.title,
                            useRichText: true,
                            defaultTextStyle: TextStyle(
                              height: 1.25,
                              fontSize: deviceHeight * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Baloo'
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              ) : Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 15.0
                ),
                child: Html(
                  data: widget.title,
                  defaultTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceHeight * 0.023,
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 6.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Html(
                  data: widget.subtitle != null ? widget.subtitle : "No subtitle",
                  defaultTextStyle: TextStyle(
                    fontSize: deviceHeight * 0.02,
                    fontFamily: 'Baloo'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${this.views} views",
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.red
                      ),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.red
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: this.isLiked ? Icon(Icons.favorite, color: Colors.red[300],) : Icon(Icons.favorite_border),
                        onPressed: () {
                          if (!this.isLiked) {
                            setState(() {
                              this.isLiked = true;
                              this.likes++;
                            });
                          } else {
                            setState(() {
                              this.isLiked = false;
                              this.likes--;
                            });
                          }
                          
                        },
                      ),
                      Text(
                        "${this.likes} likes",
                        style: TextStyle(
                          fontFamily: 'Baloo'
                        ), 
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () {
                          showDialog(context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                elevation: 10,
                                children: <Widget>[
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text("Post Saved Successfully"),
                                        RaisedButton(
                                          elevation: 0,
                                          child: Text("OK", style: TextStyle(color: Colors.red),),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                                backgroundColor: Colors.white,
                                title: Center(
                                  child: Text('Post Saved',
                                    style: TextStyle(
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                              );
                            });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share("Hey read this news from ColNews Blogger: ${widget.title}");
                        },
                      )
                    ]
                  )
                ],
              )
            
          ],
        ),
      ),
    );
  }
}