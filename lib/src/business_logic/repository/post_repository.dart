import '../models/post.dart';
import '../services/firebase_database_provider.dart';

class PostRepository {
  final FirebaseDatabaseProvider _firebaseProvider = FirebaseDatabaseProvider();

  Future<int> createPost(Post post){
    return _firebaseProvider.createPost(post);
  }

  Future<List<Post>> readPostList(){
    return _firebaseProvider.readPostList();
  }
}
