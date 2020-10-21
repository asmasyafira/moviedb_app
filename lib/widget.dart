import 'package:flutter/material.dart';
import 'package:http/http.dart';

String posterUrl = 'https://image.tmdb.org/t/p/w500';

class BackdropImage extends StatelessWidget {
  final String imageUrl;

  BackdropImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return ClipPath(
      // clipper: BackdropClipper(),
      child: Image.network(posterUrl + imageUrl,
          width: widthScreen, height: heightScreen * 0.25, fit: BoxFit.fill),
    );
  }
}

class BackdropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    //first position
    var firstOffset = Offset(size.width / 4, size.height);
    var secondOffSet = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        firstOffset.dx, firstOffset.dy, secondOffSet.dx, secondOffSet.dy);

    //second position
    var firstPoint = Offset(size.width - (size.width/4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(firstPoint.dx, firstPoint.dy, secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
