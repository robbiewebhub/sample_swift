//
//  FirgunProducts.swift
//  Firgun
//
//  Created by LP on 02/11/21.
//

import Foundation
public struct FirgunProducts {
  public static let monthlySub = "com.rfp.monthlysubs"
  public static let store = IAPManager(productIDs: FirgunProducts.productIDs)
  private static let productIDs: Set<ProductID> = [FirgunProducts.monthlySub]
}

public func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
