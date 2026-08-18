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

I've written *plenty* of [parsers](https://github.com/tonytins/swift-cst) and attempted a [toy programming languages](https://github.com/tonytins/zlang) based around my parsing experience and I wanted to try something new. Then I stumbled upon this [beautiful video](https://youtu.be/lflRnEfZgYQ) about compiler IR (intermediate representation) and wondered, "what if JSON held the opcodes?" It basically comes for free.

I originally went with a Minimal BASIC with an Esperanto dialect that replaced it with Esperanto but then I realized an LSL-style state machine would actually be useful for a few projects I have on the back burner. The overall syntax closely resemblances Lua.

```lua
state default
    func onWatchTv(channel)
        if channel == "cooking"
            state cooking
        end
    end
end

state cooking
    func stateEntry()
        print Skills.cooking()
    end
end
```

The above is just a _rough_ idea of the concept. Was mostly based around binding menu handlers to a life simulation engine after things got too complex.

## ⚖️ License

I license this project under the MPL-2.0 license - see [LICENSE](LICENSE) for details.
