import 'package:flutter_test_app/data/repositories/api_interface.dart';
import 'package:flutter_test_app/domain/models/home.dart';

import '../../domain/models/card.dart';

class MockRepository extends ApiInterface {
  @override
  Future<HomeData?> loadData({OnErrorCallback? onError}) async {
    return HomeData(
      data: [
        CardData(
          "Атака титанов",
          description:
              "Сюжет разворачивается в мире, где остатки человечества живут за огромными стенами, спасаясь от титанов — гигантов, пожирающих людей. Главный герой, Эрен Йегер, вместе с друзьями Микасой и Армином вступает в Разведкорпус, чтобы сразиться с титанами и выяснить их тайну.",
          imageUrl:
              "https://static.wikia.nocookie.net/shingekinokyojin/images/d/d4/SnK_-_Manga_Volume_1.png/revision/latest/scale-to-width-down/1000?cb=20210116221213&path-prefix=ru",
        ),
        CardData(
          "Фрирен: провожающая в последний путь",
          description:
              "История рассказывает о эльфийке Фрирен, маге, которая входила в отряд героев, победивших Короля демонов. В отличие от людей, её жизнь почти бесконечна, и потому она воспринимала десятилетие приключений с товарищами как «короткий миг».",
          imageUrl:
              "https://static.wikia.nocookie.net/frieren/images/0/0e/Volume_2_ENG.png/revision/latest?cb=20241218020401&path-prefix=ru",
        ),
        CardData(
          "Берсерк",
          description:
              "«Берсерк» — тёмное фэнтези-эпопея, одна из самых культовых и узнаваемых манг в мире. Главный герой — Гатс (Guts), наёмник с трагическим прошлым. Он сражается огромным мечом, преодолевая нечеловеческие испытания. Сюжет исследует темы судьбы, борьбы с внутренними и внешними демонами, дружбы и предательства.",
          imageUrl:
              "https://static.wikia.nocookie.net/berserk/images/d/de/V1-Cover-Manga.jpg/revision/latest?cb=20210211210752&path-prefix=ru",
        ),
      ],
    );
  }
}
