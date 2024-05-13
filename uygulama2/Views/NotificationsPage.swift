import SwiftUI
import UserNotifications

struct NotificationsPage: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "lightbulb")
                .resizable()
                .frame(width: 50, height: 60)
                .foregroundColor(.color)
                .padding(.bottom, 20)
            
            Text("Bildirimleri Etkinleştir")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Bu aygıtta bildirimler etkinleştirilmedi.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            
            Button(action: {
                requestNotificationPermission()
            }) {
                Text("Bildirimlere izin ver")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.color1)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        
        .navigationBarTitle("Notifications", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            // Close action
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
        })
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }
}

#Preview {
    NotificationsPage()
}
