//
//  InstallScript.swift
//  Solar2D Plugin for Xcode
//
//  Created by jcb on 18/04/16.
//  Copyright © 2016-2020 Jacob Nielsen. All rights reserved.
//

import Foundation

class InstallScript {

    func getScript(_ RES_PATH: String) -> String {
    
        let osascript:String = "set UnixPath to \""+RES_PATH+"\"\ntell application \"Terminal\"\ndo script \"echo '------------------------------------------------------------------'; echo 'Installing Solar2D for Xcode. Please enter your admin password.';sudo \" & (quoted form of (UnixPath & \"install.sh\"))\nactivate\nend tell"
		
        return osascript
    }
}
