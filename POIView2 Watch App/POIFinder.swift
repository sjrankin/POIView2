//
//  POIFinder.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//

import Foundation
import CoreLocation

///Finds the points of interest within range of a location.
struct POIFinder
{
    ///A POI with its distance and bearing from the user.
    struct VisiblePOI: Identifiable
    {
        let Place: POI
        ///Meters from the user.
        let Distance: Double
        ///Degrees clockwise from true north (0 ... 360).
        let Bearing: Double

        var id: UUID
        {
            Place.id
        }
    }

    ///All POIs no farther than MaxDistance meters from Location, farthest first so the nearest are drawn on top.
    static func POIs(Near Location: CLLocation, MaxDistance: Double) -> [VisiblePOI]
    {
        let Found: [VisiblePOI] = NorthernCaliforniaData.AllPOIs.compactMap
        {
            Item in
            let Target = CLLocation(latitude: Item.Coordinate.latitude, longitude: Item.Coordinate.longitude)
            let Distance = Location.distance(from: Target)
            if Distance > MaxDistance
            {
                return nil
            }
            return VisiblePOI(Place: Item, Distance: Distance,
                              Bearing: Bearing(From: Location.coordinate, To: Item.Coordinate))
        }
        return Found.sorted { $0.Distance > $1.Distance }
    }

    ///Initial great-circle bearing in degrees clockwise from true north.
    static func Bearing(From Start: CLLocationCoordinate2D, To End: CLLocationCoordinate2D) -> Double
    {
        let Lat1 = Start.latitude * .pi / 180
        let Lat2 = End.latitude * .pi / 180
        let DeltaLon = (End.longitude - Start.longitude) * .pi / 180
        let Y = sin(DeltaLon) * cos(Lat2)
        let X = cos(Lat1) * sin(Lat2) - sin(Lat1) * cos(Lat2) * cos(DeltaLon)
        let Degrees = atan2(Y, X) * 180 / .pi
        return (Degrees + 360).truncatingRemainder(dividingBy: 360)
    }
}
