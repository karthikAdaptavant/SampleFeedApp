# MaterialLoaderView

## About Package

MaterialLoaderView is a lightweight loader that was made using SwiftUI.

# Requirments

- Swift 5
- Deployment Target = iOS 13.0

## How to use?

Steps to create and use MaterialLoaderView in your project.

```swift
HStack {
    Image(systemName: "person.fill")
    Text("\(animal.name)")
}
.addMaterialLoader(loading: Bool)
```

.addMaterialLoader(loading: Bool) modifier takes care the MaterialLoader. Only thing we needed to do it change the state for the loader via the loading property.

if loading is set to true MaterialLoaderView will be displayed and if it is false MaterialLoaderView will be in hidden state


## Author
FullCreative iOS Team
