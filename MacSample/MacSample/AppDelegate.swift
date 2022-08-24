//
//  AppDelegate.swift
//  MacSample
//
//  Created by Zac Cohan on 8/2/20.
//  Copyright © 2020 Zac Cohan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        SoulverCoreExamples.runAllExamples()
        StringParsingExamples.runAllExamples()
    
    }


}

