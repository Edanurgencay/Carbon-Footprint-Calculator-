import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    
    @State var email = ""
    @State var password = ""
    @State private var showHomePage = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSignUpPage = false
    
    var body: some View {
        

            
        NavigationStack {
            ZStack {
                    
                    VStack {
                        Image("app-logo-green")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100 , height: 150)
                     
                        Text("Hoşgeldiniz")
                            .font(.custom("RobotoSlab-Regular_Bold", size: 30))
                            .padding(.bottom , 5)
                    
                        
                        TextField("example@gmail", text:$email)
                            .modifier(Custommodifier())
                        SecureField("*******", text:$password)
                            .modifier(Custommodifier())
                        
                        Button(action: {
                            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                if error == nil {
                                    print("başarıyla giriş yapıldı")
                                    showHomePage = true
                                } else {
                                    alertMessage = error?.localizedDescription ?? "Bilinmeyen bir hata oluştu."
                                    showAlert = true
                                }
                            }
                        }, label: {
                            Text("Giriş Yap")
                                .foregroundColor(.white)
                                .font(.custom("RobotoSlab-Regular_Bold", size: 16))
                                .frame(width: 370, height: 40)
                                .background(Color.color4.opacity(0.85))
                                .cornerRadius(15)
                        }).navigationDestination(isPresented: $showHomePage) {
                            ContentView()
                        }
                     
                        
                        Button(action: {
                            guard !email.isEmpty else {
                                alertMessage = "Lütfen bir e-posta adresi girin."
                                showAlert = true
                                return
                            }
                            
                            FirebaseAuth.Auth.auth().sendPasswordReset(withEmail: email) { error in
                                if let error = error {
                                    alertMessage = error.localizedDescription
                                } else {
                                    alertMessage = "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi."
                                }
                                showAlert = true
                            }
                        }) {
                            Text("Parolayı mı unuttunuz ? ")
                                .underline()
                                .padding()
                                .foregroundColor(.black)
                                .font(.custom("RobotoSlab-Regular", size: 15))
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Bilgi"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
                        }
                        
                    
                        Button(action: {showSignUpPage = true}, label: {
                            Text("Yeni hesap oluştur 🌱")
                                .underline()
                                .padding()
                                .foregroundColor(.black)
                                .font(.custom("RobotoSlab-Regular", size: 15))
                        }).navigationDestination(isPresented: $showSignUpPage){SignUpPage()}
                            .frame(height: 10)
                        
                    }
            }
        }
        }
    }


struct Custommodifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("RobotoSlab-Regular", size: 14))
            .padding()
            .frame(width: 370, height: 40)
            .autocapitalization(.none)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black.opacity(0.3), lineWidth: 1))
            .padding(.bottom, 20)
           
    }
}



#Preview {
    LoginPage()
}
