import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String hours;
  final String? imageUrl;

  const GameCard({
    Key? key,
    required this.title,
    required this.hours,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bounded = constraints.hasBoundedHeight;

        Widget image = Container(
          height: bounded ? null : 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2A2A2A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Center(
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : const Icon(Icons.videogame_asset, size: 64, color: Colors.white54),
          ),
        );

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: bounded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              bounded ? Expanded(child: image) : image,
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(hours,
                      style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}