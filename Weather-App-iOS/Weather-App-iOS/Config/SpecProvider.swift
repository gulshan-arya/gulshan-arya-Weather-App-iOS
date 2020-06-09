
import Foundation

/// Spec provider for providing Spec required for Production and development environment
class SpecProvider {
    
    static let currentSpec: Spec = {
        #if DEBUG
        return ProdSpec()
        #elseif ADHOC
        return ProdSpec()
        #else
        return ProdSpec()
        #endif
    } ()
}
