//
//  ViewController.swift
//  LisetteAntigua_App
//
//  Created by Lisette Antigua on 4/5/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var scientists =[String, Scientist]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "scientists", bundle: nil) else{
            fatalError("Couldn't load tracking images")
        }
        configuration.trackingImages = trackingImages
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else{ return nil}
        
        let plane  = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi/2
        let node = SCNNode()
        node.addChildNode(planeNode)
        return node
    }
    

}
