//
//  AppDelegateSpec.swift
//  FaultReport
//
//  Created by Lawrence Tan on 17/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Quick
import Nimble

@testable import FaultReport

class AppDelegateSpec: QuickSpec {
    override func spec() {
        let subject = AppDelegate()
        
        describe("AppDelegateSpec") {
            context("when app finish launching") {
                beforeEach {
                    _ = subject.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
                
                it("should show login view controller") {
                    expect(subject.window?.bounds).to(equal(UIScreen.main.bounds))
                    expect(subject.window?.rootViewController).to(beAKindOf(FRLoginViewController.self))
                }
            }
        }
        
    }
    
}
