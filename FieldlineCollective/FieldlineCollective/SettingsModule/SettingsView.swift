import SwiftUI
import WebKit

struct SettingsView: View {
    @AppStorage("notificationIsOn") private var notificationIsOn = false
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .settingTitle, withBackButton: false, withImage: false, backButtonAction: nil)
                    .frame(height: 80)
                
                NavigationLink(destination: MeasurementView()) {
                    Text("Setting units of measurement")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Spacer()
                        Text("Notifications")
                            .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                            .foregroundColor(.white)
                            .padding(8)
                            .padding(.trailing)
                           
                        Toggle("", isOn: $notificationIsOn)
                            .labelsHidden()
                        Spacer()
                    }
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: WebViewPage(title: "Privacy Policy", url: URL(string: "https://sites.google.com/view/fieldlinecollective/privacy-policy")!)) {
                    Text("Privacy Policy")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: WebViewPage(title: "About the Developer", url: URL(string: "https://sites.google.com/view/fieldlinecollective/app-support")!)) {
                    Text("About the developer")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SettingsView()
}

struct WebViewPage: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let url: URL
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.backButton)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 40, height: 40)
                }
                .padding()
                
                WebView(url: url)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(8)
            }
        }
        .navigationBarHidden(true)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


//navigationSettingsCard(title: "Privacy & Security") {
//                          WebViewPage(title: "Privacy Policy", url: URL(string: "https://www.google.com")!)
//                      }
//                      
//                      navigationSettingsCard(title: "Developer Info") {
//                          WebViewPage(title: "About the Developer", url: URL(string: "https://www.yahoo.com")!)
//                      }
