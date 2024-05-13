import SwiftUI

struct SettingsPage: View {
    @State private var hapticFeedbackEnabled = true
    @EnvironmentObject var authViewModel: authViewModel
    @State private var logOut = false
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Hesap")) {
                    HStack {
                        Text("İsim")
                        Spacer()
                        Text("Eda Gencay")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("edanurgencay@hotmail.com")
                            .foregroundColor(.gray)
                    }
                   
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("Çıkış yap")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Uygulama")) {
                    NavigationLink(destination: NotificationsPage()) {
                        Text("Bildirimler")
                    }
                    NavigationLink(destination: PrivacySettingsView()) {
                        Text("Gizlilik Ayarları")
                    }
                    HStack {
                        Text("Versiyon")
                        Spacer()
                        Text("2.8.0 (6ce89bcb8)")
                            .foregroundColor(.gray)
                    }
                }
            }
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Çıkış Yap"),
                    message: Text("Çıkış yapmak istediğinizden emin misiniz?"),
                    primaryButton: .destructive(Text("Evet")) {
                        authViewModel.logout()
                        logOut = true
                        print("Çıkış yapıldı")
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationBarHidden(true)
    }
}


struct PrivacySettingsView: View {
    var body: some View {
        Text("Gizlilik Ayarları")
    }
}





#Preview {
    SettingsPage()
}
