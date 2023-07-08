import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helper/theme.dart';

class FeedsWidget extends StatelessWidget {
  const FeedsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    Widget feeds() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            // HEADER
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icon_profile_default.png', width: 31, height: 31,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Amir Khan", style: primaryTextStylePlusJakartaSans.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15
                        ),),
                        SizedBox(width: 6,),
                        ClipOval(
                          child: Container(
                            width: 2,
                            height: 2,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 6,),
                        Text("2 days ago", style: primaryTextStylePlusJakartaSans.copyWith(
                            fontSize: 12
                        ),),
                      ],
                    ),
                    Text("Bali Pagoda, Bali, Indonesia", style: primaryTextStylePlusJakartaSans.copyWith(
                        fontSize: 12
                    ),),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_outline, size: 35, color: Colors.black54,)
                )
              ],
            ),
            // CONTENT
            const SizedBox(height: 8,),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/feeds_example.png',
                height: 212,
                width: 345,
                fit: BoxFit.cover,
              ),
            ),
            // FOOTER
            const SizedBox(height: 8,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 7, right: 5),
                  child: GestureDetector(
                    onTap: (){},
                    child: SvgPicture.asset('assets/icon_love.svg'),
                  ),
                ),
                Text("450 Likes", style: primaryTextStylePlusJakartaSans.copyWith(
                    fontSize: 14, fontWeight: FontWeight.bold
                ),),
              ],
            ),
            const SizedBox(height: 8,),
            Container(
                margin: EdgeInsets.only(left: 7, right: 7),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Amir Khan',
                        style: primaryTextStylePlusJakartaSans.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' The View Sunrise of Bali Pagoda, happy to be here.',
                        style: primaryTextStylePlusJakartaSans.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                )
            ),
          ],
        ),
      );
    }

    return feeds();
  }
}
