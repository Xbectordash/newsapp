import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data/model/news_response_model.dart';
import 'package:newsapp/helperfunctions/created_ago_helperfunction.dart';
import 'package:newsapp/presentation/screens/news_detail_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardWidget extends StatelessWidget {
  final Article data;
  const CardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String defimgurl =
        "https://img.etimg.com/thumb/msid-121588947,width-1200,height-630,imgsize-1983411,overlay-economictimes/articleshow.jpg";
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsDetail(data: data)),
        );
      },
      child: SizedBox(
        height: screenHeight * 0.12,
        child: Card.outlined(
          elevation: 1,
          semanticContainer: true,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Hero(
                  tag: data.title.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: data.urlToImage ?? defimgurl,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: Container(
                            height: screenHeight * 0.08,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        placeholderFadeInDuration: Duration(seconds: 2),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,

                      child: Text(
                        data.title ??
                            "अहमदाबाद में आज टॉस बनेगा बॉस..? एक पारी में 200+ के स्कोर का चांस... प‍िच करेगी 'खेला', पंजाब-RCB में किसका रिकॉर्ड बेहतर",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.28,
                            child: Text(
                              data.author.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.28,
                            child: Text(
                              CreatedAgo().timeAgo(data.publishedAt),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
