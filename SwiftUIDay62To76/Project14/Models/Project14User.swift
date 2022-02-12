//
//  Project14User.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 28/01/2022.
//

import Foundation

struct Project14User: Comparable, Identifiable  {
       
    let id = UUID()
    let firstName: String
    let lastName: String
    
    /**
     Fourth, the method must be marked as static, which means it’s called on the User struct directly rather than a single instance of the struct.
     */
    static func < (lhs: Project14User, rhs: Project14User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
