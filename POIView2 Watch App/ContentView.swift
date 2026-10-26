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
    let AnchorSize: Double = 10
    ///Test only: seconds for the cardinal directions to make one full circle.
    let TestPeriod: Double = 20
    ///Distance past the outer ring to the center of each cardinal letter.
    let NLabelOffset: Double = 8
    ///Cardinal letters and their angles in degrees, clockwise from north.
    let Cardinals: [(Letter: String, Angle: Double)] = [("N", 0), ("E", 90), ("S", 180), ("W", 270)]
    ///Background color for the whole view.
    let BackgroundColor: Color = .indigo
    let RingColor: Color = .white
    let CardinalColor: Color = .black
    let CenterColor: Color = .black
    
    ///Distance from the center to the center of each cardinal letter.
    var LabelRadius: Double
    {
        return ((Gap * RingCount) / 2) * 1.1 + NLabelOffset
    }
    
    var body: some View
    {
        POIView(RingCount: RingCount,
                Gap: Gap,
                AnchorSize: AnchorSize,
                TestPeriod: TestPeriod,
                LabelRadius: LabelRadius,
                Cardinals: Cardinals,
                BackgroundColor: BackgroundColor,
                RingColor: RingColor,
                CardinalColor: CardinalColor,
                CenterColor: CenterColor)
    }
}

#Preview
{
    ContentView()
}
