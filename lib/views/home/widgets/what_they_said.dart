import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class WhatTheySaidSection extends StatefulWidget {
  const WhatTheySaidSection({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color backgroundColor;

  @override
  _WhatTheySaidSectionState createState() => _WhatTheySaidSectionState();
}

class _WhatTheySaidSectionState extends State<WhatTheySaidSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 600) {
      return const WhatTheySaidWeb();
    } else {
      return const WhatTheySaidMobile();
    }
  }
}

class WhatTheySaidWeb extends StatefulWidget {
  const WhatTheySaidWeb({Key? key}) : super(key: key);

  @override
  _WhatTheySaidWebState createState() => _WhatTheySaidWebState();
}

class _WhatTheySaidWebState extends State<WhatTheySaidWeb> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 150),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: Text(
              'That\'s what they said :',
              style: textTheme.displaySmall?.copyWith(
                fontSize: 23,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                aspectRatio: 19 / 4,
                enlargeCenterPage: true,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemCount: SaidAboutMohamad.data.length,
              itemBuilder: (context, index, realIndex) {
                final testimonial = SaidAboutMohamad.data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Testimonial Content
                          Expanded(
                            child: Text(
                              testimonial.content,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(testimonial.photo),
                                radius: 30,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testimonial.name,
                                    style: textTheme.titleLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    testimonial.jobPos,
                                    style: textTheme.titleMedium?.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: SaidAboutMohamad.data.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = entry.key;
                }),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class WhatTheySaidMobile extends StatefulWidget {
  const WhatTheySaidMobile({Key? key}) : super(key: key);

  @override
  _WhatTheySaidMobileState createState() => _WhatTheySaidMobileState();
}

class _WhatTheySaidMobileState extends State<WhatTheySaidMobile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: screenHeight * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What They Said:',
            style: textTheme.headlineSmall?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                height: screenHeight * 0.35,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemCount: SaidAboutMohamad.data.length,
              itemBuilder: (context, index, realIndex) {
                final testimonial = SaidAboutMohamad.data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Testimonial Content
                          Expanded(
                            child: Text(
                              testimonial.content,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Author Details
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(testimonial.photo),
                                radius: 20, // Fixed radius
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testimonial.name,
                                    style: textTheme.titleLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    testimonial.jobPos,
                                    style: textTheme.titleSmall?.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: SaidAboutMohamad.data.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = entry.key;
                }),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SaidAboutMohamad {
  final String name;
  final String photo;
  final String jobPos;
  final String content;

  SaidAboutMohamad(this.name, this.photo, this.jobPos, this.content);

  static final List<SaidAboutMohamad> data = [
    SaidAboutMohamad(
      "Michael-Scott",
      "assets/images/Michael-Scott.webp",
      "regional manager of the Dunder Mifflin Scranton branch",
      "Mohamad’s professionalism and coding expertise helped our team meet tight deadlines with an app that exceeded our expectations. His ability to transform design concepts into a fully functioning app was remarkable. He also provided great insights on how to enhance user experience, which has been pivotal in increasing our app's reach and user satisfaction.",
    ),
    SaidAboutMohamad(
      "Moayad J Alrstom",
      "assets/images/client3.png",
      "Owner of a Startup",
      "Mohamad’s professionalism and coding expertise helped our team meet tight deadlines with an app that exceeded our expectations. His ability to transform design concepts into a fully functioning app was remarkable. He also provided great insights on how to enhance user experience, which has been pivotal in increasing our app's reach and user satisfaction.",
    ),
    SaidAboutMohamad(
      "Philip G Abd",
      "assets/images/client1.jpg",
      "Software Engineer",
      "Mohamad’s professionalism and coding expertise helped our team meet tight deadlines with an app that exceeded our expectations. His ability to transform design concepts into a fully functioning app was remarkable. He also provided great insights on how to enhance user experience, which has been pivotal in increasing our app's reach and user satisfaction.",
    ),
    SaidAboutMohamad(
      "Alaa Alzoubi",
      "assets/images/client2.png",
      "Senior Software Engineer",
      "Mohamad’s professionalism and coding expertise helped our team meet tight deadlines with an app that exceeded our expectations. His ability to transform design concepts into a fully functioning app was remarkable. He also provided great insights on how to enhance user experience, which has been pivotal in increasing our app's reach and user satisfaction.",
    ),
  ];
}
