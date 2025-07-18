import SwiftUI

struct HeaderElement: View {
    var title: ImageResource?
    var stringTitle: String?
    var withBackButton: Bool
    var withImage: Bool
    var backButtonAction: (() -> Void)?
    
    var body: some View {
        HStack {
            if withBackButton {
                Button {
                    backButtonAction?()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            } else {
                Circle().fill(Color.clear)
                    .frame(width: 40, height: 40)
            }
            Spacer()
            if let title {
                Image(title)
                    .resizable()
                    .scaledToFit()
            } else if let stringTitle {
                Text(stringTitle)
                    .font(FontFamily.Moderustic.bold.swiftUIFont(size: 26))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.customYellow)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 250)
            }
            Spacer()
            if withImage {
                Image(.eggImg)
                    .resizable()
                    .frame(width: 40, height: 40)
            } else {
                Circle().fill(Color.clear)
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    HeaderElement(title: .settingTitle, withBackButton: true, withImage: false, backButtonAction: {})
}
