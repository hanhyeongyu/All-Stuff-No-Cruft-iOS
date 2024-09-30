//
//  CustomBinding.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI

extension Binding where Value == Bool{
    
    public init<T>(value: Binding<T?>){
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue{
                value.wrappedValue = nil
            }
        }

    }
}
