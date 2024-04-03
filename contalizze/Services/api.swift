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
    
    func createCategory(categoryName: String, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("categories")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let categoryData: [String: Any] = ["name": categoryName]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: categoryData)
            request.httpBody = jsonData
        } catch {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(true)
            }
        }
        task.resume()
    }

    
    func deleteCategory(categoryID: Int, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("categories").appendingPathComponent(String(categoryID))
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(true)
            }
        }
        task.resume()
    }
}
