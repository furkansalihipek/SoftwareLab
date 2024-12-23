import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String? = nil
    @Published var isLoading = false

    private let baseURL = "http://localhost:3000/users"

    func fetchUserData(userId: String) {
        isLoading = true
        guard let url = URL(string: "\(baseURL)/\(userId)") else {
            self.errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Veri çekme hatası: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Veri alınamadı."
                    self.isLoading = false
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let fetchedUser = try decoder.decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.user = fetchedUser
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Veri işleme hatası: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

