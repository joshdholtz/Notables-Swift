//
//  ViewController.swift
//  Notables
//
//  Created by Josh Holtz on 11/17/15.
//  Copyright © 2015 RokkinCat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var btnSend: UIButton!
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

	@IBAction func onClickSend(sender: AnyObject) {
		view.endEditing(true)
	}
}

extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
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