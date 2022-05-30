- [About Todo App](#about_to_do_app)
    - [Requirement, feature list, Techs](#requirement)
    - [Screenshots and Video demo](#screenshoot-and-video-demo)
- [Setup environment](#setup-vs-environmen)
- [How to run this application?](#How-to-run-this-application?)
- [How to run test cases?](#How-to-run-test-cases?)
- [Contact](#Contact)

# About Todo App
Todo App is a Flutter project with some informations below:
## Requirement vs feature list
- About Requirement - [Reference](https://drive.google.com/file/d/11T8fysPdvKSm8fUSWQcq0sGChOkcoFZ3/view)

- Feature list:

    * Add new a todo item
    * Update a todo item
    * Delete new todo item
    * View all todos item
    * View all todos item is completion
    * View all todos item is incompletion

- Technicals:

    * MVC architecture with [GetX Package](https://pub.dev/packages/get)
    * Use [sqflite](https://pub.dev/packages/sqflite) to manage and save data at local
    * Setup 3 environment for the app(dev, stg, prod)
    * Setup CI/CD with Firebase
    * Write the Unit tests

## Screenshots and video demo

- Screenshots:

* iOS

<img src="https://github.com/xuanvinhtd/todo-app-flutter/blob/main/screenshots/ios/1-ios.png" height="300em" />

<img src="https://github.com/xuanvinhtd/todo-app-flutter/blob/main/screenshots/ios/2-ios.png" height="300em" />

<img src="https://github.com/xuanvinhtd/todo-app-flutter/blob/main/screenshots/ios/3-ios.png" height="300em" />


- Video demo - [Reference]()

# Setup environment
- Required run app:

    * Xcode 12.5 or above
    * Android studio arctic fox or above
    * Flutter 2.10.4 or above
    * CocoaPods 1.11.3 or above

- Required to setup CI:

    * Ruby 2.7.2
    * Bundler version 2.1.4

# How to run this application(on MacOS)?

1. Start a simulator(iOS or Android)
2. Open terminal and go to root project directory after that run command belove:

Run app with developer environment:
```yaml
flutter clean && flutter pub get && flutter run --flavor dev -t lib/main_dev.dart 
```
Note: Other environment(stg, prod) to build file(ipa or apk) for test on device.

# How to run test cases(on MacOS)?

- Open terminal and go to root project directory after that run command belove:

```yaml
flutter clean && flutter pub get && flutter test
```

- Test list:

    * Test model
    * Test logic
    * Test UI

# Contact

Nick Name: David Ho
My email: hoxuanvinhuit93@gmail.com

