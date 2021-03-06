// This is a generated file 
// Generated by ResouceKit 
// You can write custom imoprt XXXX logic
import UIKit
protocol XibProtocol {
	var name: String { get } 
	 func nib() -> UINib
}
extension UITableView { 
	internal func registerNib(nib: XibProtocol) -> Void {
		registerNib(nib.nib(), forCellReuseIdentifier: nib.name)
	}
	internal func registerNibs(nibs: [XibProtocol]) -> Void {
		nibs.forEach(registerNib)
	}
	 
} 

extension UICollectionView { 
	internal func registerNib(nib: XibProtocol) -> Void {
		registerNib(nib.nib(), forCellWithReuseIdentifier: nib.name)
	}
	internal func registerNibs(nibs: [XibProtocol]) -> Void {
		nibs.forEach(registerNib)
	}
	 
} 

extension ViewController { 
	class func instanceFromInstanceFromOverride() -> ViewController {
		let storyboard = UIStoryboard(name: "InstanceFromOverride", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("BaseInstance") as! ViewController
		return viewController
	}
	class func initialViewController() -> ViewController {
		let storyboard = UIStoryboard(name: "ViewController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! ViewController
		return viewController
	}
	internal func perFormSegueShowSecondTable(sender: AnyObject? = nil) -> Void {
		performSegueWithIdentifier("ShowSecondTable", sender: sender)
	}
	struct Segue {
		static let showSecondTable: String = "ShowSecondTable"
	
	} 
} 

extension TableViewController { 
	class func instanceFromTabBarController() -> TableViewController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("TableView") as! TableViewController
		return viewController
	}
	internal func perFormSegueShowViewController(sender: AnyObject? = nil) -> Void {
		performSegueWithIdentifier("ShowViewController", sender: sender)
	}
	struct Segue {
		static let showViewController: String = "ShowViewController"
	
	} 
} 

extension OverrideViewController { 
	class func instanceFromInstanceFromOverrideOtherIdentifier() -> OverrideViewController {
		let storyboard = UIStoryboard(name: "InstanceFromOverride", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("OtherIdentifier") as! OverrideViewController
		return viewController
	}
	class func instanceFromInstanceFromOverrideOverrideInstance() -> OverrideViewController {
		let storyboard = UIStoryboard(name: "InstanceFromOverride", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("OverrideInstance") as! OverrideViewController
		return viewController
	}
	class override func initialViewController() -> OverrideViewController {
		let storyboard = UIStoryboard(name: "OverrideViewController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! OverrideViewController
		return viewController
	}
	override func perFormSegueShowSecondTable(sender: AnyObject? = nil) -> Void {
		performSegueWithIdentifier("ShowSecondTable", sender: sender)
	}
	struct Segue {
		static let showSecondTable: String = "ShowSecondTable"
	
	} 
} 

extension SecondTableViewController { 
	class func initialViewController() -> SecondTableViewController {
		let storyboard = UIStoryboard(name: "SecondTableViewController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! SecondTableViewController
		return viewController
	}
	internal func perFormSegueShowOverride(sender: AnyObject? = nil) -> Void {
		performSegueWithIdentifier("ShowOverride", sender: sender)
	}
	struct Segue {
		static let showOverride: String = "ShowOverride"
	
	} 
} 

extension CollectionViewController { 
	class func instanceFromTabBarController() -> CollectionViewController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("CollectionView") as! CollectionViewController
		return viewController
	}
	internal func perFormSegueShowViewController(sender: AnyObject? = nil) -> Void {
		performSegueWithIdentifier("ShowViewController", sender: sender)
	}
	struct Segue {
		static let showViewController: String = "ShowViewController"
	
	} 
} 

extension SecondCollectionViewController { 
	class func instanceFromTabBarController() -> SecondCollectionViewController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("SecondCollectionView") as! SecondCollectionViewController
		return viewController
	}
	 
} 

extension ObjCOveerrideViewController { 
	class override func initialViewController() -> ObjCOveerrideViewController {
		let storyboard = UIStoryboard(name: "ObjCOverrideViewController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! ObjCOveerrideViewController
		return viewController
	}
	 
} 

extension ObjCViewController { 
	class func initialViewController() -> ObjCViewController {
		let storyboard = UIStoryboard(name: "ObjCViewController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! ObjCViewController
		return viewController
	}
	 
} 

extension UITabBarController { 
	class func initialViewController() -> UITabBarController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateInitialViewController() as! UITabBarController
		return viewController
	}
	 
} 

extension UINavigationController { 
	class func instanceFromTabBarControllerNav1() -> UINavigationController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("Nav1") as! UINavigationController
		return viewController
	}
	class func instanceFromTabBarControllerNav2() -> UINavigationController {
		let storyboard = UIStoryboard(name: "TabBarController", bundle: nil) 
		let viewController = storyboard.instantiateViewControllerWithIdentifier("Nav2") as! UINavigationController
		return viewController
	}
	 
} 
extension SecondTableViewCell { 
	
