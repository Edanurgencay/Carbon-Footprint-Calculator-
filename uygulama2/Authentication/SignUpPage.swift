import SwiftUI
import FirebaseAuth

struct SignUpPage: View {
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State private var loginPage = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessMessage = false
    @State private var showLoginPage = false
    
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
 
        NavigationStack {
            VStack {
                    Image("app-logo-green")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 150)

                    Text("Hesap Oluştur")
                        .font(.custom("RobotoSlab-Regular_Bold", size: 30))
                        .padding(.bottom, 5)

                    HStack {
                        Text("Zaten bir hesabın var mı?")
                            .font(.custom("RobotoSlab-Regular", size: 15))
                            .opacity(0.5)

                        Button(action: {
                            loginPage = true
                        }, label: {
                            Text("Giriş Yap")
                                .underline()
                                .font(.custom("RobotoSlab-Regular", size: 15))
                                .foregroundColor(.color3)
                        }).navigationDestination(isPresented: $loginPage) {
                            LoginPage()
                        }
                    }.padding(.bottom, 70)

                    Text("Adınız-soyadınız")
                        .font(.custom("RobotoSlab-Regular", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)

                    TextField("Eda Gençay", text: $username)
                        .font(.custom("RobotoSlab-Regular", size: 14))
                        .padding()
                        .frame(width: 370, height: 40)
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.3), lineWidth: 1))
                        .padding(.bottom, 20)

                    Text("E-mail adresiniz")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)

                    TextField("example@gmail.com", text: $email)
                        .font(.custom("RobotoSlab-Regular", size: 14))
                        .padding()
                        .frame(width: 370, height: 40)
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.3), lineWidth: 1))
                        .padding(.bottom, 20)

                    Text("Şifre")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)

                    SecureField("*******", text: $password)
                        .font(.custom("RobotoSlab-Regular", size: 14))
                        .padding()
                        .frame(width: 370, height: 40)
                        .autocapitalization(.none)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.3), lineWidth: 1))
                        .padding(.bottom, 30)
                
            
                
                    Button(action: {
                        showLoginPage = true
                        firebaseManager.createUser(email: email, password: password) { result in
                            switch result {
                            case .success(let authResult):
                                let userData: [String: Any] = [
                                    "username": self.username,
                                    "email": self.email,
                                    "uid": authResult.user.uid
                                ]
                                firebaseManager.saveUserData(uid: authResult.user.uid, newData: userData) { error in
                                    if let error = error {
                                        print("Error saving user data: \(error.localizedDescription)")
                                        self.alertMessage = error.localizedDescription
                                        self.showAlert = true
                                    } else {
                                        print("User data saved successfully")
                                        self.alertMessage = "Kayıt başarıyla gerçekleşti"
                                        self.showAlert = true
                                        self.showSuccessMessage = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.showSuccessMessage = false
                                        }
                                    }
                                }

                            case .failure(let error):
                                print("Error creating user: \(error.localizedDescription)")
                                self.alertMessage = error.localizedDescription
                                self.showAlert = true
                            }
                        }
                    }, label: {
                        Text("Kayıt Ol")
                            .foregroundColor(.white)
                            .font(.custom("RobotoSlab-Regular_Bold", size: 16))
                            .frame(width: 370, height: 40)
                            .background(Color.color4).opacity(0.85)
                            .cornerRadius(15)
                    }).navigationDestination(isPresented: $showLoginPage){
                        LoginPage()
                    }

                    if showSuccessMessage {
                        Text("Kayıt başarıyla gerçekleşti")
                            .foregroundColor(.green)
                            .padding(.top, 20)
                            .transition(.opacity)
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Durum"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
            }
        }
        }
    }


#Preview {
    SignUpPage()
}
