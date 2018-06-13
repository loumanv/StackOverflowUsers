# StackOverflowUsers

An iPhone app that displays a list of the top 20 StackOverflow users. The app is written in Swift and supports iOS 11+. The app doesn't use any 3rd party libraries

The app gets the data from an API that is accessible through the endpoint: http://api.stackexchange.com/2.2/users?

- On launch the app connects to the API to asynchronously get the top 20 StackOverflow users.
- Presents the users inside a table showing their name, reputation and profile image.
- When the user taps on a user the cell expands and gives you the option to either block or follow a user. Doing that only handles these options during the usage of the app (no persistance storage)

### Architecture

The app is developed using the `MVVM` architecture:

- The Model consists of a `User` object.
- The viewModel is called `UsersViewModel` that handles the manipulation of the data in order to be shown by the ViewController.
- The ViewController is called `UsersViewController`. Inside `UsersViewController` all the related methods for populating the table. 
- The network layer consists of the `NetworkClient` class that deals with all the network calls.
- Finally the `FlowController` class can be used to initalise other controllers in the future.

The use of protocols like `ContentLoadable` and `NetworkSession` helps with reusability as well as testability of the various components.

This separation of concerns makes unit testing of the layers easier and the codebase easier to maintain and expand further. 
