import Foundation

// MARK: - MapResults
struct MapResults: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let current: [CurrentVehicle]
    let stats: Stats
}

// MARK: - Current
struct CurrentVehicle: Codable {
    let id, vehicleID, hardwareID: String
    let zoneID: ZoneID
    let resolution: Resolution?
    let resolvedBy: ResolvedBy?
    let resolvedAt: String?
    let battery: Int
    let state: State
    let model: Model
    let fleetbirdID: Int
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case id
        case vehicleID = "vehicleId"
        case hardwareID = "hardwareId"
        case zoneID = "zoneId"
        case resolution, resolvedBy, resolvedAt, battery, state, model
        case fleetbirdID = "fleetbirdId"
        case latitude, longitude
    }
}

enum Model: String, Codable {
    case aa = "AA"
    case ab = "AB"
    case unknown = "UNKNOWN"
}

enum Resolution: String, Codable {
    case claimed = "CLAIMED"
    case notFound = "NOT_FOUND"
    case other = "OTHER"
}

enum ResolvedBy: String, Codable {
    case iYmPlyTwy7BOUbsssugZKoTEA4F2 = "IYmPlyTwy7bOUbsssugZKoTEA4F2"
    case kmOOdbjxxxWwnbFCLZXdtGLQPZ92 = "KmOOdbjxxxWwnbFCLZXdtGLQPZ92"
    case prqn30X2KtOk0KeS2ZbgwiIJNEn2 = "Prqn30X2ktOk0KeS2ZbgwiIJNEn2"
    case rd2CFMWkCzLPHiDZOWMlDeV9O783 = "Rd2CFMWkCzLPHiDZOWMlDeV9o783"
    case the3DbhdJYhT1TZI6N57ZReJJeHyIZ2 = "3dbhdJYhT1TZI6n57ZReJJeHyIZ2"
    case the5VRiXTOvRWbWfAlIKDv10HrE8LJ2 = "5VRiXTOvRWbWfAlIKDv10HrE8LJ2"
}

enum State: String, Codable {
    case active = "ACTIVE"
    case damaged = "DAMAGED"
    case gpsIssue = "GPS_ISSUE"
    case lastSearch = "LAST_SEARCH"
    case lost = "LOST"
    case lowBattery = "LOW_BATTERY"
    case maintenance = "MAINTENANCE"
    case missing = "MISSING"
    case outOfOrder = "OUT_OF_ORDER"
}

enum ZoneID: String, Codable {
    case berlin = "BERLIN"
}

// MARK: - Stats
struct Stats: Codable {
    let statsOpen, assigned, resolved: Int

    enum CodingKeys: String, CodingKey {
        case statsOpen = "open"
        case assigned, resolved
    }
}
