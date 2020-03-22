import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_news_blog/pages/widget_testing_page.dart';
import 'package:college_news_blog/widgets/news_card.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import './post_blog/blog_post_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 15,),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                    SizedBox(width: 10,),
                    Text("ColNews Blogger", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      fontFamily: 'Baloo'
                    ),),
                    Spacer(),
                    Icon(Icons.search),
                    SizedBox(width: 14,),
                    Icon(Icons.notifications_active),
                    SizedBox(width: 5,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 8, right: 8),
                child: Text("Trending", style: TextStyle(fontFamily: 'Baloo', fontWeight: FontWeight.bold, fontSize: 25),),
              ),
              NewsCard(
                title: "Students suffering from fever, cold and cough due to heavy rain and change in weather",
                image: "https://static.toiimg.com/photo/72995118.cms",
                body: "A sudden rainfall and change in weather in the night has caused the cold, fever and coughing to many students in the college. The college administration is willing to take strong action in this concern. This will continue if the students will not take care of themselves, said the hostel warden of KP-6. Many students are advised to get admitted in the hospital nearby to avoid the worst circumstances. ",
                subtitle: "This is the effect of corona and this will continue if not taken care.",
                date: "16-March-2020",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text("News Feed", style: TextStyle(fontFamily: 'Baloo', fontWeight: FontWeight.bold, fontSize: 25),),
              ),
              StreamBuilder(
                stream: Firestore
                  .instance
                  .collection('blog_posts')
                  .orderBy('date', descending: true)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int i) {
                        return NewsCard(
                          title: snapshot.data.documents[i]['blog_title'],
                          subtitle: snapshot.data.documents[i]['blog_subtitle'],
                          image: snapshot.data.documents[i]['blog_image'],
                          body: snapshot.data.documents[i]['blog_body'],
                          date: snapshot.data.documents[i]['date'],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.red,),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/1.png')
                )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      "John Doe",
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            ListTile(
              leading: Icon(Icons.perm_identity, color: Colors.red[300],),
              title: Text('My Profile'),
            ),
            ListTile(
              leading: Icon(Icons.brightness_4, color: Colors.red[300],),
              title: Theme.of(context).brightness == Brightness.light ?  Text("Enable Dark Theme") : Text("Enable Light Theme"),
              onTap: () {
                _changeBrightness();
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark, color: Colors.red[300],),
              title: Text('Saved News'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Demo page'),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => WidgetTestingPage()
                  )
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red[300],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPostPage()
            )
          );
        }, 
        label: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(width: 5,),
            Text('Post a blog')
          ],
        )
      ),
    );
  }
}