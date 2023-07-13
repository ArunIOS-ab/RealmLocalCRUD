//
//  ContentView.swift
//  RealmLocalCRUD
//
//  Created by Ab on 27/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(realmManager.courses, id: \.id) { course in
                HStack {
                    Text(course.title)
                    Spacer()
                    Image(systemName: "trash") .onTapGesture {
                        realmManager.deleteCourse(id: course.id)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
