//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 5 files.
  struct file {
    /// Resource file `ChatMessaes_Sample_Data.json`.
    static let chatMessaes_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "ChatMessaes_Sample_Data", pathExtension: "json")
    /// Resource file `Chats_Sample_Data.json`.
    static let chats_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "Chats_Sample_Data", pathExtension: "json")
    /// Resource file `Login_Sample_Data.json`.
    static let login_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "Login_Sample_Data", pathExtension: "json")
    /// Resource file `Register_Sample_Data.json`.
    static let register_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "Register_Sample_Data", pathExtension: "json")
    /// Resource file `UpdateMe_Sample_Data.json`.
    static let updateMe_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "UpdateMe_Sample_Data", pathExtension: "json")
    
    /// `bundle.url(forResource: "ChatMessaes_Sample_Data", withExtension: "json")`
    static func chatMessaes_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.chatMessaes_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Chats_Sample_Data", withExtension: "json")`
    static func chats_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.chats_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Login_Sample_Data", withExtension: "json")`
    static func login_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.login_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Register_Sample_Data", withExtension: "json")`
    static func register_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.register_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "UpdateMe_Sample_Data", withExtension: "json")`
    static func updateMe_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.updateMe_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `Splash`.
    static let splash = Rswift.ImageResource(bundle: R.hostingBundle, name: "Splash")
    /// Image `account`.
    static let account = Rswift.ImageResource(bundle: R.hostingBundle, name: "account")
    /// Image `list`.
    static let list = Rswift.ImageResource(bundle: R.hostingBundle, name: "list")
    
    /// `UIImage(named: "Splash", bundle: ..., traitCollection: ...)`
    static func splash(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.splash, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "account", bundle: ..., traitCollection: ...)`
    static func account(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.account, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "list", bundle: ..., traitCollection: ...)`
    static func list(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.list, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ChatCell`.
    static let chatCell: Rswift.ReuseIdentifier<ChatCell> = Rswift.ReuseIdentifier(identifier: "ChatCell")
    /// Reuse identifier `FieldCell`.
    static let fieldCell: Rswift.ReuseIdentifier<FieldCell> = Rswift.ReuseIdentifier(identifier: "FieldCell")
    /// Reuse identifier `HeaderCell`.
    static let headerCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "HeaderCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 3 view controllers.
  struct segue {
    /// This struct is generated for `ChatsViewController`, and contains static references to 1 segues.
    struct chatsViewController {
      /// Segue identifier `from_Chats_to_Chat`.
      static let from_Chats_to_Chat: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ChatsViewController, ChatViewController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Chats_to_Chat")
      
      /// Optionally returns a typed version of segue `from_Chats_to_Chat`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Chats_to_Chat(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ChatsViewController, ChatViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.chatsViewController.from_Chats_to_Chat, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `LoginViewController`, and contains static references to 1 segues.
    struct loginViewController {
      /// Segue identifier `from_Login_to_Register`.
      static let from_Login_to_Register: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, LoginViewController, RegisterViewController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Login_to_Register")
      
      /// Optionally returns a typed version of segue `from_Login_to_Register`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Login_to_Register(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, LoginViewController, RegisterViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.loginViewController.from_Login_to_Register, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `SplashViewController`, and contains static references to 2 segues.
    struct splashViewController {
      /// Segue identifier `from_Splash_to_Login`.
      static let from_Splash_to_Login: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Splash_to_Login")
      /// Segue identifier `from_Splash_to_Main`.
      static let from_Splash_to_Main: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UITabBarController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Splash_to_Main")
      
      /// Optionally returns a typed version of segue `from_Splash_to_Login`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Splash_to_Login(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.splashViewController.from_Splash_to_Login, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `from_Splash_to_Main`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Splash_to_Main(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UITabBarController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.splashViewController.from_Splash_to_Main, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "Splash") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Splash' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SplashViewController
      
      let bundle = R.hostingBundle
      let loginViewController = StoryboardViewControllerResource<LoginViewController>(identifier: "LoginViewController")
      let name = "Main"
      let registerViewController = StoryboardViewControllerResource<RegisterViewController>(identifier: "RegisterViewController")
      
      func loginViewController(_: Void = ()) -> LoginViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loginViewController)
      }
      
      func registerViewController(_: Void = ()) -> RegisterViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: registerViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "list") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'list' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Splash") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Splash' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "account") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'account' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().registerViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'registerViewController' could not be loaded from storyboard 'Main' as 'RegisterViewController'.") }
        if _R.storyboard.main().loginViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loginViewController' could not be loaded from storyboard 'Main' as 'LoginViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}