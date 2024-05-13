import SwiftUI

struct ContentView: View {
    @StateObject var AuthViewModel = authViewModel()

    var body: some View {
        NavigationView {
            if AuthViewModel.isLoggedIn {
                TabView {
                    MainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Anasayfa")
                        }
                        .environmentObject(AuthViewModel)

                    DonationPage()
                        .tabItem {
                            Image(systemName: "tree.circle")
                            Text("Bağış yap")
                        }
                        .environmentObject(AuthViewModel)

                    SettingsPage()
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Ayarlar")
                        }
                        .environmentObject(AuthViewModel)
                }
                .navigationBarBackButtonHidden(true)
            } else {
                WelcomePage()
                    .environmentObject(AuthViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(authViewModel())
    }
}
