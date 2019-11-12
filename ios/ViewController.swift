//
//  ViewController.swift
//  NewReactProject
//
//  Created by haider ali on 30/10/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import ARKit



class ViewController: UIViewController {

    
  
  


  @IBOutlet weak var sceneView: ARSCNView!
  @IBOutlet weak var label: UILabel!
  
  var worldMapURL: URL = {
      do {
          return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
              .appendingPathComponent("worldMapURL")
      } catch {
          fatalError("Error getting world map URL from document directory.")
      }
  }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      sceneView.delegate = self
      configureLighting()
      addTapGestureToSceneView()
  }
  
  func addTapGestureToSceneView() {
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didReceiveTapGesture(_:)))
      sceneView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc func didReceiveTapGesture(_ sender: UITapGestureRecognizer) {
      let location = sender.location(in: sceneView)
      guard let hitTestResult = sceneView.hitTest(location, types: [.featurePoint, .estimatedHorizontalPlane]).first
          else { return }
      let anchor = ARAnchor(transform: hitTestResult.worldTransform)
      sceneView.session.add(anchor: anchor)
  }
  
  func generateSphereNode() -> SCNNode {
      let sphere = SCNSphere(radius: 0.05)
      let sphereNode = SCNNode()
      sphereNode.position.y += Float(sphere.radius)
      sphereNode.geometry = sphere
      return sphereNode
  }
  
  func configureLighting() {
      sceneView.autoenablesDefaultLighting = true
      sceneView.automaticallyUpdatesLighting = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      resetTrackingConfiguration()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      sceneView.session.pause()
  }
  
  @IBAction func resetBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
      resetTrackingConfiguration()
  }
  
  @IBAction func saveBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
      
      sceneView.session.getCurrentWorldMap { (worldMap, error) in
          guard let worldMap = worldMap else {
              return self.setLabel(text: "Error getting current world map.")
          }
          
          do {
              try self.archive(worldMap: worldMap)
              DispatchQueue.main.async {
                  self.setLabel(text: "World map is saved.")
              }
          } catch {
              fatalError("Error saving world map: \(error.localizedDescription)")
          }
      }
  }
  
  @IBAction func loadBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
      guard let worldMapData = retrieveWorldMapData(from: worldMapURL),
          let worldMap = unarchive(worldMapData: worldMapData) else { return }
      resetTrackingConfiguration(with: worldMap)
  }
  
  func resetTrackingConfiguration(with worldMap: ARWorldMap? = nil) {
      let configuration = ARWorldTrackingConfiguration()
      configuration.planeDetection = [.horizontal]
      
      let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
      if let worldMap = worldMap {
          configuration.initialWorldMap = worldMap
          setLabel(text: "Found saved world map.")
      } else {
          setLabel(text: "Move camera around to map your surrounding space.")
      }
      
      sceneView.debugOptions = [.showFeaturePoints]
      sceneView.session.run(configuration, options: options)
  }
  
  func setLabel(text: String) {
      label.text = text
  }
  
  func archive(worldMap: ARWorldMap) throws {
      let data = try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
      try data.write(to: self.worldMapURL, options: [.atomic])
  }
  
  func retrieveWorldMapData(from url: URL) -> Data? {
      do {
          return try Data(contentsOf: self.worldMapURL)
      } catch {
          self.setLabel(text: "Error retrieving world map data.")
          return nil
      }
  }
  
  func unarchive(worldMapData data: Data) -> ARWorldMap? {
      guard let unarchievedObject = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)else { return nil }
      
          let worldMap = unarchievedObject
      return worldMap
  }
  
  
  
  
  
  
  
  
  override func viewDidLayoutSubviews() {
    
   
  }
    

  @IBAction func goToReactSide(_ sender: Any) {
    
    
    
  
    UIApplication.shared.windows[0].rootViewController = obj as! UIViewController
    

 
//
//    var bridge = RCTBridge(delegate: self, launchOptions: ??)
//    var rootView = RCTRootView(bridge: bridge, moduleName: "NewReactProject", initialProperties: nil)
//    rootView.
//
//
    
    
    
  }
  
  func resetApp() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
            ).instantiateInitialViewController()
    }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
  
   
//  func createBridgeIfNeeded() -> RCTBridge {
//    if bridge == nil {
//      bridge = RCTBridge.init(delegate: self, launchOptions: nil)
//    }
//    return bridge!
//  }
//
//  func viewForModule(_ moduleName: String, initialProperties: [String : Any]?) -> RCTRootView {
//    let viewBridge = createBridgeIfNeeded()
//    let rootView: RCTRootView = RCTRootView(
//      bridge: viewBridge,
//      moduleName: moduleName,
//      initialProperties: initialProperties)
//    return rootView
//  }
  
  
  

}





extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard !(anchor is ARPlaneAnchor) else { return }
        let sphereNode = generateSphereNode()
        DispatchQueue.main.async {
            node.addChildNode(sphereNode)
        }
    }
    
}


extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.70)
    }
}


//
//extension MixerReactModule: RCTBridgeDelegate {
//  func sourceURL(for bridge: RCTBridge!) -> URL! {
//    return URL(string: "http://localhost:8081/index.ios.bundle?platform=ios")
//  }
//}





