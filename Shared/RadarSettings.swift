//
//  RadarSettings.swift
//  POIView2
//
//  Created by Stuart Rankin on 11/5/26.
//

import Foundation
import Observation

///User settings for the radar. The iPhone is where they are changed; `WatchLink` sends them to the watch, which keeps its own copy.
@MainActor
@Observable
final class RadarSettings
{
    ///The range, in kilometers, of the radar's outer ring when fully zoomed out. Places farther away are not shown.
    static let DefaultRangeKilometers = 800.0
    static let RangeLimits = 25.0 ... 2000.0
    static let RangeStep = 25.0

    ///The farthest distance, in kilometers, at which places are shown. Always within `RangeLimits`.
    var MaxRangeKilometers: Double
    {
        didSet
        {
            let Clamped = RadarSettings.Clamp(MaxRangeKilometers)
            if Clamped != MaxRangeKilometers
            {
                MaxRangeKilometers = Clamped
                return
            }
            Defaults.set(MaxRangeKilometers, forKey: RadarSettings.RangeKey)
        }
    }

    ///True to show only places inside the radar's outer ring. False draws places beyond the ring outside it, moving as the zoom changes.
    ///Used on the iPhone only.
    var CropToRange: Bool
    {
        didSet
        {
            Defaults.set(CropToRange, forKey: RadarSettings.CropKey)
        }
    }

    ///The maximum range in meters.
    var MaxDistance: Double
    {
        MaxRangeKilometers * 1000
    }

    @ObservationIgnored
    private let Defaults: UserDefaults

    nonisolated static let RangeKey = "MaxRangeKilometers"
    nonisolated static let CropKey = "CropToRange"

    ///- Parameter Defaults: Where the setting is kept. Tests pass their own suite.
    init(Defaults: UserDefaults = .standard)
    {
        self.Defaults = Defaults
        let Saved = Defaults.object(forKey: RadarSettings.RangeKey) as? Double
        MaxRangeKilometers = RadarSettings.Clamp(Saved ?? RadarSettings.DefaultRangeKilometers)
        //Off by default: places beyond the outer ring are drawn outside it.
        CropToRange = Defaults.object(forKey: RadarSettings.CropKey) as? Bool ?? false
    }

    ///Forces a range into `RangeLimits` and onto a multiple of `RangeStep`; a value that is not a number gives the default.
    nonisolated static func Clamp(_ Kilometers: Double) -> Double
    {
        guard Kilometers.isFinite else
        {
            return DefaultRangeKilometers
        }
        //Snapped to the step here rather than by the slider, because a stepped slider draws a row of tick marks under it.
        let Snapped = (Kilometers / RangeStep).rounded() * RangeStep
        return min(max(Snapped, RangeLimits.lowerBound), RangeLimits.upperBound)
    }
}
