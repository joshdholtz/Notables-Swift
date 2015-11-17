//
//  KeyboardNotable.swift
//  Notables
//
//  Created by Josh Holtz on 11/17/15.
//  Copyright © 2015 RokkinCat. All rights reserved.
//

import UIKit

private let notificationNames = [
	UIKeyboardWillShowNotification,
	UIKeyboardWillHideNotification,
	UIKeyboardDidShowNotification,
	UIKeyboardDidHideNotification
]

class KeyboardNotableInfo: NSObject {
	var animationCurve: UIViewAnimationCurve
	var animationDuration: NSTimeInterval
	var frameEnd: CGRect
	var frameBegin: CGRect
	init(_ notification: NSNotification) {
		let userInfo = notification.userInfo!
		animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
		animationCurve = UIViewAnimationCurve(rawValue: userInfo[UIKeyboardAnimationCurveUserInfoKey] as! Int)!
		frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue).CGRectValue()
		frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as! NSValue).CGRectValue()
	}
}

protocol KeyboardNotable: NSObjectProtocol {
	func note_keyboardWillShow(info: KeyboardNotableInfo)
	func note_keyboardWillHide(info: KeyboardNotableInfo)
	func note_keyboardDidShow(info: KeyboardNotableInfo)
	func note_keyboardDidHide(info: KeyboardNotableInfo)
}

extension KeyboardNotable where Self:UIViewController {
	func note_registerForKeyboardEvents() {
		for notificationName in notificationNames {
			NSNotificationCenter.defaultCenter().addObserverForName(notificationName, object: nil, queue: nil) { [weak self] notification in
				self?.handleNotificationEvent(notification)
			}
		}
	}
	
	func note_unregisterForKeyboardEvents() {
		for notificationName in notificationNames {
			NSNotificationCenter.defaultCenter().removeObserver(self, name: notificationName, object: nil)
		}
	}

	private func handleNotificationEvent(notification: NSNotification) {
		switch notification.name {
		case UIKeyboardWillShowNotification:
			note_keyboardWillShow(KeyboardNotableInfo(notification))
		case UIKeyboardWillHideNotification:
			note_keyboardWillHide(KeyboardNotableInfo(notification))
		case UIKeyboardDidShowNotification:
			note_keyboardDidShow(KeyboardNotableInfo(notification))
		case UIKeyboardDidHideNotification:
			note_keyboardDidHide(KeyboardNotableInfo(notification))
		default: ()
		}
	}
	
	// MARK: Default no-op implementations
	
	func note_keyboardWillShow(info: KeyboardNotableInfo) {}
	func note_keyboardWillHide(info: KeyboardNotableInfo) {}
	func note_keyboardDidShow(info: KeyboardNotableInfo) {}
	func note_keyboardDidHide(info: KeyboardNotableInfo) {}
}