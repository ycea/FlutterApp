part of '../../presentation/home_page/home_page.dart';

class _Card extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallBack? onLike;
  final String? description;
  final VoidCallback? onTap;
  final bool isLiked;
  final String? id;
  const _Card(
    this.name, {
    this.description,
    this.icon = Icons.ac_unit_outlined,
    this.imageUrl,
    this.onLike,
    this.onTap,
    this.id,
    this.isLiked = false,
  });
  factory _Card.fromData(
    CardData data, {
    OnLikeCallBack? onLike,
    VoidCallback? onTap,
    bool isLiked = false,
  }) => _Card(
    data.name,
    icon: data.icon,
    imageUrl: data.imageUrl,
    onLike: onLike,
    description: data.description,
    onTap: onTap,
    isLiked: isLiked,
    id: data.id,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 16, bottom: 10, left: 1, right: 1),
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 6,
            ),
          ],
        ),

        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          onLike?.call(id, name, isLiked);
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8, right: 8),
                            child: isLiked
                                ? const Icon(
                                    Icons.favorite,

                                    color: Colors.redAccent,
                                    size: 40,
                                    key: ValueKey<int>(0),
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 40,
                                    key: ValueKey<int>(0),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.network(
                          imageUrl ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Placeholder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
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
