# NamesGenerator

Simple different random names generator for Swift.

Uses prepared dictionaries from Star Wars, Stars, Animals, Colors, Game of the thrones and The Witcher.

```swift
import NamesGenerator

let name: String = try NamesGenerator.generate()
```

Dictionary is initialized lazily, if you need to load before use
```swift
try NamesGenerator.initialize()
```

To use it add package in SPM
https://github.com/awxkee/Names.git