	struct Reusable {
		static let ReuseIdentifier: String = "ReuseIdentifier"
	
	} 
} 
extension SecondCollectionViewCell { 
	
	struct Reusable {
		static let ReuseIdentifier: String = "ReuseIdentifier"
	
	} 
} 
extension TableViewCell { 
	
	struct Xib: XibProtocol {
		let name: String = "TableViewCell"
		internal func nib() -> UINib {
		return UINib(nibName: "TableViewCell", bundle: nil) 
	}
		internal func view() -> TableViewCell {
		return nib().instantiateWithOwner(nil, options: nil)[0] as! TableViewCell
	}
	} 
} 

extension CollectionViewCell { 
	
	struct Xib: XibProtocol {
		let name: String = "CollectionViewCell"
		internal func nib() -> UINib {
		return UINib(nibName: "CollectionViewCell", bundle: nil) 
	}
		internal func view() -> CollectionViewCell {
		return nib().instantiateWithOwner(nil, options: nil)[0] as! CollectionViewCell
	}
	} 
} 

extension CustomView { 
	
	struct Xib: XibProtocol {
		let name: String = "CustomView"
		internal func nib() -> UINib {
		return UINib(nibName: "CustomView", bundle: nil) 
	}
		internal func view() -> CustomView {
		return nib().instantiateWithOwner(nil, options: nil)[0] as! CustomView
	}
	} 
} 
extension UIImage { 
	
	struct Asset {
		static let curry: UIImage = UIImage(named: "curry")!
		static let ebi: UIImage = UIImage(named: "ebi")!
		static let inaka: UIImage = UIImage(named: "inaka")!
		static let kake: UIImage = UIImage(named: "kake")!
		static let kaki: UIImage = UIImage(named: "kaki")!
		static let kikkoman: UIImage = UIImage(named: "kikkoman")!
		static let koori: UIImage = UIImage(named: "koori")!
		static let koumi: UIImage = UIImage(named: "koumi")!
		static let marudaizu: UIImage = UIImage(named: "marudaizu")!
		static let ninniku: UIImage = UIImage(named: "ninniku")!
		static let siro: UIImage = UIImage(named: "siro")!
		static let ususio: UIImage = UIImage(named: "ususio")!
	
	}
	struct Resource {
		static let swift_logo: UIImage = UIImage(named: "swift_logo")!
	
	} 
} 

extension String { 
	
	struct Localized {
		static let hello_world_2: String = NSLocalizedString("hello world 2", comment: "")
		static let helloworld: String = NSLocalizedString("helloworld", comment: "")
		static let hello_world_08: String = NSLocalizedString("hello,world 08", comment: "")
		static let hello_world_11___: String = NSLocalizedString("hello}world 11 %@", comment: "")
		static let hello_world_12___: String = NSLocalizedString("hello}world 12 %@", comment: "")
		static let hello_world_3: String = NSLocalizedString("hello world 3", comment: "")
		static let hello_world_07: String = NSLocalizedString("hello?world 07", comment: "")
		static let hello_world_4: String = NSLocalizedString("hello world 4", comment: "")
		static let hello_world_10: String = NSLocalizedString("hello}world 10", comment: "")
		static let hello_world_09: String = NSLocalizedString("hello(world 09", comment: "")
		static let hello_world_06: String = NSLocalizedString("hello!world 06", comment: "")
		static let hello_world_1: String = NSLocalizedString("hello world 1", comment: "")
		static let hello_world_05: String = NSLocalizedString("hello.world 05", comment: "")
	
	} 
} 

