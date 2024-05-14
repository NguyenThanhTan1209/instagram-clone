import 'post.dart';
import 'story.dart';
import 'story_album.dart';

class User {

  User({
    required this.userID,
    required this.userName,
    required this.password,
    required this.avatarPath,
    required this.name,
    required this.postTotal,
    required this.followerTotal,
    required this.followingTotal,
    required this.description,
    required this.website,
    required this.posts,
    required this.storieAlbums,
  });

  factory User.mockData() {
    return User(
      userID: 737669,
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

  final int userID;
  final String userName;
  final String password;
  final String avatarPath;
  final String name;
  final int postTotal;
  final int followerTotal;
  final int followingTotal;
  final String description;
  final String website;
  final List<Post> posts;
  final List<StoryAlbum> storieAlbums;
}
