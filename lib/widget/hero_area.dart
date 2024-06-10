import 'package:flutter/material.dart';

class HeroArea extends StatelessWidget {
  const HeroArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 346,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/edirne.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.4),
                hintText: "Arama Çubuğu",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(10, 10),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.transparent),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(0.8),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
