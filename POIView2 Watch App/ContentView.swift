//
//  ContentView.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//

import SwiftUI

struct ContentView: View
{
    let RingCount: Double = 4
    let Gap: Double = 40
    ///Diameter of each POI marker and of the location star.
    let IconSize: Double = 14
    ///POIs farther than this many meters are not plotted; also the distance at the outer ring.
    let MaxDistance: Double = 800_000
    ///Zoomed all the way in, the outer ring is MaxDistance times this (800 km * 0.0025 = 2 km).
    let MinRangeRatio: Double = 0.0025
    let RingLabelColor: Color = .white.opacity(0.7)
    ///Beyond this outer-ring distance in meters, only cities are plotted inside the innermost ring, to cut clutter.
    let CityOnlyRange: Double = 250_000
    ///Show the heading/GPS debug status line in the readout when no POI is selected.
    let ShowDebugStatus: Bool = false
    ///Height reserved at the bottom for the two-line readout; the radar sits in the space above it.
    let ReadoutHeight: Double = 36
    ///How close in points a tap must be to a marker to select it.
    let TapRadius: Double = 20
    let StarColor: Color = .yellow
    ///Distance past the outer ring to the center of each cardinal letter.
    let NLabelOffset: Double = 8
    ///Cardinal letters and their angles in degrees, clockwise from north.
    let Cardinals: [(Letter: String, Angle: Double)] = [("N", 0), ("E", 90), ("S", 180), ("W", 270)]
    ///Background color for the whole view.
    let BackgroundColor: Color = .indigo
    let RingColor: Color = .white
    let CardinalColor: Color = .black
    let CenterColor: Color = .black
    ///Source of the true north heading.
    @StateObject private var Compass = HeadingProvider()
    ///POIs within MaxDistance of the last location fix.
    @State private var NearbyPOIs: [POIFinder.VisiblePOI] = []
    ///The tapped POI, if any.
    @State private var SelectedID: UUID? = nil
    ///Digital Crown position: 0 is fully zoomed out (MaxDistance), 1 is fully zoomed in. Zoom is logarithmic.
    ///It starts at about 200 km (ln 0.25 / ln MinRangeRatio).
    @State private var CrownPosition: Double = 0.2314

    ///Distance in meters at the outer ring for the current zoom.
    var RangeDistance: Double
    {
        return MaxDistance * pow(MinRangeRatio, CrownPosition)
    }

    ///Distance from the center to the center of each cardinal letter.
    var LabelRadius: Double
    {
        return ((Gap * RingCount) / 2) * 1.1 + NLabelOffset
    }
    
    ///POIs to draw: within the current range. Once zoomed out past CityOnlyRange, only cities are
    ///drawn inside the innermost ring (where the clutter is); outside it every type is drawn.
    var PlottedPOIs: [POIFinder.VisiblePOI]
    {
        let ZoomedOut = RangeDistance > CityOnlyRange
        let InnerRing = RangeDistance / RingCount
        return NearbyPOIs.filter
        {
            $0.Distance <= RangeDistance && (ZoomedOut == false || $0.Distance > InnerRing || $0.Place.Kind == .City)
        }
    }
    
    ///The selected POI if it is still being plotted, with its distance from the latest fix.
    var SelectedPOI: POIFinder.VisiblePOI?
    {
        return PlottedPOIs.first { $0.id == SelectedID }
    }
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            POIView(RingCount: RingCount,
                    Gap: Gap,
                    IconSize: IconSize,
                    POIs: PlottedPOIs,
                    RangeDistance: RangeDistance,
                    RingLabelColor: RingLabelColor,
                    SelectedID: SelectedID,
                    OnSelect: { SelectedID = $0?.id },
                    TapRadius: TapRadius,
                    StarColor: StarColor,
                    Heading: Compass.Heading,
                    LabelRadius: LabelRadius,
                    Cardinals: Cardinals,
                    BackgroundColor: BackgroundColor,
                    RingColor: RingColor,
                    CardinalColor: CardinalColor,
                    CenterColor: CenterColor)
                //watchOS has no pinch gesture; the Digital Crown zooms (turn up to zoom in).
                .focusable()
                .digitalCrownRotation($CrownPosition, from: 0.0, through: 1.0, by: 0.02,
                                      sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
            //Room for two lines of text below the radar.
            ReadoutView(Selected: SelectedPOI, ShowDebugStatus: ShowDebugStatus, Compass: Compass)
                .frame(height: ReadoutHeight)
        }
        .background(BackgroundColor.ignoresSafeArea())
        .onAppear
        {
            Compass.Start()
        }
        .onChange(of: Compass.Location)
        {
            if let Here = Compass.Location
            {
                NearbyPOIs = POIFinder.POIs(Near: Here, MaxDistance: MaxDistance)
            }
        }
        .onDisappear
        {
            Compass.Stop()
        }
    }
}

#Preview
{
    ContentView()
}
