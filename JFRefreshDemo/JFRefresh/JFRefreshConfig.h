//
//  JFRefresh.h
//  JFRefreshDemo
//
//  Created by M Jiang on 2019/3/11.
//  Copyright © 2019 Mr_J. All rights reserved.
//

#define IOS11_OR_LATER_SPACE(par) \
({\
float space = 0.0;\
if (@available(iOS 11.0, *))\
space = par;\
(space);\
})


#define K_TOP_SPACE IOS11_OR_LATER_SPACE(KWindow.safeAreaInsets.top)
#define K_TOP_ACTIVE_SPACE IOS11_OR_LATER_SPACE(MAX(0, KWindow.safeAreaInsets.top-20))
#define K_BOTTOM_SPACE IOS11_OR_LATER_SPACE(KWindow.safeAreaInsets.bottom)
