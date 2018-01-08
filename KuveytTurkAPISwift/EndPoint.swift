//
//  EndPoint.swift
//  KuveytTurkAPISwift
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 27.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import p2_OAuth2

/**
 An Enum class about endpoints
 */
public class EndPoint {
    
    public enum EndPointType {
        case Accounts
        case AccountTransactions
        case Receipt
        case UserOTPSend
        case UserOTPVerify
        case MoneyTransferExecute
        case MoneyTransferToIBAN
        case MoneyTransferToAccount
        case MoneyTransferToName
        case FromATMByQRCode
        case MoneyTransferToGSM
        case ToGSMTransactions
        case MoneyTransferToGSMCancel
        case Loans
        case XTMS
        case ATMS
        case Banks
        case BankBranches
        case FxRates
        case FxCurrencyList
        case LoanCalculation
        case LoanCalculationParameter
        case LoanInstallments
        case LoanInfo
        case TestCustomerList
        case KuveytTurkBranches
    }
}



