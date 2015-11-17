# Notables-Swift
Protocol extensions for common NSNotifications for the lazy (me)

## AppNotable
- Listens for...
  - UIApplicationDidEnterBackgroundNotification
  - UIApplicationWillEnterForegroundNotification
  - UIApplicationDidFinishLaunchingNotification
  - UIApplicationDidBecomeActiveNotification
  - UIApplicationWillResignActiveNotification
  - UIApplicationDidReceiveMemoryWarningNotification
  - UIApplicationWillTerminateNotification

## KeyboardNotable
- Listens for...
  - UIKeyboardWillShowNotification
  - UIKeyboardWillHideNotification
  - UIKeyboardDidShowNotification
  - UIKeyboardDidHideNotification
- Passes back object with...
  - animationCurve
  - animationDuration
  - frameEnd
  - frameBegin
  - `animate` with the keyboard animation curves 

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
