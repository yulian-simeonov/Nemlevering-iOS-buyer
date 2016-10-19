//
//  PaymentRequest.m
//  AdyenClientsideEncryptionDemo
//
//  Created by Jeroen Koops on 8/22/13.
//  Copyright (c) 2013 Adyen. All rights reserved.
//

#import "PaymentRequest.h"
#import "NSDictionary+Util.h"
#import "Card.h"
#import "ADYEncrypter.h"

@interface PaymentRequest () <NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData* buffer;
@property (nonatomic, strong) NSHTTPURLResponse* response;
@end

@implementation PaymentRequest

- (void)submitWithMerchantAccount:(NSString *)merchantAccount
                         username:(NSString *)username
                         password:(NSString *)password
                        publicKey:(NSString *)publicKey
{
    NSError* error;
    
    NSString* encryptedCreditCardData = [ADYEncrypter encrypt:[self.card encode] publicKeyInHex:publicKey];
    
    if(!encryptedCreditCardData)
    {
        [self.delegate request:self failedWithError:error];
        return;
    }
    
    //    NSMutableDictionary* form = [NSMutableDictionary dictionary];
    //    form[@"action"] = @"Payment.authorise";
    //    form[@"paymentRequest.amount.currency"] = self.currency;
    //    form[@"paymentRequest.amount.value"] = self.amount;
    //    form[@"paymentRequest.merchantAccount"] = merchantAccount;
    //    form[@"paymentRequest.reference"] = self.txReference;
    //    form[@"paymentRequest.additionalData.card.encrypted.json"] = encryptedCreditCardData;
    //
    //    NSURL* targetURL = [NSURL URLWithString:@"https://pal-test.adyen.com/pal/adapter/httppost"];
    //    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:targetURL];
    //    req.HTTPMethod = @"POST";
    //    [req setValue:[self authHeaderWithUsername:username password:password] forHTTPHeaderField:@"Authorization"];
    //    req.HTTPBody = [[form encodeFormData] dataUsingEncoding:NSUTF8StringEncoding];
    //    self.buffer = [NSMutableData data];
    //    [NSURLConnection connectionWithRequest:req delegate:self];
    
    // https://github.com/Adyen/client-side-encryption/find/master
    
    
//    {
//        "card": {
//            "number": "4111111111111111",
//            "expiryMonth": "08",
//            "expiryYear": "2018",
//            "cvc": "737",
//            "holderName": "test"
//        },
//        "amount": {
//            "value": 500,
//            "currency": "US"
//        },
//        "additionalData":{
//            
//            "card":{
//                
//                "encrypted":{
//                    
//                    "json":"adyenan0_1_1$aQ7HFSMNc6pKiDVdxbABX/9fQxVRrV4Sl/ISfc3ZtLwtQQSUpoXNBzh/rCWv7ZLmCMv+gmbJmqfNpihgEdfRiAzPIrH2XwylYktfvAJEEXzvPwI9N9++BJ22F+vTT8ynD5E5JHVfSp9X5zsWL9xWE61qeTpjfHwZB5bamWVjWhapkNdeG1iu9keWHOV1sdydrhg/zJKd/WlGZWxMnBcAip5sWpnbcmfkoWut0MqakTV/FHW9f03OuQ/yyMuqVhigbrXKxp9uR6tJ5/wM5g0Frhl4fEuq5e64N7Yp9EgZ6zrrubs20lqk3whjW2FYTfdTf71iH3AP7QQ7Ije9pJZCGw==$NDwCM+dBWPLEh21/QkUiVPP9F3bDCcwg55mEmVTpjyT12Lmy1sxedAEiLtuaTjYd9iEfSkzIE6k6vwIDk3UUCREgTVzJX61ANGRg6BGexhniC7CB40y+TILLSOeHircgY9yTdcqBd949naw8sdvwy19xbxv+n7iexHjwVmL44QA5WcA="
//                }
//            }
//        },
//        "reference": "16206636490212",
//        "merchantAccount": "Cargo3IvsCOM",
//        "action":"Payment.authorise"
//    }
    
    NSMutableDictionary *objCardDic=[[NSMutableDictionary alloc]init];
    [objCardDic setObject:self.Number forKey:@"number"];
    [objCardDic setObject:self.ExpiryMonth forKey:@"expiryMonth"];
    [objCardDic setObject:self.ExpiryYear forKey:@"expiryYear"];
    [objCardDic setObject:self.cvc forKey:@"cvc"];
    [objCardDic setObject:self.holderName forKey:@"holderName"];
    
    NSMutableDictionary *objammountDic=[[NSMutableDictionary alloc]init];
    [objammountDic setValue:[NSNumber numberWithInteger:[self.amount intValue]] forKey:@"value"];
    [objammountDic setValue:self.currency forKey:@"currency"];
    
    NSMutableDictionary *objEncrytDic=[[NSMutableDictionary alloc]init];
    [objEncrytDic setValue:encryptedCreditCardData forKey:@"json"];
    
    NSMutableDictionary *objEnceyCard=[[NSMutableDictionary alloc]init];
    [objEnceyCard setValue:objEncrytDic forKey:@"encrypted"];
    
    NSMutableDictionary *objAdditionData=[[NSMutableDictionary alloc]init];
    [objAdditionData setValue:encryptedCreditCardData forKey:@"card.encrypted.json"];
    
    NSMutableDictionary *objDicPass=[[NSMutableDictionary alloc]init];
    [objDicPass setValue:objCardDic forKey:@"card"];
    [objDicPass setValue:objammountDic forKey:@"amount"];
    [objDicPass setValue:objAdditionData forKey:@"additionalData"];
    [objDicPass setValue:[NSString stringWithFormat:@"payment-%@",self.txReference] forKey:@"reference"];
    [objDicPass setValue:@"Cargo3IvsCOM" forKey:@"merchantAccount"];
    [objDicPass setValue:@"Payment.authorise" forKey:@"action"];
    NSLog(@"%@",objDicPass);
    
    NSError *errors = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:objDicPass options:NSJSONWritingPrettyPrinted error:&errors];
    
    NSString *s = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    NSLog(@"%@",s);
    
    NSURL* targetURL = [NSURL URLWithString:@"https://pal-test.adyen.com/pal/servlet/Payment/v12/authorise"];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:targetURL];
    req.HTTPMethod = @"POST";
    //application/json
    //Authorization
    [req setValue:[self authHeaderWithUsername:username password:password] forHTTPHeaderField:@"Authorization"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    req.HTTPBody =[s  dataUsingEncoding:NSUTF8StringEncoding];
    self.buffer = [NSMutableData data];
    [NSURLConnection connectionWithRequest:req delegate:self];
}
- (NSString*)authHeaderWithUsername:(NSString*)username password:(NSString*)password
{
    NSString* base64 = [[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat:@"Basic %@", base64];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate request:self failedWithError:error];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    self.response = response;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.buffer appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* responseString = [[NSString alloc] initWithData:self.buffer encoding:NSUTF8StringEncoding];
    if(self.response.statusCode == 200)
    {
        [self.delegate request:self finishedWithResponse:responseString];
    }
    else
    {
        [self.delegate request:self failedWithHTTPErrorCode:self.response.statusCode response:responseString];
    }
}

@end
