
import Foundation
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let storeViewModel = StoreViewModel()
    let scheduleViewModel = ScheduleViewModel()
    
    var window: UIWindow?
    
    // MARK: - Core Data stack

    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        return true
    }
   
    func applicationDidEnterBackground(_ application: UIApplication) {
        storeViewModel.saveData()
        scheduleViewModel.saveData()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        storeViewModel.saveData()
        scheduleViewModel.saveData()
    }
}
