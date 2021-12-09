import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

class TileMap extends FlameGame with TapDetector {
  final topLeft = Vector2(200, 300);
  static const scale = 2;
  static const srcTileSize = 32.0;

  static const destTileSize = scale * srcTileSize;
  static const halfSize = true;
  static const tileHeight = scale * (halfSize ? 8.0 : 16.0);

  static const suffix = halfSize ? '-short' : '';
  final originColor = Paint()..color = const Color(0xFFFF00FF);

  final originColor2 = Paint()..color = const Color(0xFFAA55FF);
  late IsometricTileMapComponent base;

  late Selector selector;

  late SpriteComponent player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final tilesetImage = await images.load('tile_maps/tiles$suffix.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );
    final matrix = [
      [3, 1, 1, 1, 0, 0],
      [2, 1, 2, 1, 0, 0],
      [-1, 0, 1, 1, 0, 0],
      [-1, 1, 1, 1, 0, 0],
      [1, 1, 1, 1, 0, 2],
      [1, 3, 3, 3, 0, 2],
    ];
    await add(
      base = IsometricTileMapComponent(
        tileset,
        matrix,
        destTileSize: Vector2.all(destTileSize),
        tileHeight: tileHeight,
        position: topLeft,
      ),
    );

    final selectorImage = await images.load('tile_maps/selector$suffix.png');
    await add(selector = Selector(destTileSize, selectorImage));

    final sprite = await Sprite.load('sprites/hero.png');
    final size = Vector2.all(srcTileSize);
    player = SpriteComponent(size: size, sprite: sprite);

    // print(base.containsBlock(const Block(0, 0)));
    // print(base.blockValue(const Block(0, 0)));
    // print(base.blockValue(const Block(0, 1)));
    // print(base.blockValue(const Block(0, 2)));
    // selector.show = base.containsBlock(block);
    // selector.position.setFrom(topLeft + base.getBlockRenderPosition(block));
    player.position = getHeroVector2FromBlock(const Block(0, 0));

    await add(player);
  }

  Vector2 getVector2FromBlock(Block block) =>
      topLeft + base.getBlockRenderPosition(block);

  Vector2 getHeroVector2FromBlock(Block block) =>
      topLeft +
      base.getBlockRenderPosition(block) +
      Vector2(srcTileSize / 2, 0);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas
      ..renderPoint(topLeft, size: 5, paint: originColor)
      ..renderPoint(
        topLeft.clone()..y -= tileHeight,
        size: 5,
        paint: originColor2,
      );
  }

  @override
  void onTapDown(TapDownInfo info) {
    moveSelector(info.eventPosition.game);
  }

  void moveSelector(Vector2 screenPosition) {
    final block = base.getBlock(screenPosition);

    final contains = base.containsBlock(block);

    selector
      ..show = contains
      ..position = getVector2FromBlock(block);

    if (contains) {
      player.position = getHeroVector2FromBlock(block);
    }
  }
}

class Selector extends SpriteComponent {
  Selector(double s, Image image)
      : super(
          sprite: Sprite(
            image,
            srcSize: Vector2.all(TileMap.srcTileSize),
          ),
          size: Vector2.all(s),
        );

  bool show = false;

  @override
  void render(Canvas canvas) {
    if (!show) {
      return;
    }

    super.render(canvas);
  }
}

class MyGameWidget extends GameWidget {
  MyGameWidget() : super(game: TileMap());
}
