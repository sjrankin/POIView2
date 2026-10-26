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
    let AnchorSize: Double
    ///Test only: seconds for the cardinal directions to make one full circle.
    let TestPeriod: Double
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
    func NorthAngle(At Time: Date) -> Double
    {
        let Elapsed = Time.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: TestPeriod)
        return (Elapsed / TestPeriod) * 360.0
    }
    
    var body: some View
    {
        TimelineView(.animation)
        {
            Context in
            ZStack
            {
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
                .rotationEffect(.degrees(NorthAngle(At: Context.date)))
                Circle()
                    .fill(CenterColor)
                    .frame(width: AnchorSize, height: AnchorSize)
            }
            .padding()
            //Without this the view is only as wide as the rings and the background stops there.
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundColor.ignoresSafeArea())
        }
    }
}

#Preview
{

}
