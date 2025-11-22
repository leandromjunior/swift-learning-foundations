//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Leandro Motta Junior on 22/11/25.
//

import SwiftUI

// Alignment and Alignment Guides
struct AlignmentAndAlignmentGuides: View {
    var body: some View {
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .topLeading)
        
        HStack(alignment: .lastTextBaseline) { //The .lastTextBaseline makes the smaller words be aligned by the bottom with the bigger words
            Text("Live")
                .font(.caption)
            Text("Long")
            Text("and")
                .font(.title)
            Text("Prosper")
                .font(.largeTitle)
        }
    }
}

struct AlignmentAndAlignmentGuides2: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
                .alignmentGuide(.leading) { dimension in
                    dimension[.trailing]
                }
            Text("This is a longer line of text")
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

struct AlignmentAndAlignmentGuides3: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

// How to create a custom alignment guide
extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignment: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@golden")
                    .alignmentGuide(.midAccountAndName) { dimension in
                        dimension[VerticalAlignment.center]
                    }
                Image(.golden)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full Name:")
                Text("LION")
                    .alignmentGuide(.midAccountAndName) { dimension in
                        dimension[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

// Absolute positioning for SwiftUI views
struct AbsolutePositioning: View {
    var body: some View {
//        Text("Hello, World")
//            .background(.red)
//            .position(x: 100, y: 100)
        
        Text("Hello, World")
            .offset(x: 100, y: 100)
            .background(.red)
            
            
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    //AlignmentAndAlignmentGuides()
    //AlignmentAndAlignmentGuides2()
    //AlignmentAndAlignmentGuides3()
    //CustomAlignment()
    AbsolutePositioning()
    //ContentView()
}
