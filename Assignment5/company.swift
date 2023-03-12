
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
    
    init(id: Int, name: String, address: String, country: String, zip: String) {
        self.dictionary = [
            "id": id,
            "name": name,
            "address": address,
            "country": country,
            "zip": zip
        ]
    }
}

func addCompanyFromUserInput() {
    print("Enter company ID:")
    guard let idString = readLine(),
        let id = Int(idString),
        id > 0 else {
            print("Invalid input for company ID")
            return
    }
    
    print("Enter company name:")
    guard let name = readLine(), !name.isEmpty else {
        print("Invalid input for company name")
        return
    }
    
    print("Enter company address:")
    guard let address = readLine(), !address.isEmpty else {
        print("Invalid input for company address")
        return
    }
    
    print("Enter company country:")
    guard let country = readLine(), !country.isEmpty else {
        print("Invalid input for company country")
        return
    }
    
    print("Enter company zip:")
    guard let zip = readLine(), !zip.isEmpty else {
        print("Invalid input for company zip")
        return
    }
    
    let company = Company(id: id, name: name, address: address, country: country, zip: zip)
    productManager.addCompany(company: company)
    
    print("Company added successfully!")
}

func deleteCompanyFromUserInput() {
    print("Enter the ID of the company you want to delete:")
    if let companyID = readLine(),
       let id = Int(companyID),
       let company = productManager.companies.first(where: { $0.id == id }) {
        productManager.deleteCompany(company: company)
    } else {
        print("Invalid company ID. Please try again.")
    }
}
