//
//  Velib.swift
//  Velib2
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

struct Velib: Codable {
    let nhits: Int?
    let parameters: Parameters?
    let records: [Record]?
}

// MARK: - Parameters
struct Parameters: Codable {
    let dataset: Dataset?
    let rows, start: Int?
    let format, timezone: String?
}

enum Dataset: String, Codable {
    case velibDisponibiliteEnTempsReel = "velib-disponibilite-en-temps-reel"
}

// MARK: - Record
struct Record: Codable {
    let datasetid: String?
    let recordid: String?
    let fields: Fields?
    let geometry: Geometry?
    let recordTimestamp: String?

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct Fields: Codable {
    let name, stationcode: String?
    let ebike, mechanical: Int?
    let coordonneesGeo: [Double]?
    let duedate: String?
    let numbikesavailable, numdocksavailable, capacity: Int?
    let isRenting, isInstalled: String?
    let nomArrondissementCommunes: String?
    let isReturning: String?

    enum CodingKeys: String, CodingKey {
        case name, stationcode, ebike, mechanical
        case coordonneesGeo = "coordonnees_geo"
        case duedate, numbikesavailable, numdocksavailable, capacity
        case isRenting = "is_renting"
        case isInstalled = "is_installed"
        case nomArrondissementCommunes = "nom_arrondissement_communes"
        case isReturning = "is_returning"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: TypeEnum?
    let coordinates: [Double]?
}

enum TypeEnum: String, Codable {
    case point = "Point"
}
