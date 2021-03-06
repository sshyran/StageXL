@TestOn('browser')
library spritesheet_test;

import 'package:test/test.dart';
import 'package:stagexl/stagexl.dart';

void main() {
  ResourceManager resourceManager;
  SpriteSheet spritesheet;
  BitmapData spiders;

  setUp(() async {
    resourceManager = ResourceManager();
    resourceManager.addBitmapData('spiders', '../common/images/spider.png');
    await resourceManager.load();
    spiders = resourceManager.getBitmapData('spiders');
    spritesheet = SpriteSheet(spiders, 32, 32);
  });

  tearDown(() {
    resourceManager = null;
    spiders = null;
    spritesheet = null;
  });

  //---------------------------------------------------------------------------

  test('SpriteSheet assigns source BitmapData', () {
    expect(spritesheet.source, equals(spiders));
  });

  test('SpriteSheet.frames is the expected size', () {
    expect(spritesheet.frames.length, equals(28));
  });

  test('SpriteSheet.frames calls BitmapData.sliceSpriteSheet correctly', () {
    for (var index = 0; index < spritesheet.frames.length; index++) {
      var x = index % 7;
      var y = index ~/ 7;
      var id1 = spritesheet.frames[index].renderTextureQuad.getImageData();
      var id2 = spiders.renderTexture.canvas.context2D
          .getImageData(x * 32, y * 32, 32, 32);
      expect(id1.data, equals(id2.data), reason: '@frame $index');
    }
  });

  test('SpriteSheet.frameAt uses SpriteSheet.frames', () {
    for (var index = 0; index < spritesheet.frames.length; index++) {
      expect(spritesheet.frameAt(index), equals(spritesheet.frames[index]));
    }
  });
}
