import 'package:flutter/material.dart';

class BeritaCard extends StatelessWidget {
  const BeritaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("assets/images/berita.png"),
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "12/12/2021",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.remove_red_eye_outlined,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "60",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. dsfsdfs fdsf sd fsd fsdfsdf sdf sdf sf sfds",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
