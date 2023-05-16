//
//  GetQueryResultsModel.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation

// MARK: - GetQueryResultsModelElement
struct GetQueryResultsModelElement: Codable {
    var name: String?
    var localNames: LocalNames?
    var lat, lon: Double?
    var country, state,zip: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames
        case lat, lon, country, state,zip
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    var af, ar, ascii, az: String?
    var bg, ca, da, de: String?
    var el, en, eu, fa: String?
    var featureName, fi, fr, gl: String?
    var he, hi, hr, hu: String?
    var id, it, ja, la: String?
    var lt, mk, nl, no: String?
    var pl, pt, ro, ru: String?
    var sk, sl, sr, th: String?
    var tr, vi, zu: String?

    enum CodingKeys: String, CodingKey {
        case af, ar, ascii, az, bg, ca, da, de, el, en, eu, fa
        case featureName
        case fi, fr, gl, he, hi, hr, hu, id, it, ja, la, lt, mk, nl, no, pl, pt, ro, ru, sk, sl, sr, th, tr, vi, zu
    }
}
