This app allows the user to search a keywords to query image albums from the [imgur api](https://api.imgur.com/). 


![Simulator Screenshot - iPhone 15 - 2024-08-13 at 06 25 43](https://github.com/user-attachments/assets/0b2652cf-e23e-43bc-9511-d7c9ca07d182)   ![Simulator Screenshot - iPhone 15 - 2024-08-13 at 06 25 54](https://github.com/user-attachments/assets/e6b2c45f-e1d6-4049-8dd6-2f4e018f7f02)

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

# Libraries

## [Kingfisher](https://github.com/onevcat/Kingfisher)

Kingfisher is a powerful library that simplifies the process for fetching remote images. Here's why I chose it

1. Asynchronous Loading: Kingfisher loads images asynchronously, ensuring the UI remains responsive even when dealing with large or numerous images.

2. Performance: Image processing (e.g Downsampling, Resizing); crucial for perfomrance when loading multiple images in a listview

3. Efficient Caching: Reduces network requests and speeds up image retrieval

4. Integrates seamlessly with SwiftUI



