//
//  RootViewController.swift
//  Corona Plugin for Xcode
//
//  Created by jcb on 16/04/16.
//  Copyright © 2016-2020 Jacob Nielsen. All rights reserved.
//

import Cocoa
import Foundation

class RootViewController: NSViewController {
	
	override func viewDidLoad() {
		if #available(OSX 10.10, *) {
			super.viewDidLoad()
		} else {
			// Fallback on earlier versions
		}
	}
	
	// Show alert
	func showAlert(title: String, message: String) {
		let alert = NSAlert.init()
		alert.messageText = title
		alert.informativeText = message
		alert.addButton(withTitle: "OK")
		alert.runModal()
	}
	
	func showCloseAlert( install:Bool, completion : (Bool)->Void) {
		let alert = NSAlert()
		alert.messageText = "Please Notice"
        if install {
            alert.informativeText = "Xcode cannot be open during installation. If Xcode is open quit it before proceeding.\n\nWhen clicking the proceed button a terminal window will appear. You need to enter your admin password for the plugin to install.\n\n"
        } else {
            alert.informativeText = "Xcode cannot be open while uninstalling. If Xcode is open quit it before proceeding.\n\nWhen clicking the proceed button a terminal window will appear. You need to enter your admin password for the plugin to uninstall.\n\n"
        }
		alert.alertStyle = NSAlert.Style.warning
		alert.addButton(withTitle: "Proceed")
		alert.addButton(withTitle: "Cancel")
		completion(alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn)
	}
	
	// Install Button
	@IBAction func installButton(_ sender: AnyObject) {
		
		let button = sender as? NSButton;
		button?.isEnabled = false;
		
		let path = Bundle.main.path(forResource: "Assets", ofType: "car")
		let RES_PATH = path!.replacingOccurrences(of: "Assets.car", with: "")
		
        showCloseAlert ( install: true, completion: {answer in
			if answer == true {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					let script = InstallScript().getScript(RES_PATH)
					
					let myAppleScript = script
					var error: NSDictionary?
					if let scriptObject = NSAppleScript(source: myAppleScript) {
						DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
							button?.isEnabled = true;
						}
						if let _: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
						} else if (error != nil) {
							print("error: \(String(describing: error))")
							let errorType: Float = (error?[NSAppleScript.errorNumber] as! Float)
							if (errorType == -1743) {
								let title: String = (error?[NSAppleScript.errorAppName] as! String)+" Error"
								let message: String = (error?[NSAppleScript.errorBriefMessage] as! String)
								self.showAlert(title: title, message: message)
							}
						}
					}
				}
			} else {
				button?.isEnabled = true;
			}
		})
    }
	
	// Uninstall button
	@IBAction func uninstallButton(_ sender: AnyObject) {
		
		let button = sender as? NSButton;
		button?.isEnabled = false;
		
		let path = Bundle.main.path(forResource: "Assets", ofType: "car")
		let RES_PATH = path!.replacingOccurrences(of: "Assets.car", with: "")
		
		showCloseAlert ( install: false, completion: {answer in
			if answer == true {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
					let script = UninstallScript().getScript(RES_PATH)
					
					let myAppleScript = script
					var error: NSDictionary?
					if let scriptObject = NSAppleScript(source: myAppleScript) {
						DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
							button?.isEnabled = true;
						}
						if let _: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
						} else if (error != nil) {
							print("error: \(String(describing: error))")
							let errorType: Float = (error?[NSAppleScript.errorNumber] as! Float)
							if (errorType == -1743) {
								let title: String = (error?[NSAppleScript.errorAppName] as! String)+" Error"
								let message: String = (error?[NSAppleScript.errorBriefMessage] as! String)
								self.showAlert(title: title, message: message)
							}
						}
					}
				}
			} else {
				button?.isEnabled = true;
			}
		})
	}
	
	
	// Show guide
	@IBAction func showGuide(_ sender: AnyObject) {
		
		let myAppleScript = "tell application \"Safari\" to open location \"http://www.shakebrowser.net/solar2d/guide.html\""
		
		var error: NSDictionary?
		if let scriptObject = NSAppleScript(source: myAppleScript) {
			if let _: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
			} else if (error != nil) {
				print("error: \(String(describing: error))")
				let errorType: Float = (error?[NSAppleScript.errorNumber] as! Float)
				if (errorType == -1743) {
					let title: String = (error?[NSAppleScript.errorAppName] as! String)+" Error"
					let message: String = (error?[NSAppleScript.errorBriefMessage] as! String)
					showAlert(title: title, message: message)
				}
			}
		}
	}
	
	override func awakeFromNib() {
		//print("View controller instance with view: \(self.view)")
	}
	
}
