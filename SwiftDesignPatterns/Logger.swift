//
//  Logger.swift
//  SwiftDesignPatterns
//
//  Created by user on 7/15/15.
//  Copyright © 2015 someCompanyNameHere. All rights reserved.
//

import Foundation

//for genrics we need to use a global constant
let productLogger = Logger<Product>(callback: {p in print("\(p.name) items in stock")})

final class Logger<T where T:NSObject, T:NSCopying> {

    //generic array and callback
    var dataItems:[T] = []
    var callback:(T) -> Void
    var arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_CONCURRENT)
    var callbackQ = dispatch_queue_create("callbackQ", DISPATCH_QUEUE_SERIAL)


    //set protection on by default
    private init(callback:T ->Void, protected:Bool = true){
        self.callback = callback

        //if protection is enabled add callback to serial queue
        if protected {
            self.callback = {(item:T) in
                dispatch_sync(self.callbackQ, { () -> Void in
                    callback(item)
                })
            }

        }
    }

    func logItem(item:T){

        //create a synchronization point within a concurrent dispatch queue
        //all items in the queue will be processed first, then the add by itself
        //this creates a read/write lock
        dispatch_barrier_async(arrayQ, { () -> Void in
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        })
    }

    func processItems(callback:T ->Void) {
        dispatch_sync(arrayQ, { () -> Void in
            for item in self.dataItems {
                callback(item)
            }
        })
    }
}