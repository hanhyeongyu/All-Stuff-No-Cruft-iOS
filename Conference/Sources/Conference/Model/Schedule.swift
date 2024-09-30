//
//  Schedule.swift
//
//
//  Created by 한현규 on 8/29/24.
//

import Foundation


struct Schedule: Decodable{
    let meetingStartAt: Date
    let meetingEndAt: Date
    let registerStartAt: Date
    let registerEndAt: Date
}
