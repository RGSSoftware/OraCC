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
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `Login_Sample_Data.json`.
    static let login_Sample_DataJson = Rswift.FileResource(bundle: R.hostingBundle, name: "Login_Sample_Data", pathExtension: "json")
    
    /// `bundle.url(forResource: "Login_Sample_Data", withExtension: "json")`
    static func login_Sample_DataJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.login_Sample_DataJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `Splash`.
    static let splash = Rswift.ImageResource(bundle: R.hostingBundle, name: "Splash")
    
    /// `UIImage(named: "Splash", bundle: ..., traitCollection: ...)`
    static func splash(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.splash, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `FieldCell`.
    static let fieldCell: Rswift.ReuseIdentifier<FieldCell> = Rswift.ReuseIdentifier(identifier: "FieldCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `SplashViewController`, and contains static references to 2 segues.
    struct splashViewController {
      /// Segue identifier `from_Splash_to_Chats`.
      static let from_Splash_to_Chats: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Splash_to_Chats")
      /// Segue identifier `from_Splash_to_Login`.
      static let from_Splash_to_Login: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "from_Splash_to_Login")
      
      /// Optionally returns a typed version of segue `from_Splash_to_Chats`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Splash_to_Chats(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.splashViewController.from_Splash_to_Chats, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `from_Splash_to_Login`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func from_Splash_to_Login(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SplashViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.splashViewController.from_Splash_to_Login, segue: segue)
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
      
      func loginViewController(_: Void = ()) -> LoginViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loginViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "Splash") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Splash' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().loginViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loginViewController' could not be loaded from storyboard 'Main' as 'LoginViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}