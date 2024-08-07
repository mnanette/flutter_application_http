// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    final List<dynamic> parsed = json.decode(response.body);
    return parsed.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<Post> fetchSinglePost(int postId) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> parsed = json.decode(response.body);
    return Post.fromJson(parsed);
  } else {
    throw Exception('Failed to load post with ID $postId');
  }
}

Future<List<Comment>> fetchCommentsForPost(int postId) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments2'));
  if (response.statusCode == 200) {
    final List<dynamic> parsed = json.decode(response.body);
    final List<Comment> allComments =
        parsed.map((json) => Comment.fromJson(json)).toList();

    // Filter comments for the specified post ID
    final filteredComments =
        allComments.where((comment) => comment.postId == postId).toList();

    return filteredComments;
  } else {
    throw Exception('Failed to load comments for post with ID $postId');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> futurePosts;
  late Future<Post> futureSinglePost;
  late Future<List<Comment>> futureComments; // New addition

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
    futureSinglePost = fetchSinglePost(1); // Fetch post with ID 1
    futureComments =
        fetchCommentsForPost(1); // Fetch comments for post with ID 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading posts'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            final posts = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20), // Add some spacing
                FutureBuilder<Post>(
                  future: futureSinglePost,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading post');
                    } else if (!snapshot.hasData) {
                      return Text('No post available');
                    } else {
                      final singlePost = snapshot.data!;
                      return Column(
                        children: [
                          Text(
                            'Single Post Title:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(singlePost.title),
                          SizedBox(height: 10),
                          Text(
                            'Single Post Body:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(singlePost.body),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 20), // Add more spacing
                FutureBuilder<List<Comment>>(
                  future: futureComments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading comments');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No comments available');
                    } else {
                      final comments = snapshot.data!;
                      return Column(
                        children: [
                          Text(
                            'Comments:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          for (var comment in comments)
                            ListTile(
                              title: Text(comment.name),
                              subtitle: Text(comment.body),
                            ),
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
