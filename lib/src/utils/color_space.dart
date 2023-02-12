enum ColorSpace {
  hex('HEX'),
  rgb('RGB'),
  hsl('HSL');

  const ColorSpace(this.name);
  final String name;
}
