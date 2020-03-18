//
//  Dependencies.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift

class Dependencies {
    
    static let sharedDependencies = Dependencies()
    
    let URLSession = Foundation.URLSession.shared
    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler
    
    private init() {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = QualityOfService.userInitiated
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        
        mainScheduler = MainScheduler.instance
        
    }
    
}

