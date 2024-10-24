import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:Mohamad_Alzoubi_personal_website/views/widgets/animated_footer.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/custom_spacer.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/page_wrapper.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/widgets/page_header.dart';

class BlogsScreen extends StatefulWidget {
  static const String BlogsScreenRoute = StringConst.BLOGS_PAGE;

  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen>
    with TickerProviderStateMixin {
  late AnimationController _headingTextController;

  @override
  void initState() {
    super.initState();
    _headingTextController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _headingTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: Colors.grey[200],
      selectedRoute: BlogsScreen.BlogsScreenRoute,
      selectedPageName: StringConst.BLOGS,
      navBarAnimationController: _headingTextController,
      hasSideTitle: false,
      onLoadingAnimationDone: () {
        _headingTextController.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          PageHeader(
            headingText: StringConst.BLOGS,
            headingTextController: _headingTextController,
          ),
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BlogPostData.blogPosts.length,
                itemBuilder: (context, index) {
                  final post = BlogPostData.blogPosts[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: sizingInformation.isMobile ? 8.0 : 20,
                        horizontal: sizingInformation.isMobile ? 8.0 : 22.0),
                    padding: EdgeInsets.symmetric(
                        vertical: sizingInformation.isMobile ? 8.0 : 20,
                        horizontal: sizingInformation.isMobile ? 8.0 : 242.0),
                    child: BlogPostItem(
                      title: post.content,
                      image: post.image,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogDetailScreen(post: post),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          const CustomSpacer(heightFactor: 0.1),
          const AnimatedFooter(),
        ],
      ),
    );
  }
}

class BlogPostItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const BlogPostItem({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      '12/9/2002', // You can change this text or make it dynamic
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogPostData {
  static final List<BlogPostData> blogPosts = [
    BlogPostData(
      content: "لماذا عليك مشاهدة مسلسل فريندز ؟",
      image: "assets/images/friends.jpg",
    ),
    BlogPostData(
      content: '''
  ا10 اسباب لعدم استخدام فلاتر لتطوير موقع ويب ليس عليك قرائتها 
''',
      image: "assets/images/flutterpost.png",
    ),
  ];

  final String content;

  final String image;

  BlogPostData({
    required this.content,
    required this.image,
  });
}

class BlogDetailScreen extends StatelessWidget {
  final BlogPostData post;

  const BlogDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    post.image,
                    fit: BoxFit.contain,
                    height: 800, // Ensures the image fits nicely
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  post.content,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
