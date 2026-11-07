//
//  SettingsView.swift
//  POIView2
//
//  Created by Stuart Rankin on 11/5/26.
//

import SwiftUI

///Settings for the radar. Changes go to the watch when the slider is released.
struct SettingsView: View
{
    @Environment(RadarSettings.self) private var Settings
    @Environment(WatchLink.self) private var Link

    var body: some View
    {
        @Bindable var Bound = Settings
        NavigationStack
        {
            Form
            {
                Section
                {
                    LabeledContent("Maximum range")
                    {
                        Text(Settings.MaxRangeKilometers, format: .number.precision(.fractionLength(0)))
                            + Text(" km")
                    }
                    Slider(value: $Bound.MaxRangeKilometers, in: RadarSettings.RangeLimits)
                    {
                        Text("Maximum range")
                    }
                    onEditingChanged:
                    {
                        Editing in
                        //Send once the slider is let go, not for every step of the drag.
                        if Editing == false
                        {
                            Link.Send()
                        }
                    }
                    Button("Reset to \(RadarSettings.DefaultRangeKilometers, format: .number.precision(.fractionLength(0))) km")
                    {
                        Settings.MaxRangeKilometers = RadarSettings.DefaultRangeKilometers
                        Link.Send()
                    }
                }
                header:
                {
                    Text("Radar")
                }
                footer:
                {
                    Text("Places farther away than this are not shown. This is also the distance of the outer ring when the radar is zoomed all the way out. The setting is sent to your Apple Watch.")
                }
                Section
                {
                    Toggle("Crop places to range", isOn: $Bound.CropToRange)
                }
                header:
                {
                    Text("Display")
                }
                footer:
                {
                    Text("On: only places inside the outer ring are shown. Off: places beyond the ring are drawn outside it and move as you zoom, cut off at the edges of the radar.")
                }
                Section("Apple Watch")
                {
                    Text(Link.Status)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
