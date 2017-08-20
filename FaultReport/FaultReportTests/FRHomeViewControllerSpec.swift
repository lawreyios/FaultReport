//
//  FRHomeViewControllerSpec.swift
//  FaultReport
//
//  Created by Lawrence Tan on 20/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Quick
import Nimble
import Swinject

@testable import FaultReport

class FRHomeViewControllerSpec: QuickSpec {
    class RealmHelperMock: FRRealmHelper {
        override func getAllIncidents() -> [IncidentModel] {
            return [
                IncidentModel(machineName: "MachineName-1", desc: "Desc-1", location: "Location-1"),
                IncidentModel(machineName: "MachineName-2", desc: "Desc-2", location: "Location-2"),
                IncidentModel(machineName: "MachineName-3", desc: "Desc-3", location: "Location-3"),
                IncidentModel(machineName: "MachineName-4", desc: "Desc-4", location: "Location-4"),
            ]
        }
    }
        
    override func spec() {
        var subject = FRHomeViewController()
        var subjectNavigation = FRMainNavigationController()
        
        var container: Container!
        
        let viewControllerFactory: FRViewControllerFactory! = {
            let container = Container()
            container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
            return container.resolve(FRViewControllerFactory.self)
        }()
        
        describe("FRHomeViewController") {
            beforeEach {
                container = Container()
                
                container.register(FRRealmHelper.self, name: "stub") { _ in
                    RealmHelperMock()
                }
                
                subject = viewControllerFactory.viewControllerFor(controllerClass: FRHomeViewController.self) as! FRHomeViewController
                
                subjectNavigation = viewControllerFactory.mainNavigationController(with: subject)
                
                subject.realmHelper = container.resolve(FRRealmHelper.self,
                                                        name: "stub")
                
                _ = subject.view
            }
            
            context("when view is loaded") {
                it("should have a search bar") {
                    expect(subject.searchController).toNot(beNil())
                }
            }
            
            context("when view will appear") {
                beforeEach {
                    subject.viewWillAppear(false)
                }
                
                it("should get incidents") {
                    expect(subject.viewModels.count).to(equal(4))
                }
                
                it("should display the correct number of rows") {
                    expect(subject.tableView.visibleCells.count)
                        .to(equal(subject.viewModels.count))
                }
                
                context("when displaying the list") {
                    var tableViewCell: FRIncidentTableViewCell!
                    beforeEach {
                        tableViewCell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FRIncidentTableViewCell
                    }
                    
                    it("should show machine name") {
                        expect(tableViewCell.titleLabel.text).to(contain("FR"))
                        expect(tableViewCell.subTitleLabel.text).to(equal("MachineName-1"))
                        expect(tableViewCell.locationLabel.text).to(equal("Location-1"))
                    }
                }
            }
            
            context("when searching for incidents") {
                beforeEach {
                    subject.viewWillAppear(false)
                    subject.searchController.searchBar.text = "MachineName-1"
                }
                
                it("should filter the view models") {
                    expect(subject.filteredViewModels.count).to(equal(1))
                }
            }
            
            context("when searching bar text is empty") {
                beforeEach {
                    subject.viewWillAppear(false)
                    subject.searchController.searchBar.text = ""
                }
                
                it("should return all the view models") {
                    expect(subject.filteredViewModels.count).to(equal(4))
                }
            }
            
            context("when user taps on add button") {
                beforeEach {
                    UIApplication.shared.sendAction(subject.addBarButton.action!, to: subject.addBarButton.target, from: nil, for: nil)
                }
                
                it("should bring user to add incident report screen") {
                    expect(subjectNavigation.topViewController).toEventually(beAKindOf(FRNewReportViewController.self))
                }
            }
        }
        
    }
    
}
