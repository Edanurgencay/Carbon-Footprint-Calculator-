//
//  BagisSayfasi.swift
//  uygulama2
//
//  Created by Eda Gencay on 19.05.2024.
//

import SwiftUI



import SwiftUI

struct DonationPage: View {
    // Kullanıcı girişlerini saklamak için @State değişkenleri
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var donationAmount: String = ""
    
    // Ödeme bilgileri
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var securityCode: String = ""
    
    // Teşekkür mesajını göstermek için durum değişkeni
    @State private var showThankYouMessage = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Başlık
                Text("Ağaç Bağışı Yap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                // İsim girişi
                TextField("İsminiz", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                // E-posta girişi
                TextField("E-posta Adresiniz", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .keyboardType(.emailAddress)
                
                // Bağış miktarı girişi
                TextField("Bağış Miktarı", text: $donationAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .keyboardType(.decimalPad)
                
                // Kredi kartı numarası girişi
                TextField("Kredi Kartı Numarası", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .keyboardType(.numberPad)
                
                // Son kullanma tarihi girişi
                TextField("Son Kullanma Tarihi (MM/YY)", text: $expirationDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .keyboardType(.numbersAndPunctuation)
                
                // Güvenlik kodu girişi
                TextField("Güvenlik Kodu", text: $securityCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .keyboardType(.numberPad)
                
                // Bağış Yap düğmesi
                Button(action: {
                    // Düğmeye tıklandığında teşekkür mesajını göster
                    showThankYouMessage = true
                }) {
                    Text("Bağış Yap")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.color2)
                        .cornerRadius(15)
                }
                // Teşekkür mesajını göstermek için alert
                .alert(isPresented: $showThankYouMessage) {
                    Alert(title: Text("Teşekkürler!"), message: Text("Bağışınız için teşekkür ederiz, \(name)!"), dismissButton: .default(Text("Tamam")))
                }
                
                Spacer() // Diğer bileşenleri üstten alta sıralamak için boşluk bırakır
            }
            .navigationBarTitle("") // Navigasyon çubuğunu gizler
            .navigationBarHidden(true) // Navigasyon çubuğunu gizler
        }
    }
}


#Preview {
    DonationPage()
}
