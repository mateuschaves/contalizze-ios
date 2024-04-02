import Foundation

class Api {
    let baseURL: URL
    
    init() {
        guard let url = URL(string: "https://seashell-app-c24td.ondigitalocean.app/") else {
            fatalError("Invalid base URL")
        }
        self.baseURL = url
    }
    
    func getAllCategories(completion: @escaping ([Category]?) -> Void) {
        let url = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let orders = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {
                    completion(orders)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
