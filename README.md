# ValidationKit

**ValidationKit** is a Swift framework designed for robust and flexible data validation. It provides type-safe validators, logical operators (`&&`, `||`, `!`) for composing complex validation rules, and type-erased mechanisms to seamlessly handle both optional and non-optional properties. ValidationKit simplifies ensuring data integrity across your Swift applications, making it easier to implement and maintain complex validation logic.

## Features

- **Type-Safe Validators:** Create and compose validators tailored to your data models.
- **Logical Operators:** Use intuitive operators (`&&`, `||`, `!`) to build complex validation rules effortlessly.
- **Generic Validation Rules:** Apply dynamic validation logic to various object properties without compromising type safety.
- **Inter-Property Validation:** Define validation rules that depend on multiple properties, enabling complex validation scenarios.
- **Concurrency Safe:** Built with Swift’s `Sendable` protocol to ensure thread-safe operations.
- **Custom Validators:** Easily create your own custom validators to suit specific validation needs, enhancing flexibility and extensibility.

## Installation

ValidationKit can be integrated into your project using Swift Package Manager.

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kubens/ValidationKit.git", from: "1.0.0")
]