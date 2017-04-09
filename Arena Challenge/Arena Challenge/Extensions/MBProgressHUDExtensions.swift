//
//  MBProgressHUDExtensions.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import MBProgressHUD
import RxCocoa
import RxSwift

extension MBProgressHUD {
    
    /**
     Bindable sink for MBProgressHUD show/hide methods.
     */
    public var rx_mbprogresshud_animating: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .next(let value):
                if let lastView = UIApplication.shared.keyWindow?.subviews.last {
                    if value {
                        MBProgressHUD.showAdded(to: lastView, animated: true)
                    } else {
                        MBProgressHUD.hide(for: lastView, animated: true)
                    }
                }
            case .error(let error):
                let error = "Binding error to UI: \(error)"
                #if DEBUG
                    fatalError(error)
                #else
                    print(error)
                #endif
            case .completed:
                break
            }
        }
    }
    
}
