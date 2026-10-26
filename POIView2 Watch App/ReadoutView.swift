//
//  ReadoutView.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//

import SwiftUI

///Two lines at the bottom of the screen: the selected POI's name with its distance beneath it,
///or the heading/GPS status line when nothing is selected.
struct ReadoutView: View
{
    let Selected: POIFinder.VisiblePOI?
    ///Show the debug status line when nothing is selected.
    let ShowDebugStatus: Bool
    @ObservedObject var Compass: HeadingProvider

    var body: some View
    {
        ZStack
        {
            //An empty view ignores a fixed frame height, so this keeps the space reserved when there is no text;
            //otherwise the radar would move down into it and jump up when text appears.
            Color.clear
            if let Item = Selected
            {
                VStack(spacing: 0)
                {
                    Text(Item.Place.Name)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text(DistanceFormat.Short(Meters: Item.Distance))
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(1)
                }
            }
            else if ShowDebugStatus
            {
                StatusLine(Compass: Compass)
            }
        }
    }
}
