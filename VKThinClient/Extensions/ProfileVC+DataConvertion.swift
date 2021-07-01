//
//  ProfileVC+DataConvertion.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 1.07.21.
//

import Foundation

extension ProfileVC {
    //Would be better to add DetailType call that in and switch. Consider MVVM
    func sex(by id: Int) -> String {
        switch id {
        case 0: return  "Not set"
        case 1: return  "Female"
        case 2: return  "Male"
        default: return "Other"
        }
    }
    
    func relation(by id: Int) -> String {
        switch id {
        case 0: return "Not Set"
        case 1: return "Single"
        case 2: return "Relationship"
        case 3: return "Engaged"
        case 4: return "Married"
        case 5: return "Complicated"
        case 6: return "Searchijg"
        case 7: return "In Love"
        case 8: return "Civil"
        default: return "Other"
        }
    }
    
    func city(from fetchedCity: String) -> String {
        guard !fetchedCity.isEmpty else { return "Not Set" }
        return fetchedCity
    }
}
