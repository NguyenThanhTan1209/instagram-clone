import 'post.dart';
import 'story.dart';
import 'story_album.dart';

class UserModel {
  UserModel({
    required this.userID,
    required this.userName,
    required this.name,
    this.gender = '',
    this.phone = '',
    this.email = '',
    this.bio = '',
    this.password = '',
    this.avatarPath =
        'https://i.pinimg.com/originals/a0/4d/84/a04d849cf591c2f980548b982f461401.jpg',
    this.postTotal = 0,
    this.followerTotal = 0,
    this.followingTotal = 0,
    this.description = '',
    this.website = '',
    this.posts = const <Post>[],
    this.storieAlbums = const <StoryAlbum>[],
  });

  factory UserModel.mockData() {
    return UserModel(
      userID: '737669',
      userName: 'tan_newc',
      password: '123456@#',
      avatarPath:
          'https://m.media-amazon.com/images/I/416fIkTPKxL._AC_UF894,1000_QL80_.jpg',
      name: 'Fernando Torres',
      postTotal: 10,
      followerTotal: 110,
      followingTotal: 7500,
      description: "I'm a football-player",
      website: 'www.f9.com',
      posts: <Post>[
        Post(
          postID: 1,
          imagesPath: <String>[
            'https://assets.goal.com/images/v3/blt499de6acdb7a3190/GettyImages-91244344_(1).jpg?auto=webp&format=pjpg&width=3840&quality=60',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 2,
          imagesPath: <String>[
            'https://i.guim.co.uk/img/static/sys-images/Football/Pix/pictures/2010/4/19/1271677240699/Fernando-Torres-001.jpg?width=465&dpr=1&s=none',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 3,
          imagesPath: <String>[
            'https://phantom-marca.unidadeditorial.es/2b1ea63dea3177c0ddef3cba979f48a0/resize/640/assets/multimedia/imagenes/2023/01/27/16748493781389.jpg',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 4,
          imagesPath: <String>[
            'https://i2-prod.liverpoolecho.co.uk/incoming/article25684030.ece/ALTERNATES/s1227b/0_GettyImages-2530851.jpg',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 5,
          imagesPath: <String>[
            'https://media.baobinhphuoc.com.vn/upload/news/2_2024/liverpool_vo_dich_cup_lien_doan_anh_sau_120_phut_cang_thang_09433426022024.jpg',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 6,
          imagesPath: <String>[
            'https://upload.wikimedia.org/wikipedia/commons/c/c3/Fernando_Torres_DEP-ATM_024_1200.jpg',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 7,
          imagesPath: <String>[
            'https://cdn.24h.com.vn/upload/2-2024/images/2024-04-23/fernandotorres-495-1713847193-119-width740height495.jpg',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 8,
          imagesPath: <String>[
            'https://image.sggp.org.vn/w1000/Uploaded/2024/kvovhun/2018_03_21/fernandotorres02_HFHR.jpg.webp',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
        Post(
          postID: 9,
          imagesPath: <String>[
            'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
          ],
          description: 'Love Football',
          location: 'Liverpool',
        ),
      ],
      storieAlbums: <StoryAlbum>[
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
        StoryAlbum(
          userID: 1,
          albumName: 'Fun',
          stories: <Story>[
            Story(
              storyID: 1,
              storyImagePath:
                  'https://upload.wikimedia.org/wikipedia/commons/f/f4/Fernando_Torres_271809.JPG',
              description: 'Hi',
            ),
          ],
        ),
      ],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'] as String,
      userName: json['userName'] as String,
      name: json['name'] as String,
      website: json['website'] as String,
      bio: json['bio'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userID': userID,
        'userName': userName,
        'name': name,
        'website': website,
        'bio': bio,
        'email': email,
        'phone': phone,
        'gender': gender,
      };

  final String userID;
  final String userName;
  final String password;
  final String avatarPath;
  final String name;
  final int postTotal;
  final int followerTotal;
  final int followingTotal;
  final String description;
  final String website;
  final String bio;
  final String email;
  final String phone;
  final String gender;
  final List<Post> posts;
  final List<StoryAlbum> storieAlbums;
}
