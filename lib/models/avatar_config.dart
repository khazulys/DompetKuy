import 'dart:math';

enum DiceBearStyle {
  avataaars,
  bottts,
  pixelArt,
  lorelei,
  personas,
  adventurer,
  bigSmile,
  micah,
}

extension DiceBearStyleExtension on DiceBearStyle {
  String get apiName {
    switch (this) {
      case DiceBearStyle.avataaars:
        return 'avataaars';
      case DiceBearStyle.bottts:
        return 'bottts';
      case DiceBearStyle.pixelArt:
        return 'pixel-art';
      case DiceBearStyle.lorelei:
        return 'lorelei';
      case DiceBearStyle.personas:
        return 'personas';
      case DiceBearStyle.adventurer:
        return 'adventurer';
      case DiceBearStyle.bigSmile:
        return 'big-smile';
      case DiceBearStyle.micah:
        return 'micah';
    }
  }

  String get displayName {
    switch (this) {
      case DiceBearStyle.avataaars:
        return 'Avataaars';
      case DiceBearStyle.bottts:
        return 'Bottts';
      case DiceBearStyle.pixelArt:
        return 'Pixel Art';
      case DiceBearStyle.lorelei:
        return 'Lorelei';
      case DiceBearStyle.personas:
        return 'Personas';
      case DiceBearStyle.adventurer:
        return 'Adventurer';
      case DiceBearStyle.bigSmile:
        return 'Big Smile';
      case DiceBearStyle.micah:
        return 'Micah';
    }
  }
}

class AvatarConfig {
  final String seed;
  final DiceBearStyle style;

  const AvatarConfig({
    required this.seed,
    required this.style,
  });

  String get avatarUrl {
    return 'https://api.dicebear.com/7.x/${style.apiName}/svg?seed=$seed&backgroundColor=transparent';
  }

  AvatarConfig copyWith({
    String? seed,
    DiceBearStyle? style,
  }) {
    return AvatarConfig(
      seed: seed ?? this.seed,
      style: style ?? this.style,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seed': seed,
      'style': style.name,
    };
  }

  factory AvatarConfig.fromJson(Map<String, dynamic> json) {
    return AvatarConfig(
      seed: json['seed'] as String? ?? 'default',
      style: DiceBearStyle.values.firstWhere(
        (s) => s.name == json['style'],
        orElse: () => DiceBearStyle.avataaars,
      ),
    );
  }

  static AvatarConfig random([Random? random]) {
    final rng = random ?? Random();
    final styles = DiceBearStyle.values;
    final randomStyle = styles[rng.nextInt(styles.length)];
    final randomSeed = rng.nextInt(999999).toString();
    
    return AvatarConfig(
      seed: randomSeed,
      style: randomStyle,
    );
  }

  static AvatarConfig defaults() {
    return const AvatarConfig(
      seed: 'default',
      style: DiceBearStyle.avataaars,
    );
  }

  static AvatarConfig fromName(String name) {
    return AvatarConfig(
      seed: name,
      style: DiceBearStyle.avataaars,
    );
  }
}
