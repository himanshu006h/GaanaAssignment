//
//  GaanaViewModel.swift
//  GaanaAssignment
//
//  Created by Himanshu Saraswat on 27/07/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation


protocol GaanaInformation: class {
    func updateGaanaDetails(gaanaDetails: Any?, error: Error?)
}

struct GaanaViewModel {
    //MARK:- Properties
    var gaanaInfo : GaanaBase?
    weak var gaanaDelegate: GaanaInformation?
    
    func fetchGaanaDetails() {
        // Fetch data from the API
        NetworkDataLoader().loadResult { result in
            switch result {
            case let .success(feedInfo):
                self.gaanaDelegate?.updateGaanaDetails(gaanaDetails: feedInfo, error: nil)
                DispatchQueue.main.async {
                    
                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) :
                self.gaanaDelegate?.updateGaanaDetails(gaanaDetails: nil, error: error)
            }
        }
    }
}
