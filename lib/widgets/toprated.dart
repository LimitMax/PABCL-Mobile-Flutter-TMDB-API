import 'package:flutter/material.dart';
import 'package:huraa/deskripsi.dart';
import 'package:huraa/utils/text.dart';

class TopRated extends StatelessWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
              text: 'Top Rate Movies', size: 26, color: Colors.white),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                itemCount: toprated.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Deskripsi(
                            name: toprated[index]['title'],
                            bannerurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['backdrop_path'],
                            posterurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                            deskripsi: toprated[index]['overview'],
                            vote: toprated[index]['vote_average'].toString(),
                            launch_on: toprated[index]['release_date'])));
                    },
                    child: toprated[index]['title']!=null? Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            toprated[index]['poster_path']))),
                          ),
                          Container(
                            child: modified_text(
                                text: toprated[index]['title'] != null
                                    ? toprated[index]['title']
                                    : 'Loading',
                                color: Colors.white,
                                size: 16),
                          )
                        ],
                      ),
                    ):Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
