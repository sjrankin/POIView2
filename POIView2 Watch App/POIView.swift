//
//  POIView.swift
//  POIView2 Watch App
//
//  Created by Stuart Rankin on 10/26/26.
//

import SwiftUI

struct POIView: View
{
    let RingCount: Double
    let Gap: Double
    ///Diameter of each POI marker and of the location star.
    let IconSize: Double
    ///POIs within the largest range; those beyond RangeDistance are skipped when drawing.
    let POIs: [POIFinder.VisiblePOI]
    ///Distance in meters at the outer ring (changes with zoom).
    let RangeDistance: Double
    let RingLabelColor: Color
    ///The POI currently selected by a tap, drawn with a white outline.
    let SelectedID: UUID?
    ///Called with the tapped POI, or nil when the tap hit no marker.
    let OnSelect: (POIFinder.VisiblePOI?) -> Void
    ///How close in points a tap must be to a marker's center to select it (a fingertip is bigger than the icon).
    let TapRadius: Double
    let StarColor: Color
    ///Direction the top of the watch faces, in degrees clockwise from true north.
    let Heading: Double
    ///Distance from the center to the center of each cardinal letter.
    let LabelRadius: Double
    ///Cardinal letters and their angles in degrees, clockwise from north.
    let Cardinals: [(Letter: String, Angle: Double)]
    /// Background color (mainly for debug).
    let BackgroundColor: Color
    let RingColor: Color
    let CardinalColor: Color
    let CenterColor: Color
    
    ///Angle in degrees, clockwise from up (0 is due north at the top of the screen).
    ///Turning the watch clockwise moves north counter-clockwise on screen.
    var NorthAngle: Double
    {
        return Heading * -1
    }

    ///Radius of the outer ring, which is RangeDistance.
    var PlotRadius: Double
    {
        return (Gap * RingCount) / 2
    }

    ///Offset from the ring center for a POI when north is straight up; the dial rotation turns it to the compass.
    func MarkerOffset(For Item: POIFinder.VisiblePOI) -> CGSize
    {
        let Ratio = min(Item.Distance / RangeDistance, 1.0)
        let Angle = Item.Bearing * .pi / 180
        return CGSize(width: PlotRadius * Ratio * sin(Angle), height: PlotRadius * Ratio * cos(Angle) * -1)
    }

    ///Rotates a point clockwise on screen by Degrees (y grows downward).
    func Rotated(_ Point: CGSize, By Degrees: Double) -> CGSize
    {
        let Angle = Degrees * .pi / 180
        return CGSize(width: Point.width * cos(Angle) - Point.height * sin(Angle),
                      height: Point.width * sin(Angle) + Point.height * cos(Angle))
    }

    ///The marker nearest to a tap, within TapRadius. Tap is relative to the ring center.
    ///Markers sit on the dial, so each one's screen position is its offset rotated by NorthAngle.
    func MarkerNear(Tap: CGSize) -> POIFinder.VisiblePOI?
    {
        var Best: POIFinder.VisiblePOI? = nil
        var BestDistance = TapRadius
        for Item in POIs
        {
            let Spot = Rotated(MarkerOffset(For: Item), By: NorthAngle)
            let Away = hypot(Spot.width - Tap.width, Spot.height - Tap.height)
            if Away <= BestDistance
            {
                Best = Item
                BestDistance = Away
            }
        }
        return Best
    }

    var body: some View
    {
        ZStack
        {
            //Drawn first so everything else is on top of the distance labels. Each label sits just inside its ring.
            ForEach(1 ... Int(RingCount), id: \.self)
            {
                index in
                Text(DistanceFormat.Short(Meters: RangeDistance * Double(index) / RingCount))
                    .font(.system(size: 9))
                    .foregroundStyle(RingLabelColor)
                    .offset(y: (Gap * Double(index) / 2) * -1 + 8)
            }
            ForEach(1 ... Int(RingCount), id: \.self)
            {
                index in
                Circle()
                    .stroke(RingColor, lineWidth: 2)
                    .frame(width: CGFloat(index) * Gap,
                           height: CGFloat(index) * Gap)
            }
            ZStack
            {
                ForEach(Cardinals, id: \.Letter)
                {
                    Cardinal in
                    //Each letter is upright at its own angle, so its bottom always points to the center.
                    //offset doesn't move the layout frame, so the center anchor is the ring center.
                    Text(Cardinal.Letter)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(CardinalColor)
                        .offset(y: LabelRadius * -1)
                        .rotationEffect(.degrees(Cardinal.Angle))
                }
            }
            .rotationEffect(.degrees(NorthAngle))
            //Markers sit on the same rotating dial as the cardinals but stay upright.
            ZStack
            {
                ForEach(POIs)
                {
                    Item in
                    POIMarker(Kind: Item.Place.Kind, Size: IconSize, IsSelected: Item.id == SelectedID)
                        .rotationEffect(.degrees(Heading))
                        .offset(MarkerOffset(For: Item))
                }
            }
            .rotationEffect(.degrees(NorthAngle))
            LocationStar(Size: IconSize, StarColor: StarColor)
            //Transparent tap layer centered on the rings; its local origin is the top-left, so subtract the center.
            Color.clear
                .frame(width: PlotRadius * 2 + IconSize * 2, height: PlotRadius * 2 + IconSize * 2)
                .contentShape(.rect)
                .gesture(SpatialTapGesture().onEnded
                {
                    Tap in
                    let Half = PlotRadius + IconSize
                    OnSelect(MarkerNear(Tap: CGSize(width: Tap.location.x - Half, height: Tap.location.y - Half)))
                })
        }
        .padding()
        //Without this the view is only as wide as the rings and the background stops there.
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundColor.ignoresSafeArea())
    }
}

#Preview
{

}
