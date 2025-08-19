//
//  MissionView.swift
//  Moonshot
//
//  Created by Leandro Motta Junior on 16/08/25.
//

import SwiftUI

//Starting code made for the challenge [item 2] - Day 42
struct LineDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 3)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct HorizontalScrolling: View {
    
    var contentCrew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(contentCrew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.circle)
                                .overlay(
                                    Circle()
                                        .strokeBorder(.gray, lineWidth: 2)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
//Ending code made for the challenge [item 2] - Day 42

// Day 41
struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.7
                    }
                    .padding(.top)
                
                // Starting code made for the challenge [item 1] - Day 42
                Text(mission.formattedLaunchDate)
                    .padding(.top, 10)
                    .foregroundStyle(.white.opacity(0.5))
                // Ending code made for the challenge [item 1] - Day 42
                
                
                VStack(alignment: .leading) {
                    // Adding a visual divider
                    LineDivider() //View developed for day 42 challenge
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    // Adding a visual divider
                    LineDivider() //View developed for day 42 challenge
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                // Starting code made for the challenge [item 2] - Day 42
                HorizontalScrolling(contentCrew: crew)
                // Ending code made for the challenge [item 2] - Day 42
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[3], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

// Notes:

/* The code HorizontalScrolling on line 105 replaced the following code:
 
 ScrollView(.horizontal, showsIndicators: false) {
     HStack {
         ForEach(crew, id: \.role) { crewMember in
             NavigationLink {
                 AstronautView(astronaut: crewMember.astronaut)
             } label: {
                 HStack {
                     Image(crewMember.astronaut.id)
                         .resizable()
                         .frame(width: 104, height: 72)
                         .clipShape(.circle)
                         .overlay(
                             Circle()
                                 .strokeBorder(.gray, lineWidth: 2)
                         )
                     
                     VStack(alignment: .leading) {
                         Text(crewMember.astronaut.name)
                             .foregroundStyle(.white)
                             .font(.headline)
                         Text(crewMember.role)
                             .foregroundStyle(.white.opacity(0.5))
                     }
                 }
                 .padding(.horizontal)
             }
         }
     }
 }
*/
