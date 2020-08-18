//
//  UninstallScript.swift
//  Solar2D Plugin for Xcode
//
//  Created by jcb on 18/04/16.
//  Copyright © 2016-2020 Jacob Nielsen. All rights reserved.
//

import Foundation

class UninstallScript {
    
    func getScript(_ RES_PATH: String) -> String {
    
        let osascript:String = "set UnixPath to \""+RES_PATH+"\"\ntell application \"Terminal\"\ndo script \"echo '------------------------------------------------------------------'; echo 'Uninstalling Solar2D for Xcode. Please enter your admin password.';sudo \" & (quoted form of (UnixPath & \"uninstall.sh\"))\nactivate\nend tell"
        
        return osascript
    }
}

