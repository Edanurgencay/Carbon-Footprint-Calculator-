import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    func saveUserResponses(responses: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("users").document(responses["uid"] as! String).setData(responses) { error in
            if let error = error {
                print("Error adding document: \(error)")
                completion(error)
            } else {
                print("Document added successfully!")
                completion(nil)
            }
        }
    }
    func saveUserData(uid: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
            // Firestore'da belirtilen kullanıcı belgesini güncelle
            db.collection("users").document(uid).setData(data, merge: true) { error in
                completion(error)
            }
        }
}
