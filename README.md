This app allows the user to search keywords to query image albums from the [imgur api](https://api.imgur.com/). 

![Simulator Screenshot - iPhone 15 - 2024-08-13 at 07 35 49](https://github.com/user-attachments/assets/ab612461-22f5-4fdb-9e12-6545d576be07) ![Simulator Screenshot - iPhone 15 - 2024-08-13 at 07 35 55](https://github.com/user-attachments/assets/65178d9a-1d9e-468d-877a-bba9608b25c4)


Upon selecting an image album, the user will be able to see all of the images for that album. The user will also be able to view these images full-screen where they can pinch/zoom.


# Setup

To run the app, you'll need to add a `Secrets.plist` file to the root of the project with your imgur client id:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ImgurClientId</key>
	<string>YOUR_IMGUR_CLIENT_ID</string>
</dict>
</plist>
```

# Architecture

I created the app using MVVM for  a few reasons:

1. Separation of Concerns:
MVVM distinctly separates the business logic (ViewModel) from the UI (View) and data management (Model), which makes the code easier to manage and less prone to bugs
2. Reusability:
The ViewModel can be reused across different views, making it easier to maintain consistency throughout the app.
3. Reactive:
MVVM works seamlessly with SwiftUI’s reactive nature (e.g `ObservableObject`), where the UI automatically updates in response to changes in the ViewModel’s state. This reduces the complexity of managing UI state manually

# Libraries

## [Kingfisher](https://github.com/onevcat/Kingfisher)

Kingfisher is a powerful library that simplifies the process for fetching remote images. Here's why I chose it

1. Asynchronous Loading: Kingfisher loads images asynchronously, ensuring the UI remains responsive even when dealing with large or numerous images.

2. Performance: Image processing (e.g Downsampling, Resizing); crucial for perfomrance when loading multiple images in a listview

3. Efficient Caching: Reduces network requests and speeds up image retrieval

4. Integrates seamlessly with SwiftUI



