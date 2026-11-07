//
//  DistanceFormat.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//

import Foundation

///Formats distances for the range ring labels. Metric, matching HUDViewUI's default.
enum DistanceFormat
{
    ///Meters under 1 km, one decimal of km under 10 km, whole km beyond.
    static func Short(Meters: Double) -> String
    {
        if Meters < 1000
        {
            return "\(Meters.formatted(.number.precision(.fractionLength(0)))) m"
        }
        let Kilometers = Meters / 1000.0
        let Digits = Meters < 10_000 ? 1 : 0
        return "\(Kilometers.formatted(.number.precision(.fractionLength(Digits)))) km"
    }
}
