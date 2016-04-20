//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Gabriele on 4/20/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}

