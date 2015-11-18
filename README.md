# Notables-Swift
Protocol extensions for common NSNotifications for the lazy (me)

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## AppNotable
- Listens for...
  - `UIApplicationDidEnterBackgroundNotification`
  - `UIApplicationWillEnterForegroundNotification`
  - `UIApplicationDidFinishLaunchingNotification`
  - `UIApplicationDidBecomeActiveNotification`
  - `UIApplicationWillResignActiveNotification`
  - `UIApplicationDidReceiveMemoryWarningNotification`
  - `UIApplicationWillTerminateNotification`

## KeyboardNotable
- Listens for...
  - `UIKeyboardWillShowNotification`
  - `UIKeyboardWillHideNotification`
  - `UIKeyboardDidShowNotification`
  - `UIKeyboardDidHideNotification`
- Passes back object with...
  - `animationCurve`
  - `animationDuration`
  - `frameEnd`
  - `frameBegin`
  - `animate` with the keyboard animation curves 

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Notables into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "joshdholtz/Notables-Swift" "master"
```

Run `carthage` to build the framework and drag the built `Notables.framework` into your Xcode project.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate Notables into your project manually by copying and pasting all the files in the `Classes` directory.

## Quick Usage

```swift
class ViewController: UIViewController {
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		note_registerForAppEvents()
		note_registerForKeyboardEvents()
	}
	
	override func viewWillDisappear(animated: Bool) {
		note_unregisterForAppEvents()
		note_unregisterForKeyboardEvents()
		super.viewWillDisappear(animated)
	}
}

// MARK: 

extension ViewController: AppNotable {
	func note_appDidEnterBackground() {
		print("Called \(__FUNCTION__)")
	}
	
	func note_appDidBecomeActive() {
		print("Called \(__FUNCTION__)")
	}
}

// MARK: KeyboardNotable

extension ViewController: KeyboardNotable {
	func note_keyboardWillShow(info: KeyboardNotableInfo) {
		print("Called \(__FUNCTION__)")
		
		bottomConstraint.constant += info.frameEnd.height
		info.animate(animations: { () -> Void in
			self.btnSend.layoutIfNeeded()
		}, completion: nil)
	}
	
	func note_keyboardWillHide(info: KeyboardNotableInfo) {
		print("Called \(__FUNCTION__)")
		
		bottomConstraint.constant -= info.frameEnd.height
		info.animate(animations: { () -> Void in
			self.btnSend.layoutIfNeeded()
		}, completion: nil)
	}
	
	func note_keyboardDidShow(info: KeyboardNotableInfo) {
		print("Called \(__FUNCTION__)")
	}
	
	func note_keyboardDidHide(info: KeyboardNotableInfo) {
		print("Called \(__FUNCTION__)")
	}
}
```

## Author

Josh Holtz, me@joshholtz.com, [@joshdholtz](https://twitter.com/joshdholtz)

## License

`Notables` is available under the MIT license. See the LICENSE file for more info.
