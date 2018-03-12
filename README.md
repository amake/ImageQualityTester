# ImageQualityTester

A very simple macOS app for checking various JPEG quality levels of an
image. Drop an image onto it, and it will place conversions of quality 10 to 100
(increments of 10) into the directory of the source file.

This is a wrapper for [ImageMagick](https://www.imagemagick.org/), intended for
folks who don't want to install it themselves, and also meant to be a template
for making similar one-off image processing tools.

# Building

Requirements:

- GNU make
- [Platypus](https://github.com/sveinbjornt/Platypus) with command-line tool installed

Just run `make`. The app will be put in `work`, and the zip into
`dist`. Optionally provide your Apple developer ID to sign the app by running
`make codesign_id=...`.

# License

MIT
