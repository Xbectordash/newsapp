import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data/model/news_response_model.dart';
import 'package:newsapp/helperFunctions/created_ago_helperFunction.dart';
import 'package:newsapp/presentation/screens/news_detail_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardWidget extends StatelessWidget {
  final Article data;

  /// A widget that displays a news article preview card with an image, title, author, and published time.
  ///
  /// This widget shows a clickable card containing:
  /// - A hero-animated image thumbnail (using cached network image with placeholder and error handling).
  /// - The article title, truncated after two lines.
  /// - A row displaying the article author and how long ago it was published.
  ///
  /// When tapped, the card navigates to the [NewsDetail] screen, passing the article data.
  ///
  /// The widget uses the `CreatedAgo` helper to show relative published time (e.g., "2 hours ago").
  ///
  /// The image uses a default fallback URL if the article image URL is null or unavailable.
  ///
  /// Example usage:
  /// ```dart
  /// CardWidget(
  ///   data: someArticleInstance,
  /// );
  /// ```
  ///
  /// Dependencies:
  /// - `cached_network_image` for network image caching and placeholder handling.
  /// - `skeletonizer` for shimmer effect placeholder while the image loads.
  /// - `CreatedAgo` helper class for relative time display.
  /// - `NewsDetail` screen for detailed article view navigation.
  ///
  /// Note:
  /// Ensure that the `data` passed contains non-null `title` for proper hero animations.
  ///
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
      child: Card.outlined(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Hero(
                  tag: data.title.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: data.urlToImage ?? defimgurl,
                      placeholder: (context, url) => Skeletonizer(
                        enabled: true,
                        child: Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      placeholderFadeInDuration: Duration(seconds: 2),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      height: screenWidth * 0.2,
                      width: screenWidth * 0.2,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18),
              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title ??
                          "अहमदाबाद में आज टॉस बनेगा बॉस..? एक पारी में 200+ के स्कोर का चांस...",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.author.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          CreatedAgo().timeAgo(data.publishedAt),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
