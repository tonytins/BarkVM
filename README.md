# 🦊 BarkVM (Working Title)

<!--
## 📦 Installation

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "<git address>", branch: "<branch>"),
    ],
    targets: [
        .executableTarget(name: "<your-game>", dependencies: [
            // other dependencies
            .product(name: "<package name>", package: "<github name>"),
        ]),
        // other targets
    ]
)
```

Or in Xcode: File -> Add Package Dependencies, then paste the repo URL.


## 🚀 Usage
-->

### ✅ Supported Versions

| act2    | Minimum Swift Version |
| ------- | --------------------- |
| ``main`` | 6.3                   |

## 🔍 Background

I've written *plenty* of [parsers](https://github.com/tonytins/swift-cst) and attempted a [toy programming languages](https://github.com/tonytins/zlang) based around my parsing experience and I wanted to try something new. I settled on Minimal BASIC dialect that used Esperanto for the keywords so I could learn it. But I wanted to go beyond just the parser. 

Then I stumbled upon this [beautiful video](https://youtu.be/lflRnEfZgYQ) about compiler IR (intermediate representation) and wondered, "what if I add a JSON as an IR into the mix?"

## ⚖️ License

I license this project under the MPL-2.0 license - see [LICENSE](LICENSE) for details.
