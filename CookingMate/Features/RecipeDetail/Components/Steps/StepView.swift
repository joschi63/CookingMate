//
//  StepView.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import SwiftUI

struct StepView: View {
    
    @Binding var step: Step
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Circle()
                    .frame(width: 25)
                    .foregroundStyle(Color.cyan)
                Text("\(step.order)")
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .frame(alignment: .center)
            .padding(.leading, 4)
            
            Text(step.description)
                .padding(.leading, 5)
            
            Spacer()
        }
        //.padding(isEditing ? 12 : 0)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                //.opacity(isEditing ? 1 : 0)
                .opacity(0)
        )
        .padding(.vertical, 0)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 5))
        .listRowBackground(Color.clear)
    }
}

#Preview {
    let step = Step(id: UUID(), description: "cutting the onions in small pieces \n mois", order: 1)
    StepView(step: .constant(step))
}
