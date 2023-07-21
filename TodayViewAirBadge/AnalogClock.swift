
//  AnalogClockView.swift
//  AirBadge
//
//  Created by Luca Navarra on 21/07/23.
//

import SwiftUI



struct AnalogClock: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                //Get the current hand angles
                let clock = getAngles(for: timeline.date)

                //Figure out drawing space
                let rect = CGRect(origin: .zero, size: size)
                let r = min(size.width, size.height)/2

                //Calculate constants
                let border = r/6
                let hoursLength = r/3.5
                let minLength = r/2
                let secLength = r * 1
                let secWidth = r / 25

                //Outer ring of the clock
                ctx.stroke(Circle()
                    .inset(by: border / 2)
                    .path(in: rect),
                           with: .color(.primary),
                           lineWidth: border)

                //Move to the middle to put the hands in position
                ctx.translateBy(x: rect.midX, y: rect.midY)

                //Draw the hands using the correct angle and lenght
                drawHand(in: ctx, radius: r, lenght: minLength, angle: clock.minute)
                drawHand(in: ctx, radius: r, lenght: hoursLength, angle: clock.hour)

                //Draw the second's hand
                let secondLine = Capsule()
                    .offset(x: 0, y: -r/6)
                    .rotation(clock.second, anchor: .top)
                    .path(in: CGRect(x: -secWidth/2, y:0, width: secWidth, height: secLength))

                ctx.fill(secondLine, with: .color(.red))

            }
        }
    }

    private func drawHand(in context: GraphicsContext, radius: Double, lenght: Double, angle: Angle){
        let width = radius/30 //Width of the clock's hand
        let stalk = Rectangle().rotation(angle, anchor: .top)
            .path(in: CGRect(x: -width/2, y: 0, width: width, height: lenght))
        context.fill(stalk, with: .color(.primary))

        //Add a capsule at the end of the hand
        let hand = Capsule()
            .offset(x: 0, y: radius/5)
            .rotation(angle, anchor: .top)
            .path(in: CGRect(x: -width, y: 0, width: width*2, height: lenght))

        context.fill(hand, with: .color(.primary))
    }

    private func getAngles(for date: Date) -> (hour: Angle, minute: Angle, second: Angle) {
        //Extract components from actual time
        let parts = Calendar.current.dateComponents(
            [.hour, .minute, .second, .nanosecond], from: .now)
        let hours = Double(parts.hour ?? 0)
        let minutes = Double(parts.minute ?? 0)
        let seconds = Double(parts.second ?? 0)
        let nanoseconds = Double(parts.nanosecond ?? 0)

        //Convert components to angles
        let hoursAngle = Angle.degrees(30 * (hours + minutes/60) + 180) //Use 30 * hours + 180 for moving not smoothly
        let minutesAngle = Angle.degrees(6 * (minutes + seconds/60) + 180) //Use 6 * minutes + 180 for moving not smoothly
        let secondsAngle = Angle.degrees(6 * (seconds + nanoseconds/1_000_000_000) + 180) //Use 6 * seconds + 180 for moving not smoothly

        //Return angles
        return(hoursAngle, minutesAngle, secondsAngle)
    }
}

#Preview {
    AnalogClock()
}
