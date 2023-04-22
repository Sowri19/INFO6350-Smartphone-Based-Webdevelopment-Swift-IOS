//
//  AppDelegate.swift
//  UsingStoryBoard
//


import UIKit
import CoreData
import SystemConfiguration
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let url = URL(string: "https://6429924debb1476fcc4c36b2.mockapi.io/company")
        let reachability = SCNetworkReachabilityCreateWithName(nil, "6429924debb1476fcc4c36b2.mockapi.io/company")
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
            let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
            return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
        }

        if !isNetworkReachable(with: flags) {
            print("No API Found")
        } else {
            // Do any additional setup after loading the view.
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let error = error {
                    // Handle API request error
                    print("Error: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        // Handle invalid HTTP response
                        print("Invalid HTTP response")
                        return
                }
                guard let data = data else {
                    // Handle missing API response data
                    print("Missing API response data")
                    return
                }
                // Process API response data
                print("API Response: \(data)")
                parseAndStoreData(data: data, context: context)
            }
            task.resume()
        }
        // Assuming you have a Core Data model called `CompanyData` with appropriate attributes
        func parseAndStoreData(data: Data, context: NSManagedObjectContext) {
            do {
                let decoder = JSONDecoder()
                let companyJSONs = try decoder.decode([CompanyJSON].self, from: data)
                
                for companyJSON in companyJSONs {
                    // Check if a company with the same ID already exists in Core Data
                    let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %@", companyJSON.id)
                    
                    if let existingCompany = try context.fetch(fetchRequest).first {
                        // Update the existing company with the new data
                        existingCompany.name = companyJSON.name
                        existingCompany.address = companyJSON.address
                        existingCompany.zip = Int64(companyJSON.zipcode) ?? 0
                        existingCompany.company_type = companyJSON.companyType
                        existingCompany.country = companyJSON.country
                        existingCompany.id = Int64(companyJSON.id) ?? 0
                        
                        // Download the image data and store it in Core Data
                        if let imageUrl = URL(string: companyJSON.logo) {
                            let session = URLSession.shared
                            let dataTask = session.dataTask(with: imageUrl) { (data, response, error) in
                                if let imageData = data {
                                    DispatchQueue.main.async {
                                        existingCompany.logo = imageData
                                        // Save the managed object context to persist the changes
                                        do {
                                            try context.save()
                                            print("Data saved successfully.")
                                        } catch {
                                            print("Failed to save data: \(error.localizedDescription)")
                                        }
                                    }
                                } else if let error = error {
                                    print("Error downloading image: \(error.localizedDescription)")
                                }
                            }
                            dataTask.resume()
                        }
                    } else {
                        // Create a new Core Data managed object for the `CompanyData` entity
                        let company = CompanyData(context: context)
                        company.name = companyJSON.name
                        company.address = companyJSON.address
                        company.zip = Int64(companyJSON.zipcode) ?? 0
                        company.company_type = companyJSON.companyType
                        company.country = companyJSON.country
                        company.id = Int64(companyJSON.id) ?? 0
                        
                        // Download the image data and store it in Core Data
                        if let imageUrl = URL(string: companyJSON.logo) {
                            let session = URLSession.shared
                            let dataTask = session.dataTask(with: imageUrl) { (data, response, error) in
                                if let imageData = data {
                                    DispatchQueue.main.async {
                                        company.logo = imageData
                                        // Save the managed object context to persist the changes
                                        do {
                                            try context.save()
                                            print("Data saved successfully.")
                                        } catch {
                                            print("Failed to save data: \(error.localizedDescription)")
                                        }
                                    }
                                } else if let error = error {
                                    print("Error downloading image: \(error.localizedDescription)")
                                }
                            }
                            dataTask.resume()
                        }
                    }
                }
            } catch let error {
                print("Failed to parse data: \(error.localizedDescription)")
                print("Raw Data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "UsingStoryBoard")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

