//
//  ContentView.swift
//  TimeInWords WatchKit Extension
//
//  Created by Christian Naths on 2021-12-27.
//

import SwiftUI

class Helper {
    static func getText(chr: String, on: Bool = false) -> Text {
        let color = on ? Color(.white) : Color(.darkGray)

//        print(["on", on, n ,chr])

        return Text(chr)
            .font(.system(size: 13))
            .foregroundColor(color)
    }

    static func getTime() -> [Int] {
        let time = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let second = calendar.component(.second, from: time)
        return [hour, minute, second]
    }

    static func roundMinute(hour _: Int, minute: Int) -> Int {
        let fr = Float(minute) / 5
        return Int(round(fr) * 5)
    }

    static func roundHour(hour: Int, minute: Int) -> Int {
        if minute <= 30 { return hour }
        let nextHour = hour + 1
        return nextHour < 24 ? nextHour : 0
    }

    static func getChrState(hour: Int, minute: Int) -> [Int] {
        let itis = [0, 1, 3, 4]
        let roundedMinute = Helper.roundMinute(hour: hour, minute: minute)
        let roundedHour = Helper.roundHour(hour: hour, minute: roundedMinute)

        

        let minuteWords: [String: [Int]] = [
            "five": [16, 17, 18, 19],
            "ten": [27, 28, 29],
            "quarter": [20, 21, 22, 23, 24, 25, 26],
            "twenty": [10, 11, 12, 13, 14, 15],
            "half": [6, 7, 8, 9],
        ]

        let minuteSuffixes: [String: [Int]] = [
            "past": [32, 33, 34, 35],
            "to": [30, 31],
        ]

        let minutes: [Int: [Int]] = [
            0: [],
            5: minuteWords["five"]! + minuteSuffixes["past"]!,
            10: minuteWords["ten"]! + minuteSuffixes["past"]!,
            15: minuteWords["quarter"]! + minuteSuffixes["past"]!,
            20: minuteWords["twenty"]! + minuteSuffixes["past"]!,
            25: minuteWords["twenty"]! + minuteWords["five"]! + minuteSuffixes["past"]!,
            30: minuteWords["half"]! + minuteSuffixes["past"]!,
            35: minuteWords["twenty"]! + minuteWords["five"]! + minuteSuffixes["to"]!,
            40: minuteWords["twenty"]! + minuteSuffixes["to"]!,
            45: minuteWords["quarter"]! + minuteSuffixes["to"]!,
            50: minuteWords["ten"]! + minuteSuffixes["to"]!,
            55: minuteWords["five"]! + minuteSuffixes["to"]!,
            60: [],
        ]

        let hourWords: [String: [Int]] = [
            "one": [50, 51, 52],
            "two": [57, 58, 59],
            "three": [60, 61, 62, 63, 64],
            "four": [80, 81, 82, 83],
            "five": [66, 67, 68, 69],
            "six": [37, 38, 39],
            "seven": [40, 41, 42, 43, 44],
            "eight": [70, 71, 72, 73, 74],
            "nine": [46, 47, 48, 49],
            "ten": [54, 55, 56],
            "eleven": [84, 85, 86, 87, 88, 89],
            "twelve": [91, 92, 93, 94, 95, 96],
        ]

        let hourSuffixes: [String: [Int]] = [
            "am": [106, 107],
            "pm": [108, 109],
        ]

        let hours: [Int: [Int]] = [
            0: hourWords["twelve"]! + hourSuffixes["am"]!,
            1: hourWords["one"]! + hourSuffixes["am"]!,
            2: hourWords["two"]! + hourSuffixes["am"]!,
            3: hourWords["three"]! + hourSuffixes["am"]!,
            4: hourWords["four"]! + hourSuffixes["am"]!,
            5: hourWords["five"]! + hourSuffixes["am"]!,
            6: hourWords["six"]! + hourSuffixes["am"]!,
            7: hourWords["seven"]! + hourSuffixes["am"]!,
            8: hourWords["eight"]! + hourSuffixes["am"]!,
            9: hourWords["nine"]! + hourSuffixes["am"]!,
            10: hourWords["ten"]! + hourSuffixes["am"]!,
            11: hourWords["eleven"]! + hourSuffixes["am"]!,
            12: hourWords["twelve"]! + hourSuffixes["pm"]!,
            13: hourWords["one"]! + hourSuffixes["pm"]!,
            14: hourWords["two"]! + hourSuffixes["pm"]!,
            15: hourWords["three"]! + hourSuffixes["pm"]!,
            16: hourWords["four"]! + hourSuffixes["pm"]!,
            17: hourWords["five"]! + hourSuffixes["pm"]!,
            18: hourWords["six"]! + hourSuffixes["pm"]!,
            19: hourWords["seven"]! + hourSuffixes["pm"]!,
            20: hourWords["eight"]! + hourSuffixes["pm"]!,
            21: hourWords["nine"]! + hourSuffixes["pm"]!,
            22: hourWords["ten"]! + hourSuffixes["pm"]!,
            23: hourWords["eleven"]! + hourSuffixes["pm"]!,
        ]

        return itis + minutes[roundedMinute]! + hours[roundedHour]!
    }
    
//    static func getClockText(hour: Int, minute: Int) -> [Int] {
//    }
}

struct ContentView: View {
    @State private var hour = 0
    @State private var minute = 0
    @State private var second = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var symbols = [
        "I", "T", "P", "I", "S", "A", "H", "A", "L", "F",
        "T", "W", "E", "N", "T", "Y", "F", "I", "V", "E",
        "Q", "U", "A", "R", "T", "E", "R", "T", "E", "N",
        "T", "O", "P", "A", "S", "T", "R", "S", "I", "X",
        "S", "E", "V", "E", "N", "A", "N", "I", "N", "E",
        "O", "N", "E", "D", "T", "E", "N", "T", "W", "O",
        "T", "H", "R", "E", "E", "O", "F", "I", "V", "E",
        "E", "I", "G", "H", "T", "A", "A", "M", "P", "M",
        "F", "O", "U", "R", "E", "L", "E", "V", "E", "N",
        "R", "T", "W", "E", "L", "V", "E", "M", "L", "C",
        "E", "I", "G", "H", "T", "•", "A", "M", "P", "M",
    ]



    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 10)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: items) {
                ForEach(symbols.indices, id: \.self) { i in

                    let on = Helper.getChrState(hour: hour, minute: minute).contains(i)

                    Helper.getText(chr: symbols[i], on: on).onReceive(timer) { _ in
                        self.hour = Helper.getTime()[0]
                        self.minute = Helper.getTime()[1]
                        self.second = Helper.getTime()[2]
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
