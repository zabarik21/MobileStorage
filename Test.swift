//
//  Test.swift
//  leetcode-playground
//
//  Created by Timofey on 5/9/22.
//

import Foundation

struct Mobile: Hashable {
  let imei: String
  let model: String
}

protocol MobileStorage {
  func getAll() -> Set<Mobile>
  func findByImei(_ imei: String) -> Mobile?
  func save(_ mobile: Mobile) throws -> Mobile
  func delete(_ product: Mobile) throws
  func exists(_ product: Mobile) -> Bool
}


enum MobileStorageError: Error {
  case alreadyExists
  case doesntExists
}

class MobileStorageService: MobileStorage {
  
  private var mobiles = Set<Mobile>()
    
  func getAll() -> Set<Mobile> {
    return mobiles
  }
  
  func findByImei(_ imei: String) -> Mobile? {
    let mobile = mobiles.first(where: { $0.imei == imei })
    return mobile
  }
  
  func save(_ mobile: Mobile) throws -> Mobile {
    guard !mobiles.contains(mobile) else { throw MobileStorageError.alreadyExists }
    mobiles.insert(mobile)
    return mobile
  }
  
  func delete(_ product: Mobile) throws {
    guard mobiles.contains(product) else { throw MobileStorageError.doesntExists }
    mobiles.remove(product)
  }
  
  func exists(_ product: Mobile) -> Bool {
    return mobiles.contains(product)
  }
  
}
