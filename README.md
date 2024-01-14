# SOLID Principles Example in Swift

A Swift project demonstrating SOLID principles in a product management system, integrated with NetworkKit for API interactions.

## Overview

This project showcases the implementation of SOLID principles for better software design. It includes basic product management functionalities and integrates the NetworkKit Swift package for seamless networking.

## Features

- **SOLID Principles:** Implementation of Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion principles.
- **NetworkKit Integration:** Seamless API interactions using the NetworkKit Swift package.
- **Product Management:** Basic functionalities like adding, fetching, updating, and deleting products.

## SOLID Principles

1. **Single Responsibility Principle (SRP):** Organized code into separate protocols for each responsibility.
2. **Open/Closed Principle (OCP):** Designed to be open for extension and closed for modification.
3. **Liskov Substitution Principle (LSP):** Implementing protocols without changing behaviour.
4. **Interface Segregation Principle (ISP):** Protocols designed with specific methods for respective responsibilities.
5. **Dependency Inversion Principle (DIP):** Project depends on abstractions (protocols) rather than concrete implementations.

## Getting Started

Clone and set up the project locally:

    ```bash
      git clone https://github.com/sabapathyk7/SOLIDPrinciplesExample.git
      cd SOLIDPrinciplesExample

# Usage

Explore and use the project with code snippets and examples:

    ```bash
    // Example code snippets
    let productService = ProductServiceRepositoryImpl()
    try await productService.fetchProducts()
    // ...

# Dependencies

**NetworkKit**: Swift package for handling network requests.

Simply add NetworkKit to your project using Swift Package Manager - https://github.com/sabapathyk7/NetworkKit.git








