import SwiftUI

struct UseAddConsumableView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var consumableService: ConsumableService
    
    let consumable: ConsumableModel
    let actionType: ActionType // "Use" or "Add"
    
    @State private var selectedDate = Date()
    @State private var quantity: Double = 2
    @State private var showDatePicker = false
    
    enum ActionType {
        case use
        case add
        
        var title: String {
            switch self {
            case .use: return "Use"
            case .add: return "Add"
            }
        }
        
        var actionText: String {
            switch self {
            case .use: return "Used"
            case .add: return "Added"
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderElement(title: nil, stringTitle: consumable.name, withBackButton: true, withImage: false) {
                    dismiss()
                }
                .frame(height: 100)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Remaining section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Remaining")
                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                                .foregroundColor(.customYellow)
                                .underline()
                            
                            Text(consumable.remainingText)
                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Date section
                        VStack {
                            Button {
                                withAnimation {
                                    showDatePicker.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Date")
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.customYellow)
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showDatePicker {
                                VStack(spacing: 16) {
                                    // Month/Year selector
                                    HStack {
                                        Button {
                                            changeMonth(-1)
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                        
                                        Spacer()
                                        
                                        Text(monthYearString)
                                            .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button {
                                            changeMonth(1)
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.title2)
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    // Calendar grid
                                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .colorScheme(.dark)
                                        .accentColor(.customYellow)
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Image
                        Image(.eggsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                
                // Bottom section with quantity controls and save button
                VStack(spacing: 16) {
                    // Quantity controls
                    HStack(spacing: 20) {
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        } label: {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 40, height: 4)
                        }
                        
                        Text("\(Int(quantity)) \(consumable.unit)")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 18))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                        
                        Button {
                            quantity += 1
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Save button
                    Button {
                        saveAction()
                    } label: {
                        Text("Save")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 18))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.customYellow)
                            .cornerRadius(25)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    private func changeMonth(_ direction: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: direction, to: selectedDate) {
            selectedDate = newDate
        }
    }
    
    private func saveAction() {
        let description = actionType == .use ? "for feeding" : "restocked"
        
        switch actionType {
        case .use:
            consumableService.useConsumable(consumable, quantity: quantity, description: description, date: selectedDate)
        case .add:
            consumableService.addToConsumable(consumable, quantity: quantity, description: description, date: selectedDate)
        }
    }
}

#Preview {
    NavigationView {
        UseAddConsumableView(
            consumable: ConsumableModel(
                name: "Crushed wheat",
                type: .food,
                currentQuantity: 15,
                totalQuantity: 50,
                unit: "kg"),
            actionType: .use
        )
        .environmentObject(ConsumableService())
    }
} 
