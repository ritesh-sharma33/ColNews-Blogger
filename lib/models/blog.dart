
class Blog {
  final String blogTitle;
  final String blogSubtitle;
  final String blogImage;
  final String blogBody;
  final String date;

  Blog({this.blogTitle, this.blogSubtitle, this.blogImage, this.blogBody, this.date});

  static toMap(Blog blog) {
    return {
      'title': blog.blogTitle,
      'subtitle': blog.blogSubtitle,
      'body': blog.blogBody,
      'image': blog.blogImage,
      'date': blog.date,
    };
  }
}