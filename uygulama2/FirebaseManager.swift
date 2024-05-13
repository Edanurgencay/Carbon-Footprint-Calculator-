import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    let auth: Auth
    let firestore: Firestore
    private let db = Firestore.firestore()

    init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }

    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result))
            }
        }
    }

    func saveUserData(uid: String, newData: [String: Any], completion: @escaping (Error?) -> Void) {
        firestore.collection("users").document(uid).setData(newData) { error in
            completion(error)
        }
    }

    func saveUserDataa(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        // Firestore'da belirtilen kullanıcı belgesini güncelle
        db.collection("users").document(uid).setData(data, merge: true) { error in
            completion(error)
        }
    }
    func saveUserDataaDogalgaz(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["komur"] = 0 // Kömür değerini 0 olarak ayarla
        db.collection("users").document(uid).setData(updatedData, merge: true) { error in
            completion(error)
        }
    }
    func saveUserDataaKomur(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["dogalgaz"] = 0 // Kömür değerini 0 olarak ayarla
        db.collection("users").document(uid).setData(updatedData, merge: true) { error in
            completion(error)
        }
    }
    func saveUserDataaBenzin(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["motorin"] = 0
        updatedData["lpg"] = 0// Kömür değerini 0 olarak ayarla
        db.collection("users").document(uid).setData(updatedData, merge: true) { error in
            completion(error)
        }
    }
    func saveUserDataaLpg(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["motorin"] = 0
        updatedData["benzin"] = 0// Kömür değerini 0 olarak ayarla
        db.collection("users").document(uid).setData(updatedData, merge: true) { error in
            completion(error)
        }
    }
    func saveUserDataaMotorin(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        var updatedData = data
        updatedData["benzin"] = 0
        updatedData["lpg"] = 0// Kömür değerini 0 olarak ayarla
        db.collection("users").document(uid).setData(updatedData, merge: true) { error in
            completion(error)
        }
    }
}
class authViewModel: ObservableObject{
    @Published var isLoggedIn : Bool = false
    @Published var userName: String = ""
       @Published var userEmail: String = ""
    private let firebaseManager = FirebaseManager()
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
    func login (email: String,password:String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    if let error = error {
                        print("Error signing in: \(error.localizedDescription)")
                    } else {
                        self?.isLoggedIn = true
                    }
                }
    }
    func logout (){
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            print("çıkış yapıldı")
        }
        catch _ as NSError{
            print("çıkış hatası")
        }
    }
    private func fetchUserData() {
           guard let userId = Auth.auth().currentUser?.uid else { return }
           firebaseManager.firestore.collection("users").document(userId).getDocument { [weak self] document, error in
               if let document = document, document.exists {
                   let data = document.data()
                   self?.userName = data?["name"] as? String ?? ""
                   self?.userEmail = data?["email"] as? String ?? ""
               } else {
                   print("Document does not exist")
               }
           }
       }
}
