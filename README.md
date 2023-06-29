# FacilitySelector
An iOS app that displays information about the list of facilities and their options from an API with the exclusion condition, so that users cannot select from the exclusion combinations. Built with Swift 5, UIKit, and MVVM architecture.



## Introduction

This is an iOS app called FacilitySelector that allows users to select facilities and options. It fetches facility data from an API and displays it in a table view. Users can select options and handle any exclusions based on the selected options.

## Architecture

The app follows the Model-View-ViewModel (MVVM) architecture pattern. Here is a breakdown of the key components:

- **View**: The view layer consists of the user interface components, including view controllers and table view cells. It is responsible for displaying the data and handling user interactions.

- **ViewModel**: The view model layer acts as an intermediary between the view and the model. It contains the business logic and data manipulation methods. The view model interacts with the model layer to fetch data, perform calculations, and update the view accordingly.

- **Model**: The model layer represents the data and data structures used in the app. It includes the API service, data models, and networking components.



## Explanation for using MVVM Architecture

The MVVM (Model-View-ViewModel) architecture was chosen for the FacilitySelector app due to its benefits in separating concerns, improving code organization, and facilitating testability. Here are the reasons behind choosing MVVM:

- **Separation of Concerns**: MVVM helps in separating the responsibilities of different components. The model represents the data and business logic, the view handles the user interface, and the view model acts as a bridge between the model and the view. This separation allows for better code organization and maintainability.

- **Testability**: MVVM promotes testability by decoupling the business logic from the user interface. The view model contains the majority of the app's logic, making it easier to write unit tests without dependencies on the view or the model. This separation of concerns enables isolated testing of the app's functionality.

- **Reusability**: With MVVM, the view model can be reused across different views, allowing for better code reuse. This can be particularly useful when multiple views require similar data or behavior, reducing duplication of code.

- **Binding and Observability**: MVVM facilitates the use of data binding and observability patterns. The view model exposes properties that the view can bind to, enabling automatic updates of the user interface when the underlying data changes. This improves the responsiveness and synchronization of the app's UI.

- **Maintainability**: The separation of concerns and clear division of responsibilities in MVVM make the codebase more maintainable. It becomes easier to understand, modify, and extend the app's functionality without impacting other components.

- **Support for Dependency Injection**: MVVM works well with dependency injection, which promotes loose coupling between components. This makes it easier to replace dependencies with mock objects during testing or introduce new functionalities without tightly coupling them to existing code.

By adopting MVVM in the FacilitySelector app, we can achieve a clean and organized codebase, improve testability, enhance code reusability, and maintain a separation of concerns between different layers of the application.



## File Interactions

The key files and their interactions in the app are as follows:

- **FacilityTableViewCell.swift**: This file defines a custom table view cell used to display facility options. It handles the configuration and selection of options.

- **APIProtocol.swift**: This file defines the API protocol, which provides a blueprint for making API requests. It includes associated types and a completion handler for handling API responses.

- **HTTPMethod.swift**: This file defines an enumeration of HTTP methods used for making API requests, such as GET, POST, PUT, and DELETE.

- **APIError.swift**: This file defines an enumeration of API errors that can occur during API interactions, such as an invalid URL, invalid response, decoding error, and request failure.

- **Constants.swift**: This file defines constants used in the app, including the base URL for the API.

- **FacilityData.swift**: This file defines the data models for facility data, including the Facility, Option, and Exclusion structs. These models represent the JSON data fetched from the API.

- **FacilityViewController.swift**: This file is the main view controller of the app. It handles the table view data source and delegate methods, fetches facility data from the API, and updates the view based on user interactions.

- **FacilityViewModel.swift**: This file defines the view model for the FacilityViewController. It implements the FacilityViewModelProtocol and contains methods for fetching facilities, toggling option selection, and checking if an option is selected.

- **API.swift**: This file implements the API protocol and handles API requests using URLSession. It includes a generic implementation that can be used with different response types.

- **FacilitySelectorApi.swift**: This file defines the FacilitySelectorApi class, which acts as a wrapper for the API service. It provides a method for fetching facility data using the API.

- **FacilityViewControllerTests.swift**: This file contains unit tests for the FacilityViewController class.

- **FacilityViewModelTests.swift**: This file contains unit tests for the FacilityViewModel class.

- **MockURLSession.swift**: This file defines a mock URL session for testing network requests.

- **MockURLProtocol.swift**: This file defines a mock URL protocol for testing network requests.

- **MockFacilityViewModel.swift**: This file defines a mock facility view model for testing the FacilityViewController.

- **MockFacilityService.swift**: This file defines a mock facility service for testing the FacilitySelectorApi.


## Features

The key features of the FacilitySelector app are as follows:

- Displaying facility options in a table view.
- Selecting and deselecting options.
- Handling exclusions based on selected options.
- Fetching facility data from an API.
- Showing error messages for API failures.

## Technologies Used

The app utilizes the following technologies:

- Swift: The programming language used to develop the app.
- UIKit: The framework for building the app's user interface.
- URLSession: The networking framework used for making API requests.
- Codable: The Swift protocol used for parsing JSON data into model objects.

## Installation

To run the FacilitySelector app on your iOS device or simulator, follow these steps:

1. Clone the repository to your local machine.
2. Open the Xcode project file (`.xcodeproj`) in Xcode.
3. Build the project by selecting a target device or simulator.
4. Run the app by clicking the "Run" button in Xcode.

## Contribution

Contributions to the FacilitySelector app are welcome. If you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Commit your changes with clear and descriptive commit messages.
5. Push your branch to your forked repository.
6. Open a pull request, describing your changes and why they should be merged.

