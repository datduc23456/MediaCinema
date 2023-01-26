//
//  BaseModel.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation

struct EmptyDecodable: Decodable {}

protocol BaseModelProtocol: Decodable {
    var status : Int? { get set }
    var message : String? { get set }
    var message_code : String? { get set }
}
