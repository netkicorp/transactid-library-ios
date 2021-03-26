//
//  OpenSSLCommonHelper.cpp
//  transactId-library-ios
//
//  Created by Developer on 15.03.2021.
//

#include "OpenSSLCommonHelper.h"
#include <stdio.h>

namespace transact_id_ssl {

void reportError(Operation& op)
{
    BioString info;
    ERR_print_errors(info.get());
    op.errorInfo = info.toString();
}

}
