# dmg plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-dmg)
[![Build Status](https://travis-ci.org/advoryanskiy/fastlane-plugin-dmg.svg?branch=master)](https://travis-ci.org/advoryanskiy/fastlane-plugin-dmg)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-dmg`, add it to your project by running:

```bash
fastlane add_plugin dmg
```

## About dmg

Easily create DMG for your Mac app

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

```ruby
  dmg(path: "/some/myapp/",             # required
      output_path: "/some/myapp.dmg",   # optional, by default will be at the same location as 'myapp' folder
      volume_name: "myapp",             # optional, by default will be the same as input folder name
      filesystem: "hfs+",               # optional, default is 'hfs+'
      format: "udzo",                   # optional, default is 'udzo'
      size: 10)                         # in megabytes, optional, by default will be calculated as input folder size + 10%
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
