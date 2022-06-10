import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/resources/resources.dart';
import 'package:movie/theme/app_colors.dart';
import 'package:movie/widgets/elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _TopPosterWidget(),
          _MovieNameWidget(),
          _RatingWidget(),
          _GenreInfoWidget(),
          _DescriptionWidget(),
          _TeamInfoWidget(),

        ],
      ),
    );
  }
}



class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(AppImages.backgroundPoster),
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(image: AssetImage(AppImages.mainPoster)),
        ),
      ],
    );
  }
}



class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(children: [
          TextSpan(
              text: 'The Passion of the Christ ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              )
          ),
          TextSpan(
              text: '(2004) ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              )
          ),
        ]
        ),
      ),
    );
  }
}



class _RatingWidget extends StatelessWidget {
  const _RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: AppColors.mainWhite, // This is a custom color variable
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: RadialPercentWidget(
                      child:
                      Text('74'),
                      percent: 0.74,
                      fillColor: AppColors.mainFillColor,
                      lineColor: AppColors.mainLineColor,
                      freeColor: AppColors.mainFreeColor,
                      lineWidth: 3
                  ),
                ),
                SizedBox(width: 15,),
                Text('User score'),
              ],
            )
        ),
        Container(
          height: 15,
          width: 1,
          color: Colors.grey,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.play_arrow),
          label: Text('Play trailer'),
          style: TextButton.styleFrom(
            primary: AppColors.mainWhite, // This is a custom color variable
          ),
        ),
      ],
    );
  }
}



class _GenreInfoWidget extends StatelessWidget {
  const _GenreInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ColoredBox(
        color: AppColors.mainDarkBrown,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
          child: Text(
            'R, 02/25/2004 (US) Drama 2h 7m',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.mainWhite,
              fontSize: 16,
          ),
          ),
        ),
      ),
    );
  }
}



class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            child: Text(
              'Overview',
              style: TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          Text(
            'A graphic portrayal of the last twelve hours '
                'of Jesus of Nazareths life.',
            style: TextStyle(
                color: AppColors.mainWhite,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}



class _TeamInfoWidget extends StatelessWidget {
  const _TeamInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameStyle = TextStyle(
      color: AppColors.mainWhite,
      fontSize: 16,
      fontWeight: FontWeight.w400
    );

    final jobTitleStyle = TextStyle(
      color: AppColors.mainWhite,
      fontSize: 16,
      fontWeight: FontWeight.w400
    );


    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mel Gibson', style: nameStyle,),
                    Text('Director', style: jobTitleStyle)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Benedict Flitzgerald', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Hohns', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Liza John', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


