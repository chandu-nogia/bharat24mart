
// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:project/all_imports.dart';

Widget buildImage({network, text, textRs, canRs}) {
  return Padding(
    padding: EdgeInsets.all(6.w),
    child: Container(
      decoration: BoxDecoration(
          color: AppColorBody.white,
          borderRadius: BorderRadius.circular(7.r),
          boxShadow: [
            BoxShadow(
                color: const Color(0x30DC2E45),
                spreadRadius: 0.w,
                blurRadius: 5.w,
                offset: Offset(2.w, 2.w))
          ]),
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, top: 8.w, right: 7.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //     child: SizedBox(
              //   height: 47.w,
              //   child: Image.network(
              //     network,
              //     fit: BoxFit.fill,
              // ),
              // )
              // Image(
              //   height: 47.h,
              //   image: NetworkImage(network, scale: 1.0),
              //   errorBuilder: (BuildContext context, Object exception,
              //       StackTrace? stackTrace) {
              //     return const Text('😢');
              //   },
              //   loadingBuilder: (context, child, loadingProgress) =>
              //       loaderCircular(),
              //   fit: BoxFit.cover,
              // ),
              // ),
              Center(
                child: CachedNetworkImage(
                  height: 47.h,
                  imageUrl: network,
                  placeholder: (context, url) => const SizedBox(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),

              SizedBox(height: 4.h),
              Divider(thickness: 1.h, color: AppColorBody.grey),
              SizedBox(height: 8.h),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.w,
                      color: AppColorText.black,
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                "\u{20B9} $textRs",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.w,
                    color: AppColorText.black,
                    fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "\u{20B9} $canRs",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2.w,
                  decorationColor: AppColorBody.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.w,
                  color: AppColorText.blueGrey,
                  fontFamily: "Roboto",
                ),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    ),
  );
}
