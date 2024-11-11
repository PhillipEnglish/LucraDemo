# Imgur Album Viewer App

## Overview

This app is a SwiftUI-based client for browsing and viewing albums from the Imgur API. Users can enter a search query to find albums, view album galleries in a carousel format, and mark favorite albums for easy access. The app showcases modern Swift features like `Async/Await` and SwiftData, emphasizing a smooth and responsive user experience.

## Key Features

1. **Album Search**: Users can search for albums using a search bar. The app queries the Imgur API with the provided search term and retrieves relevant albums.
2. **Album Gallery View**: Upon selecting an album, users are shown a gallery of images in a carousel format, with swipe and zoom capabilities for each image.
3. **Favorites**: Users can mark albums as favorites, which are saved locally and persist between sessions.
4. **Image Zoom**: In the gallery view, users can pinch-to-zoom on individual images for closer inspection.
5. **Polished UI**: The app includes a custom gradient background and design touches to create a professional and engaging experience.

## Architecture and Design Choices

The app uses a clean MVVM (Model-View-ViewModel) architecture to separate business logic from UI code, enhancing maintainability and testability.

- **Swift Concurrency**: The `Async/Await` model manages API requests, supporting smooth asynchronous data fetching. This approach simplifies networking code and improves readability.
- **SwiftData for Persistence**: SwiftData is utilized for saving favorited albums locally, providing efficient, native data management.
- **Observable Protocol**: `@Observable` is used for reactive updates in view models, which works seamlessly with SwiftUI to update the UI automatically as data changes.
- **Custom Protocols**: Protocols like `APIServiceProtocol` and `AlbumViewModelProtocol` define behavior for each component, adding flexibility for future improvements and making the app easy to test.

## Technical Choices

1. **Networking**: 
    - `APIServiceProtocol` handles API requests, allowing for flexible network handling and easy mock testing.
    - URL caching via `URLCache` improves performance for repeated queries.

2. **SwiftData for Persistence**:
    - SwiftData provides a native solution for managing favorite albums, reducing the need for external libraries and simplifying data persistence.
    - SwiftData’s integration with SwiftUI ensures a seamless experience for storing and retrieving data.

3. **View Models**:
    - Each view is supported by a dedicated view model that follows a protocol-based design, making it easy to manage specific features such as fetching albums or handling favorites.
    - SwiftData predicates are used to handle favorites efficiently in view models, checking for favorited albums directly from the store.

4. **Asynchronous Image Loading**:
    - `AsyncImage` is used to load images efficiently, with `ProgressView` and placeholder visuals handling loading states.

5. **Error Handling**:
    - Basic error handling is built into the networking layer and view models. Alerts inform users of errors with relevant messages if a network or decoding error occurs.

6. **Unit Testing**:
    - `MockAPIService` facilitates unit testing for view models, allowing independent testing without relying on live network responses.
    - Tests cover successful data fetching, error handling, and local storage behaviors for view models that interact with the API or SwiftData.

## Optional Enhancements

- **Favorites Filtering**: Users can view their favorited albums in a separate view, dynamically loaded from SwiftData’s store.
- **Pinch-to-Zoom**: The gallery view includes pinch-to-zoom functionality for a more immersive image experience.

## Third-Party Libraries

No third-party libraries are used in this project. Native Swift tools like SwiftData and `Async/Await` provided all necessary functionality for persistence, concurrency, and UI responsiveness.


