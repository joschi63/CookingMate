//
//  StepListView.swift
//  CookingMate
//
//  Created by Johann Schneider on 29.08.26.
//

import SwiftUI

struct StepListView: View {
    @Binding var steps: [Step]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Zubereitung")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                
                Divider()
            }
            
            ForEach($steps) { $step in
                VStack(alignment: .leading) {
                    StepView(step: $step)
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    let mockSteps = [Step(id: UUID(), description: "cutting the onions in small pieces \n mois", order: 1)]
    StepListView(steps: .constant(mockSteps))
}
