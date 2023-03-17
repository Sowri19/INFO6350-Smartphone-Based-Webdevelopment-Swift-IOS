
class Company {
    var dictionary: [String: Any]
    
    var id: Int {
        get { return dictionary["id"] as? Int ?? 0 }
        set { dictionary["id"] = newValue }
    }
    
    var name: String {
        get { return dictionary["name"] as? String ?? "" }
        set { dictionary["name"] = newValue }
    }
    
    var address: String {
        get { return dictionary["address"] as? String ?? "" }
        set { dictionary["address"] = newValue }
    }
    
    var country: String {
        get { return dictionary["country"] as? String ?? "" }
        set { dictionary["country"] = newValue }
    }
    
    var zip: String {
        get { return dictionary["zip"] as? String ?? "" }
        set { dictionary["zip"] = newValue }
    }
    
    var company_type: String {
        get { return dictionary["zip"] as? String ?? "" }
        set { dictionary["zip"] = newValue }
    }
    
    init(id: Int, name: String, address: String, country: String, zip: String, company_type: String) {
        self.dictionary = [
            "id": id,
            "name": name,
            "address": address,
            "country": country,
            "zip": zip,
            "company_type": company_type
        ]
    }
}
