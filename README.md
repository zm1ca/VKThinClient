# VKThinClient
![Preview](https://github.com/zm1ca/VKThinClient/blob/main/preview.jpg)

## Build
For app to be able to be built it's required that you run `pod install` in root directory (since it uses CocoaPods, you may need to install it). 
Run via `.xcworkspace` file.

## Raw review of functionality and used technologies:
- Launch screen mildly transitioning to Loading screen, which is either passing through or presenting SafariVC for authentification 
- Using VK iOS SDK for authentification (and getting access token)
- Using Moya to perform all types of needed fetch requests to vk.api.com:
- Fetching data abstracted to designated layer dataFetcher
- Сaching images locally using dict (or NSCache in branches)
- Persisting cache in Realm database
- Refresh control used to update feed table view
- Profile view presenting activity indicator and locking interaction while performing at least one ferch request
- Profle view has animated transition to detailed view on tap
- Each element was designed using complex autolayout, meaning element are not just constrained, but they have priority to lean to specific fields of view
- Label fonts are adjusting to fit content size
- Feed cells are adjusting height depending on whether post has photo attachment or not
- UI updates performed on the main thread
- Used both Programmatic UI and Storyboard UI
- Neat appicon (in api.vk.com too) :)
- Animated indicator presented while auth request is pending

important: no dark mode support or logout (yet). Check backlog in isssues tab of that repo, feel free to contribute

## Used API Methods

- /method/newsfeed.get
- /method/account.getProfileInfo
- /method/friends.get
- /method/users.get
- /method/users.getSubscriptions


