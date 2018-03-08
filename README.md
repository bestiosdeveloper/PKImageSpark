# PKImageSpark

[![CocoaPods](https://img.shields.io/cocoapods/p/FaveButton.svg)](https://cocoapods.org/pods/PKImageSpark)
[![codebeat badge](https://codebeat.co/badges/580517f8-efc8-4d20-89aa-900531610144)](https://codebeat.co/projects/github-com-kumarpramod017-pkimagespark-master)

Some Cool Animations  written in Swift


![preview](https://github.com/kumarpramod017/PKImageSpark/blob/master/PKImageSparkDemo/demo.gif)


## Requirements

- iOS 8.0+
- Xcode 9.2

## Installation

For manual instalation, drag Source folder into your project.

os use [CocoaPod](https://cocoapods.org) adding this line to you `Podfile`:

```ruby
pod 'PKImageSpark'
```

## Usage

#### With storyboard or xib files

1) Create a instance of  `PKImageSpark` with customised of default configurations and pass an `UIImage` that will spark

2) Just call `startSparking()` method for animation

Example:

```swift
let confg = PKSparkConfiguration()
confg.sparkOnView = self.view
confg.sparkGenerationView = self.clickButton
confg.totalNumberOfSparkImages = 15
confg.sparkAnimation = .bubbleToUpSide

let sparkAnimation = PKImageSpark(withImage: #imageLiteral(resourceName: "ic_love"), configuration: confg)
sparkAnimation.startSparking()
```

## Licence

PKImageSpark is released under the MIT license.











