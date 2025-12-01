import 'package:flutter/material.dart';
import 'package:swift_flutter/swift_flutter.dart';
import 'libraries_page.dart';

class AnimatedFloatingButton extends StatelessWidget {
  const AnimatedFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LibrariesPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF007ACC),
             borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text("View other products ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF007ACC),
                          Color(0xFF0098FF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF007ACC).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.library_books,
                      color: Colors.white,
                      size: 28,
                    ),
                  )

                ],
              )
            ),
          ) .animate()
              .scale(1.2)
              .pulse()
              .duration(2000.ms)
              .delay(300.ms)
              .repeat(reverse: true)
              .persist(),
        ),
      ),
    );
  }
}

