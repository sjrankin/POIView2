//
//  POI.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//  Adapted from POI in HUDViewUI. Route waypoints are intentionally not ported.
//

import SwiftUI
import CoreLocation

///A point of interest (landmark or city).
struct POI: Identifiable
{
    let id = UUID()
    let Name: String
    let Coordinate: CLLocationCoordinate2D
    let Kind: POIType
    let Elevation: Double?
    let Population: Int?

    init(Name: String, Latitude: Double, Longitude: Double, Kind: POIType,
         Elevation: Double? = nil, Population: Int? = nil)
    {
        self.Name = Name
        self.Coordinate = CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude)
        self.Kind = Kind
        self.Elevation = Elevation
        self.Population = Population
    }
}

///Type of point of interest.
enum POIType: String, CaseIterable
{
    case City
    case Mountain
    case Bridge
    case Park
    case Lake
    case Forest
    case Volcano
    case River
    case Test

    ///SF Symbol drawn inside the marker.
    var Icon: String
    {
        switch self
        {
            case .City:
                return "building.2.fill"

            case .Mountain, .Volcano:
                return "triangle.fill"

            case .Bridge:
                return "water.waves.and.arrow.trianglehead.up"

            case .Park, .Forest:
                return "tree.fill"

            case .Lake:
                return "drop.fill"

            case .River:
                return "water.waves"

            case .Test:
                return "circle.and.line.horizontal"
        }
    }

    var MarkerColor: Color
    {
        switch self
        {
            case .City:
                return .orange

            case .Mountain:
                return .brown

            case .Bridge, .Volcano:
                return .red

            case .Park, .Forest:
                return .green

            case .Lake, .River:
                return .blue

            case .Test:
                return .purple
        }
    }
}
