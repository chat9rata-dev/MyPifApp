//
//  WebserviceHelper.swift
//  GaitView
//
//  Created by Arth on 15/03/20.
//  Copyright © 2020 Arth. All rights reserved.
//

import UIKit

let baseUrl:String = "https://gaitview.com/a/"

class WebserviceHelper: NSObject {
    static let sharedInstance : WebserviceHelper = {
        let instance = WebserviceHelper()
        return instance
    }()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func executePOSTRequestWithUserInfo(userInfo:String, requestURL:String , isHud:Bool, hudView: UIView, successBlock:@escaping (_ response:Any,_ success:Bool )->Void, errorBlock:@escaping (_ error:Any)->Void)  -> Void
    {
        
       // if ConnectionCheck.isConnectedToNetwork(){
            
//            DispatchQueue.main.async {
//                if isHud{
//                    let spinnerActivity = MBProgressHUD.showAdded(to: hudView, animated: true);
//                    spinnerActivity.label.text = "Loading";
//                    spinnerActivity.detailsLabel.text = "Please Wait";
//                    spinnerActivity.isUserInteractionEnabled = false;
//                }
//            }
        
            let configuration = URLSessionConfiguration.default;
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            var urlString = String()
            urlString.append(baseUrl)
            urlString.append(requestURL)
            
            let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let serverUrl: URL = URL(string: (encodedUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!)!
            var request : URLRequest = URLRequest(url: serverUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120.0)
            
            let postData:Data = userInfo.data(using: .utf8)!
            let reqJSONStr = String(data: postData, encoding: .utf8)
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = reqJSONStr?.data(using: .utf8)
            
            let postDataTask : URLSessionDataTask = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                
                let httpResponse = response as? HTTPURLResponse
                let statusCode: Int? = httpResponse?.statusCode
                
                if statusCode == 200
                {
                    if data != nil && error == nil {
                        do {
                            
                            let responseStr = try JSONSerialization.jsonObject(with: (data)!, options: .mutableContainers) as! NSDictionary
                            print("responseStr\(responseStr)")
                            DispatchQueue.main.async {
                                successBlock(responseStr, true)
                            }
                        } catch let error as NSError {
                            
                            DispatchQueue.main.async {
                               // MBProgressHUD.hide(for: hudView, animated: true)
                                errorBlock(error.localizedDescription)
                            }
                        }
                    }
                    else {
                        
                        DispatchQueue.main.async{
                           // MBProgressHUD.hide(for: hudView, animated: true)
                        }
                        errorBlock((error?.localizedDescription)! as String)
                        
                    }
                    DispatchQueue.main.async{
                       // MBProgressHUD.hide(for: hudView, animated: true)
                    }
                }else{
                    DispatchQueue.main.async{
                       // MBProgressHUD.hide(for: hudView, animated: true)
                    }
                    errorBlock(statusCode as Any)
                }
                DispatchQueue.main.async{
                    //MBProgressHUD.hide(for: hudView, animated: true)
                }
            })
            postDataTask.resume()
    }

    func callGetDataWithMethod(userInfo:String,requestURL:String,isHud:Bool, hudView: UIView,successBlock:@escaping (_ response:Any,_ success:Bool)->Void, errorBlock:@escaping (_ error:Any)->Void)  {
        
//        if ConnectionCheck.isConnectedToNetwork(){
//            DispatchQueue.main.async {
//                if isHud{
//                    let spinnerActivity = MBProgressHUD.showAdded(to: hudView, animated: true);
//                    spinnerActivity.label.text = "Loading";
//                    spinnerActivity.detailsLabel.text = "Please Wait";
//                    spinnerActivity.isUserInteractionEnabled = false;
//                }
//            }
        
            var urlString = String()
            urlString.append(baseUrl)
            urlString.append(userInfo)
            
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            print(url!)
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
                
                let httpResponse = response as? HTTPURLResponse
                let statusCode: Int? = httpResponse?.statusCode
                
                if statusCode == 200
                {
                    if data != nil && error == nil{
                        do {
                            
                            let responseStr = try JSONSerialization.jsonObject(with: (data)!, options: .mutableContainers) as! NSDictionary
                            print("responseStr:\(responseStr)")
                            
                            DispatchQueue.main.async {
                                successBlock(responseStr,true)
                            }
                        } catch let error as NSError {
                            
                            DispatchQueue.main.async {
                               // MBProgressHUD.hide(for: hudView, animated: true)
                                errorBlock(error.localizedDescription)
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                           // MBProgressHUD.hide(for: hudView, animated: true)
                            errorBlock(error?.localizedDescription ?? "")
                        }
                    }
                }else {
                    DispatchQueue.main.async {
                       // MBProgressHUD.hide(for: hudView, animated: true)
                        errorBlock(statusCode as Any)
                    }
                    
                }
                DispatchQueue.main.async {
                   // MBProgressHUD.hide(for: hudView, animated: true)
                }
            })
            dataTask.resume()
        
    }
    
}
