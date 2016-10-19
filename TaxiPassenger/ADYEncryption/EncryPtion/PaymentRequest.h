//
//  PaymentRequest.h
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CardDataViewController.h"

@class PaymentRequest;
@class Card;

@protocol PaymentRequestDelegate 

- (void)request:(PaymentRequest*)request
failedWithError:(NSError*)error;

- (void)request:(PaymentRequest*)request
finishedWithResponse:(NSString*)response;

- (void)request:(PaymentRequest*)request
failedWithHTTPErrorCode:(NSUInteger)HTTPErrorCode
       response:(NSString*)response;
@end

@interface PaymentRequest : NSObject

@property (nonatomic, strong) Card* card;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, assign) NSString *amount;
@property (nonatomic, strong) NSString* txReference;
@property (nonatomic, strong) NSString* Number;
@property (nonatomic, strong) NSString* ExpiryMonth;
@property (nonatomic, strong) NSString* ExpiryYear;
@property (nonatomic, strong) NSString* cvc;
@property (nonatomic, strong) NSString* holderName;

@property (nonatomic, weak) id<PaymentRequestDelegate> delegate;

- (void)submitWithMerchantAccount:(NSString*)merchantAccount
                         username:(NSString*)username
                         password:(NSString*)password
                        publicKey:(NSString*)publicKey;
@end
