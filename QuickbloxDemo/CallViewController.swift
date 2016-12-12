//
//  CallViewController.swift
//  QuickbloxDemo
//
//  Created by 默司 on 2016/12/12.
//  Copyright © 2016年 默司. All rights reserved.
//

import UIKit

class CallViewController: UIViewController, QBRTCClientDelegate {

    var session: QBRTCSession!
    var capture: QBRTCCameraCapture!
    var remoteView: QBRTCRemoteVideoView!
    @IBOutlet weak var localView: LocalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        QBRTCClient.instance().add(self)
        
        self.capture = QBRTCCameraCapture(videoFormat: QBRTCVideoFormat.default(), position: .front)
        self.capture.startSession()
        self.localView.set(self.capture.previewLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func call(_ sender: Any) {
        let id = QBChat.instance().currentUser()!.id == 21583633 ? 21583636 : 21583633
        print(QBChat.instance().currentUser()!.id)
        print(id)
        self.session = QBRTCClient.instance().createNewSession(withOpponents: [id], with: .video)
        self.session.startCall(nil)
    }
    
    func didReceiveNewSession(_ session: QBRTCSession!, userInfo: [AnyHashable : Any]! = [:]) {
        print("didReceiveNewSession")
        
        if self.session != nil {
            session.rejectCall(nil)
            return
        }
        
        session.acceptCall(nil)
        
        self.session = session
    }
    
    func session(_ session: QBRTCSession!, receivedRemoteVideoTrack videoTrack: QBRTCVideoTrack!, fromUser userID: NSNumber!) {
        print("receivedRemoteVideoTrack")
        if self.remoteView != nil {
            self.remoteView.removeFromSuperview()
        }
        self.remoteView = QBRTCRemoteVideoView(frame: UIScreen.main.bounds)
        self.view.insertSubview(self.remoteView, at: 0)
        self.remoteView.setVideoTrack(videoTrack)
        
        
    }
    
    func session(_ session: QBRTCSession!, initializedLocalMediaStream mediaStream: QBRTCMediaStream!) {
        print("initializedLocalMediaStream")
        
        session.localMediaStream.videoTrack.videoCapture = self.capture
    }

    func sessionDidClose(_ session: QBRTCSession!) {
        print("sessionDidClose")
    }
    
    func session(_ session: QBRTCSession!, connectedToUser userID: NSNumber!) {
        print("connectedToUser")
    }
    
    func session(_ session: QBRTCSession!, userDidNotRespond userID: NSNumber!) {
        print("userDidNotRespond")
    }
    
    func session(_ session: QBRTCSession!, disconnectedFromUser userID: NSNumber!) {
        print("disconnectedFromUser")
        self.remoteView.setVideoTrack(nil)
        self.session = nil
    }
    
    func session(_ session: QBRTCSession!, connectionClosedForUser userID: NSNumber!) {
        print("connectionClosedForUser")
    }
    
    func session(_ session: QBRTCSession!, connectionFailedForUser userID: NSNumber!) {
        print("connectionFailedForUser")
        self.remoteView.setVideoTrack(nil)
        self.session = nil
    }
    
    func session(_ session: QBRTCSession!, startedConnectingToUser userID: NSNumber!) {
        print("startedConnectingToUser")
    }
    
    func session(_ session: QBRTCSession!, disconnectedByTimeoutFromUser userID: NSNumber!) {
        print("disconnectedByTimeoutFromUser")
    }
    
    func session(_ session: QBRTCSession!, hungUpByUser userID: NSNumber!, userInfo: [AnyHashable : Any]! = [:]) {
        print("hungUpByUser")
    }
    
    func session(_ session: QBRTCSession!, acceptedByUser userID: NSNumber!, userInfo: [AnyHashable : Any]! = [:]) {
        print("acceptedByUser")
    }
    
    func session(_ session: QBRTCSession!, rejectedByUser userID: NSNumber!, userInfo: [AnyHashable : Any]! = [:]) {
        print("rejectedByUser")
    }
    
    func session(_ session: QBRTCSession!, updatedStatsReport report: QBRTCStatsReport!, forUserID userID: NSNumber!) {
        print("updatedStatsReport", report)
    }
    
}
