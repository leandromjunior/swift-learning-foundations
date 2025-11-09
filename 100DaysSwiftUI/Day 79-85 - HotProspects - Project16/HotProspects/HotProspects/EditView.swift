//
//  EditView.swift
//  HotProspects
//
//  Created by Leandro Motta Junior on 06/11/25.
//

import SwiftUI
import SwiftData

struct EditView: View {
    @Bindable var prospect: Prospect
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAdress)
        }
        .navigationTitle("Edit Contact")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Teste", emailAdress: "teste@teste.com", isContacted: true, dateAdded: .now)
        return EditView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
