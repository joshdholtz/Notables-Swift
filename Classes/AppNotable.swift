//
//  AppNotable.swift
//  Notables
//
//  Created by Josh Holtz on 11/17/15.
//  Copyright © 2015 RokkinCat. All rights reserved.
//

import UIKit

private let notificationNames = [
	UIApplicationDidEnterBackgroundNotification,
	UIApplicationWillEnterForegroundNotification,
	UIApplicationDidFinishLaunchingNotification,
	UIApplicationDidBecomeActiveNotification,
	UIApplicationWillResignActiveNotification,
	UIApplicationDidReceiveMemoryWarningNotification,
	UIApplicationWillTerminateNotification
]

protocol AppNotable: NSObjectProtocol {
	
	func note_appDidEnterBackground()
	func note_appWillEnterForeground()
	func note_appDidFinishLaunching()
	func note_appDidBecomeActive()
	func note_appWillResignActive()
	func note_appDidReceiveMemoryWarning()
	func note_appWillTerminate()
}

private var AssociationKey: UInt8 = 1
extension AppNotable where Self:UIViewController {
	
	private var appObservers: [AnyObject] {
		get {
			return objc_getAssociatedObject(self, &AssociationKey) as? [AnyObject] ?? []
		}
		set(newValue) {
			objc_setAssociatedObject(self, &AssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func note_registerForAppEvents() {
		note_unregisterForAppEvents()
		appObservers = notificationNames.map { notificationName in
			return NSNotificationCenter.defaultCenter().addObserverForName(notificationName, object: nil, queue: nil) { [weak self] notification in
				self?.handleNotificationEvent(notification)
			}
		}
	}
	
	func note_unregisterForAppEvents() {
		for observer in appObservers {
			NSNotificationCenter.defaultCenter().removeObserver(observer)
		}
	}
	
	private func handleNotificationEvent(notification: NSNotification) {
		switch notification.name {
		case UIApplicationDidEnterBackgroundNotification:
			note_appDidEnterBackground()
		case UIApplicationWillEnterForegroundNotification:
			note_appWillEnterForeground()
		case UIApplicationDidFinishLaunchingNotification:
			note_appDidFinishLaunching()
		case UIApplicationDidBecomeActiveNotification:
			note_appDidBecomeActive()
		case UIApplicationWillResignActiveNotification:
			note_appWillResignActive()
		case UIApplicationDidReceiveMemoryWarningNotification:
			note_appDidReceiveMemoryWarning()
		case UIApplicationWillTerminateNotification:
			 note_appWillTerminate()
		default: ()
		}
	}
	
	// MARK: Default no-op implementations
	
	func note_appDidEnterBackground() {}
	func note_appWillEnterForeground() {}
	func note_appDidFinishLaunching() {}
	func note_appDidBecomeActive() {}
	func note_appWillResignActive() {}
	func note_appDidReceiveMemoryWarning() {}
	func note_appWillTerminate() {}
	
}