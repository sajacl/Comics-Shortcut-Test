# The Shortcutter's Coding Challenge
## Created by Sajad Vishkai

- [Github][github-url]
- [Linkedin][linkedin-url]

Hi dear reader,
Thanks for exciting challenge!

For the reason of MVP, i have left some parts short, and some parts are practical as you can see,
But some parts are ✨Enjoyable ✨.
(says the guy who wrote it :D)

### Project has 5 Main parts
- Delegates (AppDelegate, SceneDelegate)
- Models
- Modules
- Utils
- SupportedFiles
- Resources

## Features

- You can browse through the comics. They will be available offline and online.
- You can Search for comics. (ID or Name)
- You can get the comic explanation and see it in Details. 
- You can zoom on any comic if you like to see it closer.
- Favorite the comics, (It would work offline too).
- You can share comics with others via card ContextMenu or share button in ComicDetail. (Im planning to share only the transcript to others for now)
- You can see your favorites in another view which can be presented by holding your finger on app icon (iOS Home).
- App supportes multi languages. (Sweedish and English for now)
- App supportes Theme changing from OS.

## Tech Stack

### 1. External libs
- [Realm][realm-url] - Realm to work as our Database.
- [KingFisher][kingfisher-url] - Kingfisher to work as our Image handler.
- [CardStack][cardstack-url] - CardStack to work as our Comic view holder.
- [Dillinger][dillinger-url] - To write this beautiful ReadMe.
- Google Search for StarShape component.

### 2. Modules structure

| Module | Structure |
| ------ | ------ |
| AppDelegate | AppDelegateCompsotie + AppDelegateFactory |
| ComicView | SwiftUI + MVVM and Combine |
| ComicCard | SwiftUI + MVVM and Combine |
| ComicDetail | SwiftUI + VIPER and Combine (added a touch of viewmodelish style) |
| Search | SwiftUI + MVVM and Combine |
| Favorites | SwiftUI + MVVM and Combine |
| RealmHelper | Singletone |

## 3. Unit Tests

As I mentioned earlier, For sake of a MPV project I have decided to focus on functionality of the app, so Unit tests are a little bit faded, but for you to measure my work, i have added some.

How to run:
```sh
Cmd + U
```
## 4. UI Tests

As I mentioned earlier, For sake of a MPV project I have decided to focus on functionality of the app, so UI tests are none at this moment, Realm lib needs to be configed if we want to proceed more.
It fails the running UI Tests  proccess :(

# Git History
I have moved this repo from my own local git, so could not get the history right, But i am attaching a screen shot for you to see my history, i can give access to you if it is necessary.

# License

MIT

   [github-url]: <https://www.github.com/sajacl>
   [linkedin-url]: <https://www.linkedin.com/in/sajacl/>
   [realm-url]: <https://github.com/realm/realm-swift>
   [kingfisher-url]: <https://github.com/onevcat/Kingfisher>
   [cardstack-url]: <https://github.com/nhoogendoorn/CardStack>
   [dillinger-url]: <https://dillinger.io/>
