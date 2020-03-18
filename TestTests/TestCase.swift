//
//  TestCase.swift
//  TestTests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import XCTest
import FBSnapshotTestCase
import RxTest
import RxCocoa

@testable import Test

internal class TestCase: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Use mock data for snapshot testing
        AppEnvironment.replaceCurrentEnvironment(apiService: MockService())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func startSnapshotTesting<VC: UIViewController> (controller: VC, actions: @escaping (VC) -> Void) {
        [Device.phone4inch, Device.phone4_7inch, Device.phone5_5inch, Device.phone5_8inch, Device.pad]
               .forEach {
                   device in
                   let scheduler = TestScheduler(initialClock: 0)
                   scheduler.scheduleAt(TestScheduler.scheduledActionTime) {
                       actions(controller)
                   }
                   SharingScheduler.mock(scheduler: scheduler) {
                       let (parent, _) = traitControllers(device: device, orientation: .portrait, child: controller)
                       scheduler.start()
                    RunLoop.current.run(until: Date.init(timeInterval: 1.0, since: Date()))
                       FBSnapshotVerifyLayer(parent.view.layer, identifier: "device_\(device)")
                   }
                   
           }
       }
    
}
