import Foundation

class Api {
    let baseURL: URL
    
    init() {
        guard let url = URL(string: "https://seashell-app-c24td.ondigitalocean.app/") else {
            fatalError("Invalid base URL")
        }
        self.baseURL = url
    }
    
    func getAllEstablishments(completion: @escaping ([Establishment]?) -> Void) {
        let url = baseURL.appendingPathComponent("establishments")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let establishments = try JSONDecoder().decode([Establishment].self, from: data)
                DispatchQueue.main.async {
                    completion(establishments)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func getAllEstablishmentsCategory(completion: @escaping ([EstablishmentCategory]?) -> Void) {
        let url = baseURL.appendingPathComponent("establishment-category")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let establishmentsCategory = try JSONDecoder().decode([EstablishmentCategory].self, from: data)
                DispatchQueue.main.async {
                    completion(establishmentsCategory)
                }
            } catch {
                print("Error decoding establishments category:", error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func createEstablishmentCategory(categoryId: Int, establishmentId: Int, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("establishment-category")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let establishmentCategoryData: [String: Any] = ["categoryId": categoryId, "establishmentId": establishmentId]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: establishmentCategoryData)
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
    
    func deleteEstablishmentCategory(establishmentCategoryID: Int, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("establishment-category").appendingPathComponent(String(establishmentCategoryID))
        
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
    
    func createEstablishment(establishmentName: String, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("establishments")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let categoryData: [String: Any] = ["name": establishmentName]
        
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
    
    func deleteEstablishment(establishmentID: Int, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("establishments").appendingPathComponent(String(establishmentID))
        
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
    
    
    func uploadExtractCSV(fileURL: URL, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("upload/extract")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        do {
            let fileData = try Data(contentsOf: fileURL)
            let fileName = fileURL.lastPathComponent
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
            body.append("Content-Type: text/csv\r\n\r\n")
            body.append(fileData)
            body.append("\r\n--\(boundary)--\r\n")
            
            request.httpBody = body
        } catch {
            print("Error creating file data:", error)
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


}
