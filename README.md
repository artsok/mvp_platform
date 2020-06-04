# Platform
Mobile Platform Bootstrap by Flutter


# Before Starting to CODE
By this link you can find information how to setup your environment.
```text
https://flutter.dev/docs/get-started/install/macos
https://flutter.dev/docs/get-started/web
```

# Plugin
1. Change app name:
```text
flutter pub run flutter_launcher_name:main
flutter pub run flutter_launcher_icons:main
```


# Git Issue
If you have issue by pull with next text 
```text
Delta compression using up to 8 threads. Total 18 (delta 5), reused 0 (delta 0) RPC failed; 
curl 92 HTTP/2 stream 0 was not closed cleanly: PROTOCOL_ERROR (err 1) The remote end hung up unexpectedly The remote end hung up unexpectedly
```

use to:
```text
git config --global http.postBuffer 957286400
```

# Flutter Issue

```text
could not find included file 'Pods/Target Support Files/Pods-Runner
```

cd to ios folder and run

```text
pod install
```