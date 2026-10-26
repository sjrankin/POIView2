//
//  POIData.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//  Adapted from NorthernCaliforniaData in HUDViewUI. Route waypoints are not included.
//

import Foundation

///Database of Northern California landmarks and cities.
struct NorthernCaliforniaData
{
    static let Cities: [POI] =
    [
        //Bay Area
        POI(Name: "San Francisco", Latitude: 37.7749, Longitude: -122.4194, Kind: .City, Population: 873_965),
        POI(Name: "San Jose", Latitude: 37.3382, Longitude: -121.8863, Kind: .City, Population: 1_013_240),
        POI(Name: "Oakland", Latitude: 37.8044, Longitude: -122.2712, Kind: .City, Population: 440_646),
        POI(Name: "Fremont", Latitude: 37.5485, Longitude: -121.9886, Kind: .City, Population: 230_504),
        POI(Name: "Santa Clara", Latitude: 37.3541, Longitude: -121.9552, Kind: .City, Population: 127_647),
        POI(Name: "Sunnyvale", Latitude: 37.3688, Longitude: -122.0363, Kind: .City, Population: 155_805),
        POI(Name: "Hayward", Latitude: 37.6688, Longitude: -122.0808, Kind: .City, Population: 162_954),
        POI(Name: "Berkeley", Latitude: 37.8715, Longitude: -122.2730, Kind: .City, Population: 124_321),
        POI(Name: "Mountain View", Latitude: 37.3861, Longitude: -122.0839, Kind: .City, Population: 82_739),
        POI(Name: "Palo Alto", Latitude: 37.4419, Longitude: -122.1430, Kind: .City, Population: 68_572),
        POI(Name: "Santa Rosa", Latitude: 38.4404, Longitude: -122.7141, Kind: .City, Population: 178_127),
        POI(Name: "Richmond", Latitude: 37.9358, Longitude: -122.3477, Kind: .City, Population: 116_448),
        POI(Name: "Concord", Latitude: 37.9780, Longitude: -122.0311, Kind: .City, Population: 129_295),
        POI(Name: "Vallejo", Latitude: 38.1041, Longitude: -122.2566, Kind: .City, Population: 126_090),
        POI(Name: "Redwood City", Latitude: 37.521037, Longitude: -122.256810, Kind: .City, Population: 84_292),
        POI(Name: "Danville", Latitude: 37.8216, Longitude: -121.9999, Kind: .City, Population: 43_100),

        //HQ
        POI(Name: "Washington DC", Latitude: 38.9073, Longitude: -77.0369, Kind: .City, Population: 702_250),

        //Japan
        POI(Name: "札幌", Latitude: 43.0618, Longitude: 141.3545, Kind: .City, Population: 1_967_361),
        POI(Name: "夕張", Latitude: 43.0568, Longitude: 141.9739, Kind: .City, Population: 6_374),
        POI(Name: "東京", Latitude: 35.6764, Longitude: 139.6500, Kind: .City, Population: 14_000_000),

        //Foothills
        POI(Name: "Placerville", Latitude: 38.7296, Longitude: -120.7985, Kind: .City, Population: 10_747),
        POI(Name: "Jackson", Latitude: 38.3488, Longitude: -120.7741, Kind: .City, Population: 5_079),

        //Sacramento Region
        POI(Name: "Sacramento", Latitude: 38.5816, Longitude: -121.4944, Kind: .City, Population: 524_943),
        POI(Name: "Elk Grove", Latitude: 38.4088, Longitude: -121.3716, Kind: .City, Population: 176_124),
        POI(Name: "Roseville", Latitude: 38.7521, Longitude: -121.2880, Kind: .City, Population: 147_773),

        //Central Valley
        POI(Name: "Stockton", Latitude: 37.9577, Longitude: -121.2908, Kind: .City, Population: 320_554),
        POI(Name: "Modesto", Latitude: 37.6391, Longitude: -120.9969, Kind: .City, Population: 218_464),
        POI(Name: "Fresno", Latitude: 36.7442, Longitude: -119.7631, Kind: .City, Population: 550_000)
    ]

    static let Landmarks: [POI] =
    [
        //Mountains and peaks
        POI(Name: "Mount Shasta", Latitude: 41.4092, Longitude: -122.1949, Kind: .Volcano, Elevation: 4322),
        POI(Name: "Mount Diablo", Latitude: 37.8816, Longitude: -121.9144, Kind: .Mountain, Elevation: 1173),
        POI(Name: "Mount Tamalpais", Latitude: 37.9235, Longitude: -122.5965, Kind: .Mountain, Elevation: 784),
        POI(Name: "Mount Hamilton", Latitude: 37.3414, Longitude: -121.6426, Kind: .Mountain, Elevation: 1283),
        POI(Name: "Mount Whitney", Latitude: 36.5785, Longitude: -118.2923, Kind: .Mountain, Elevation: 4421),
        POI(Name: "Pyramid Peak", Latitude: 38.8450, Longitude: -120.1578, Kind: .Mountain, Elevation: 3043),
        POI(Name: "富士山", Latitude: 35.35806, Longitude: 138.73, Kind: .Mountain, Elevation: 3776),

        //Bridges
        POI(Name: "Golden Gate Bridge", Latitude: 37.8199, Longitude: -122.4783, Kind: .Bridge),
        POI(Name: "Bay Bridge", Latitude: 37.8098, Longitude: -122.3647, Kind: .Bridge),
        POI(Name: "San Mateo Bridge", Latitude: 37.5907, Longitude: -122.2429, Kind: .Bridge),
        POI(Name: "Dumbarton Bridge", Latitude: 37.5048, Longitude: -122.1204, Kind: .Bridge),

        //Parks
        POI(Name: "Yosemite", Latitude: 37.8651, Longitude: -119.5383, Kind: .Park),
        POI(Name: "Point Reyes", Latitude: 38.0467, Longitude: -122.8794, Kind: .Park),
        POI(Name: "Muir Woods", Latitude: 37.8916, Longitude: -122.5808, Kind: .Forest),

        //Water features
        POI(Name: "Lake Tahoe", Latitude: 39.0968, Longitude: -120.0324, Kind: .Lake, Elevation: 1897)
    ]

    static let TestPOIs: [POI] =
    [
        POI(Name: "Home", Latitude: 38.00665, Longitude: -121.35991, Kind: .Test),
        POI(Name: "Work", Latitude: 37.521037, Longitude: -122.256810, Kind: .Test),
        POI(Name: "Old House", Latitude: 38.631662, Longitude: -120.930632, Kind: .Test)
    ]

    static var AllPOIs: [POI]
    {
        Cities + Landmarks + TestPOIs
    }
}
