//
//  String.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/19/20.
//

import Foundation
extension String{
    func isAnagramWith(secondString: String) -> Bool {
        //remove duplicates
        //remove white spaces
        var set1 = Set<Character>()
        var set2 = Set<Character>()
        return self.filter{
            if $0 != " "{
                return set1.insert($0).inserted
            }
            return false
        }.lowercased().sorted() == secondString.filter{
            if $0 != " "{
                return set2.insert($0).inserted
            }
            return false
        }.lowercased().sorted()
    }
}
