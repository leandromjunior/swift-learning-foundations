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

// Resizing images to fit the screen using GeometryReader
struct ResizingImageWithGeometryReader: View {
    var body: some View {
//        GeometryReader { proxy in
//            Image(.golden)
//                .resizable()
//                .scaledToFit()
//                .frame(width: proxy.size.width * 0.8)
//        }
        
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)

            GeometryReader { proxy in
                Image(.golden)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

// Understanding frames and coordinates inside GeometryReader

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom Center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local Center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct FramesAndCoordinates: View {
    var body: some View {
        // To uncomment the code below, comment the active code in this struct
//        GeometryReader { proxy in
//            Text("Hello, World!")
//                .frame(width: proxy.size.width * 0.9)
//                .background(.red)
//        }
//        
//        Text("More Text")
//            .background(.blue)
        
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

// ScrollView effects using visualEffect() and scrollTargetBehavior()
struct ScrollViewEffect: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    Text("Number \(num)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned) // Makes the scroll stop in a view after a scroll gesture. If the user do not scroll enough the preview view stay at the same place.
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
    //AbsolutePositioning()
    //ResizingImageWithGeometryReader()
    //FramesAndCoordinates()
    ScrollViewEffect()
    //ContentView()
}
