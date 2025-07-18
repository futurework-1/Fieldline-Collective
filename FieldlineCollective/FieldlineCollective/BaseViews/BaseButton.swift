import SwiftUI

struct BaseButton: View {
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(buttonTitle)
                .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                .foregroundColor(.customBrown)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.customYellow)
                .cornerRadius(30)
        }
    }
}

#Preview {
    BaseButton(buttonTitle: "NEXT", buttonAction: {})
}
