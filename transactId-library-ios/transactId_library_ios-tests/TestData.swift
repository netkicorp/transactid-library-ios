//
//  TestData.swift
//  transactId_library_ios-tests
//
//  Created by Developer on 24.02.2021.
//

import Foundation
import transactId_library_ios

struct TestData {
    
    struct ClientKeys {
        
        static let clientPrivateKeyChainOne =
            "-----BEGIN PRIVATE KEY-----\n" +
            "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6Cewmk32GFk2H\n" +
            "LvXDA+zRmDvQ0AgStmxnAbuwkSliENEZ3o12ATqT1mTelYqslfBQ7Q9Tw3bb28me\n" +
            "8tH0DIpuiqI6KFI+YifJ7R4ajPfPndhR404C4UfvsvZA3GigvUqG65wkFccmxnwL\n" +
            "XvNlOI5iPx9sERZ2Gdew6HJyW6pWJeh1b5N6LLL//TL2FzO/yOoSFhW+4yTelwjW\n" +
            "n8tOeJAcsNFCQdC8KSy2+MNqR7OuLLphi0io8ZponVfp2/pU/nXyglB82se97PBR\n" +
            "nLG4AqQ7FKgtfXQohK0mq2lHdfJTilsQSOQdt9NxqGTOGijMnZU2/+UnLsAQQSeI\n" +
            "CYFpl7whAgMBAAECggEAFEvs1bCVq0FXp/35lhMhjSRcskVf/Bqm7P4FahgMOcS3\n" +
            "62iaaltr9qEXVClgfb/F/i4+09apawcpkgvP2B5eI/1AAbRQdLnkuWUDOcZTavU/\n" +
            "mn+ADVRissYFk8H4MEE2lk2yNUWi+poBAoSTbWGkNxfH59RdbPkYzRYvFkbl6Iv+\n" +
            "W5EYb1Gho16rLImgoOfD0Q1qBd2AXD3DTNwFrx+M7cxBn+33U4oBlFhIXbhzuxBW\n" +
            "BXcKsm3zm/wggqdomRJt7Vr5NHflXIWM9nP+YxDrNTEB7+ZlvpAqTDl3k7bYRiCW\n" +
            "ZS5g64U2Zu5rC5gs401RwXIHCwWyOgYgaPQeol7tOQKBgQDxGEXxaa5X2bRbq+bw\n" +
            "VFyzWCsuAR6gYw9d3lnrKpNyA0wUHimlyDdlFs27xRcz/7zAVDg39X3LfXuG3LM8\n" +
            "pHuZ1/QeeCVxqAB2L2Mb4kGlmteCb5xh+WpzAInaoCMxsGZFIc7P24YBJn6mdQB9\n" +
            "M099JVjUkF9X8W17meRiYIwfbwKBgQDFikuloUiLPArhV+ic+45qr0aGhdvIO7jz\n" +
            "akw6rw64XfOwmlWiadX0p57LkNLIc+5TpCpQc43xppzAH7VoGarID6ODvll4A1gx\n" +
            "zx/9s2geaoZcxqzPRHHqplGKvpS0SSuDpNXy9tublGOanXFNPNnoR13dEKlELtq+\n" +
            "y9Nb9N4VbwKBgQCsJ6YB/XGVn4nvD6/HGqZbFfE3V2tUIYgegiB5ERzaA8q2btdU\n" +
            "XsRXddIQa2rnIYzZVQoTw0NBI+gp47xE6DquHwtdGnO6VbmGqs29YnF33DpZFHN5\n" +
            "bkz5s3+8Ui7vU0Ojx8FSoTFt7tvu5osj25i+BwYIOtMqC+YepUP0j3ZfFwKBgBuD\n" +
            "b5XaKOh7rGhGfjefMe7aCtChxELXTqNYotVpnHtBWre2R0cfxpUU46EmwrT4sLEl\n" +
            "pF8gORz3P83inLmrGYZT50pqMLvue1I0rxf+7PmPjLdPVLJprhQopiLU+JFDv7PO\n" +
            "OZ5lk6DPwi++zhEb8J3Rktk/gNPmUsFQUlf0exoxAoGBANHXbF04uRA9W7z7wEke\n" +
            "a99zEZ2Kqhx/td8kD+BIIBzCM3sZa3K0X1CkimzPbcKc7CHC/m71zoUuIzPIhInR\n" +
            "+8tKJBCl9JZy8EA6/C7MPUn1/vgHNu5kl953bUP87f/2MAw7thUtIQ8bel/NfxOc\n" +
            "HQXlAbM9ti7vD4xl3iK1uDfQ\n" +
            "-----END PRIVATE KEY-----\n"
        
        static let clientPrivateKeyChainTwo =
            "-----BEGIN PRIVATE KEY-----\n" +
            "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCNlLtFpZsqX91p\n" +
            "QQ9Ko6Tok+OcpXzgsB9LD4SG91HE7fbgWC+OFZ9adczJ6E/NoznepqEma0NBODqp\n" +
            "2LU+aKSgzZ1kvKnNiKTElO8r5KKi3+4+fLkKG23vDTv16M6gQp6bu1lWjt8nCnoF\n" +
            "+85tcu3oFEl1dfbQybLTMkfqwMYvQRn+omC9PfLWN2CcX+86Kp/Ci4J4Kq3Oe10S\n" +
            "H2vJit+INjtuYWbwia7art3nQ+4HajR2rigVS3oAwvqZKAqZLaKEoIp2J+9AfN3J\n" +
            "Ky8gw8xOpbgpWIVPGK5X5Z7jXYE0e/FRSblYGjMS63OYqktXZHn5yS9u+wtD1TUv\n" +
            "oMDqd/aNAgMBAAECggEAIiI0ySyNPXjZyFW5YlEUQcdf5YUHV6NWlBHkbWakleIa\n" +
            "NknEg1Cmt9g1PItv6/+5hLqvGPRcxVVRXWAECE0Rvbv8wYvzszwJn2RZyj8Hz9VF\n" +
            "mtaWhP+KcEsERPvxDvWoyBpxxjrRRZgSxa0I/l2qSlzTvggn7nvmS2EwsgHydfMz\n" +
            "/P1u1ZddbaYPj7U/tORfdXWnwHBbDpMs2mTL/yybrOfkf3d1sYD8qYiZcK0ALULn\n" +
            "wpsgpxJulQKQTuNdkot8G/KvmZCdhHYS/gs+StK1hOmk+8G6LzyE2FaNAWH1u/6D\n" +
            "+oxJMl1ow86fpY29c27Tkkm528YgQiljcdGfAaBq+QKBgQDFh/7reoZgjEQyjqsW\n" +
            "coQaagbLAg7ST+g8/GbBWlhxpRSxCEabi3GpV8UPEv2rg7LVzNTXJ97pM4pUUGz6\n" +
            "iEQgtEvxkiCuxT+Hce99D+HhtgSOdq56cX2n8/7QMM82HVHSgBbyBpOqGjBpz3AY\n" +
            "zyVBtTbGPvkJb3UGciCrn02VmQKBgQC3fRWQv1RgckcOQJGF7mrMM3dNQgqDT4UA\n" +
            "jdnG4ckvjYRgRWrRqm/IUrpBMlRh6xsQ6qr8Ts1spKX/Yp+JJamKxEJP63MUq1GA\n" +
            "ctR3JjumtOqDI97C9NxSpxHfHZKKXHIJ5iXM93BsyMP9oJ5AG18LiBHgOLqdh188\n" +
            "sOsOtyzZFQKBgD3719VipEolmbzXof4wPx3eyXTol2gNZQ3GEiR4SiqXJ7AJrcZf\n" +
            "cnI2NYLubaVldTe7x8ogG8XHw4+DkT7ohaBRk0chmJnfEXlaGlF/K11ddX6S5VtM\n" +
            "w6ZxXTNNLaiIeMV6JjkaMTn+b9S0IDPYxJMi3yZEWndIf0tfgrr4CSt5AoGABHzv\n" +
            "wRmc87r31/ZmWNNLE3GS0nXyEeIpC6lskTvGkv4wJbas9THpCApV+fBENhztDY3f\n" +
            "3soCpkykrsl3w4ADVJyWTqQgrXm/RZgJcFykCuDT958x/KzGktL5Ue7EPdQjCfDy\n" +
            "LcBDpLWIbbS3CjRhL8QFQ+m/TskX4EEnjrWWSD0CgYEApoVwVTAS4Wv4wXSeeBmA\n" +
            "2SgORVnnmrhT5ahd8g1s4tAD295Slnlp486Qhi9fKQpbQOw0TogbSQGalUc319/3\n" +
            "UWlNlu5Eu6TuAdCmY3KJNrnCERq+AJ+t2fakA5CL53EzpDmXDPmDKS7iEaOOXw2M\n" +
            "UM5JZTOfmyf5CwE2lNBZryI=\n" +
            "-----END PRIVATE KEY-----\n"
    }
    
    struct Certificates {
        static let clientCertificateChainOne =
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIDfTCCAmWgAwIBAgIEXnQAUDANBgkqhkiG9w0BAQsFADCBjzELMAkGA1UEBhMC\n" +
            "T04xGDAWBgNVBAgMD0ludGVybWVkaWF0ZU9uZTEYMBYGA1UEBwwPSW50ZXJtZWRp\n" +
            "YXRlT25lMRgwFgYDVQQKDA9JbnRlcm1lZGlhdGVPbmUxGDAWBgNVBAsMD0ludGVy\n" +
            "bWVkaWF0ZU9uZTEYMBYGA1UEAwwPSW50ZXJtZWRpYXRlT25lMB4XDTIwMDMxOTIz\n" +
            "MjkyMFoXDTIxMDMxOTIzMjkyMFowcTELMAkGA1UEBhMCT04xEjAQBgNVBAgMCUNs\n" +
            "aWVudE9uZTESMBAGA1UEBwwJQ2xpZW50T25lMRIwEAYDVQQKDAlDbGllbnRPbmUx\n" +
            "EjAQBgNVBAsMCUNsaWVudE9uZTESMBAGA1UEAwwJQ2xpZW50T25lMIIBIjANBgkq\n" +
            "hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAugnsJpN9hhZNhy71wwPs0Zg70NAIErZs\n" +
            "ZwG7sJEpYhDRGd6NdgE6k9Zk3pWKrJXwUO0PU8N229vJnvLR9AyKboqiOihSPmIn\n" +
            "ye0eGoz3z53YUeNOAuFH77L2QNxooL1KhuucJBXHJsZ8C17zZTiOYj8fbBEWdhnX\n" +
            "sOhycluqViXodW+Teiyy//0y9hczv8jqEhYVvuMk3pcI1p/LTniQHLDRQkHQvCks\n" +
            "tvjDakezriy6YYtIqPGaaJ1X6dv6VP518oJQfNrHvezwUZyxuAKkOxSoLX10KISt\n" +
            "JqtpR3XyU4pbEEjkHbfTcahkzhoozJ2VNv/lJy7AEEEniAmBaZe8IQIDAQABMA0G\n" +
            "CSqGSIb3DQEBCwUAA4IBAQA3izgEbJtKGeoBB330R3INTw4zqCDsYGN/y9/jFU++\n" +
            "ituiKjQBYinDkIOs2neoyDNDIy7Cml1v5kD5P7jwO1QyaE1fKu+ZvND2trPBX4LA\n" +
            "b5kgibJTE/QM/YNj2sXBi6ZF6v/2eGmZBIX92fAJluqWcDhzHl6uCzsT72mEc9J9\n" +
            "Vop6imfwWoX/121m2he0wBA540xidEWMPbX2E1kzKQiDxCtuOZIGbNBJLRfMcRqJ\n" +
            "uM8fZSL3kJJIqTXRveKFyexmPNUljfvAQfkzGuQC6acMIQmwR/7YBido4gO4Ib2r\n" +
            "jiG80ehyepS2B16NaB0ckigkhZtpjeXYauadsvpH6Fro\n" +
            "-----END CERTIFICATE-----\n"
        
        static let clientCertificateChainTwo =
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIDfTCCAmWgAwIBAgIEXnQF+TANBgkqhkiG9w0BAQsFADCBjzELMAkGA1UEBhMC\n" +
            "VFcxGDAWBgNVBAgMD0ludGVybWVkaWF0ZVR3bzEYMBYGA1UEBwwPSW50ZXJtZWRp\n" +
            "YXRlVHdvMRgwFgYDVQQKDA9JbnRlcm1lZGlhdGVUd28xGDAWBgNVBAsMD0ludGVy\n" +
            "bWVkaWF0ZVR3bzEYMBYGA1UEAwwPSW50ZXJtZWRpYXRlVHdvMB4XDTIwMDMxOTIz\n" +
            "NTMyOVoXDTIxMDMxOTIzNTMyOVowcTELMAkGA1UEBhMCVFcxEjAQBgNVBAgMCUNs\n" +
            "aWVudFR3bzESMBAGA1UEBwwJQ2xpZW50VHdvMRIwEAYDVQQKDAlDbGllbnRUd28x\n" +
            "EjAQBgNVBAsMCUNsaWVudFR3bzESMBAGA1UEAwwJQ2xpZW50VHdvMIIBIjANBgkq\n" +
            "hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjZS7RaWbKl/daUEPSqOk6JPjnKV84LAf\n" +
            "Sw+EhvdRxO324FgvjhWfWnXMyehPzaM53qahJmtDQTg6qdi1PmikoM2dZLypzYik\n" +
            "xJTvK+Siot/uPny5Chtt7w079ejOoEKem7tZVo7fJwp6BfvObXLt6BRJdXX20Mmy\n" +
            "0zJH6sDGL0EZ/qJgvT3y1jdgnF/vOiqfwouCeCqtzntdEh9ryYrfiDY7bmFm8Imu\n" +
            "2q7d50PuB2o0dq4oFUt6AML6mSgKmS2ihKCKdifvQHzdySsvIMPMTqW4KViFTxiu\n" +
            "V+We412BNHvxUUm5WBozEutzmKpLV2R5+ckvbvsLQ9U1L6DA6nf2jQIDAQABMA0G\n" +
            "CSqGSIb3DQEBCwUAA4IBAQB+Dfgw9N7jXsrnisk+qOH9p82FjMHyc0/R6W6PFdU2\n" +
            "3BXWhvQTZmkDui046odoa/UB7+ia+7q3xWVYjGR898pFSkqXAcy7GMQ6+ueMFo1W\n" +
            "Qdxg8daY5hUGJxvw6XP9POM9nABYdbmm1xyi9wg2vULoGtVfK0VSEDCFmEzcxYzO\n" +
            "Q+Cb6Zr637DKZm1JRPloIORkIewKSc9vBw9W2IEzlgfT3fVAgmBmFlJhfn9OkdDF\n" +
            "RPDatFu5D271ai0cZgp2nJ0OajqCi37czy5fF2KZ/RMg7sj5PwRcnLKgaieYck+Z\n" +
            "JcbgrTguZRQi0GI2V24OiEzuGRLxQIgHuFBHUR7B820f\n" +
            "-----END CERTIFICATE-----\n"
        
        static let evCert =
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIHdDCCBlygAwIBAgIQB0Haxhm5e7comqWUzibAzTANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQ\n" +
            "GEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMT\n" +
            "QwMgYDVQQDEytEaWdpQ2VydCBTSEEyIEV4dGVuZGVkIFZhbGlkYXRpb24gU2VydmVyIENBMB4XD\n" +
            "TIwMDMxMDAwMDAwMFoXDTIyMDMxNTEyMDAwMFowgdwxHTAbBgNVBA8MFFByaXZhdGUgT3JnYW5p\n" +
            "emF0aW9uMRMwEQYLKwYBBAGCNzwCAQMTAlVTMRkwFwYLKwYBBAGCNzwCAQITCERlbGF3YXJlMRA\n" +
            "wDgYDVQQFEwczMDE0MjY3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTERMA8GA1\n" +
            "UEBxMIU2FuIEpvc2UxFTATBgNVBAoTDFBheVBhbCwgSW5jLjEUMBIGA1UECxMLQ0ROIFN1cHBvc\n" +
            "nQxFzAVBgNVBAMTDnd3dy5wYXlwYWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
            "AQEAzV89zboBlCiAoOYvIuxNozHpQYGRrKI2f3JHuJL4wWc+v80i1jvWglmQnI7gBrA9eoB5qSM\n" +
            "HU3+f3ubXqwO5teSn5UYasemZw4wPpfU5w5iviSn7xuDK748x9IRXu6kyCMT/NnLLAE/wuVaNnT\n" +
            "K8PZG50UKNicN3R1i6noAWphNJe98stO4CjD1YX6qUkCID2QRNaewR/q3GPZcXyYGpovabx4JBC\n" +
            "AfoyrwX7MMSashX/HcapZO3wbsF+tO3GE1ZIuTxm3QHYDvDTkUbPtft7S5ggv5Wt9UUYC3PieLt\n" +
            "JFBED3zCiFjWNv97H/ozZdlWC27GHSnfh4OFqNynOta4kwIDAQABo4IDljCCA5IwHwYDVR0jBBg\n" +
            "wFoAUPdNQpdagre7zSmAKZdMh1Pj41g8wHQYDVR0OBBYEFKdHmNESeNtRMvqNvx0ubsMOzcztME\n" +
            "AGA1UdEQQ5MDeCDnd3dy5wYXlwYWwuY29tghF3d3ctc3QucGF5cGFsLmNvbYISaGlzdG9yeS5wY\n" +
            "XlwYWwuY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIw\n" +
            "dQYDVR0fBG4wbDA0oDKgMIYuaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL3NoYTItZXYtc2VydmV\n" +
            "yLWcyLmNybDA0oDKgMIYuaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItZXYtc2VydmVyLW\n" +
            "cyLmNybDBLBgNVHSAERDBCMDcGCWCGSAGG/WwCATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3d\n" +
            "y5kaWdpY2VydC5jb20vQ1BTMAcGBWeBDAEBMIGIBggrBgEFBQcBAQR8MHowJAYIKwYBBQUHMAGG\n" +
            "GGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBSBggrBgEFBQcwAoZGaHR0cDovL2NhY2VydHMuZGl\n" +
            "naWNlcnQuY29tL0RpZ2lDZXJ0U0hBMkV4dGVuZGVkVmFsaWRhdGlvblNlcnZlckNBLmNydDAMBg\n" +
            "NVHRMBAf8EAjAAMIIBgAYKKwYBBAHWeQIEAgSCAXAEggFsAWoAdwDuS723dc5guuFCaR+r4Z5mo\n" +
            "w9+X7By2IMAxHuJeqj9ywAAAXDFcnb8AAAEAwBIMEYCIQDwuzYl2COuAY6OhOQOkKHFwydBzAHq\n" +
            "0nfq+sjx4pMShgIhAMupFpT63PmXJRf9yYmAawHFYfJG42Am1LKIfjcxOdRQAHcAVhQGmi/Xwuz\n" +
            "T9eG9RLI+x0Z2ubyZEVzA75SYVdaJ0N0AAAFwxXJ3HgAABAMASDBGAiEA9sLqzoClOirtBp0Hi2\n" +
            "EbFPMoNsagZ5KJ1lNm1FZrAdcCIQDbXiRH/kFOqNmaszNY/CVCeZaezHyWrDj3piruCc4VEAB2A\n" +
            "LvZ37wfinG1k5Qjl6qSe0c4V5UKq1LoGpCWZDaOHtGFAAABcMVydsAAAAQDAEcwRQIgMAg0E301\n" +
            "jaPus8jRHECx3EB4dmx9i9YGmpm/ewljFBoCIQDtdorg7IAj58ZOUNtassnYFj4cshHP8HqAx0d\n" +
            "sJzngzDANBgkqhkiG9w0BAQsFAAOCAQEALew4jcCp55VpcnPhSzHQSpOV3oHCu1BXeRgvHLk2sg\n" +
            "Fs+DFHjyTnhPlozShKhvgksPMO3BhNGCvYqXNubiFDIJSnM9l8p4d8JY0JTV/kt5GR5S0h+zyHY\n" +
            "NpfDw+zBCS8TjJf4zmGNY1VulJy9JEikJXOqvzAn+uy7KKXZnjYHoPMJkSJ8iH8FF5C3s8mbfmF\n" +
            "jYM1RWSS44pdezTfJJ/mmjpSMyclihBXK1vmFTxDQaxtLhisYbNd5hxxDw2oZTYibruc4ELBmJZ\n" +
            "BbryicaBSbmB4pVFCC5JfykI2dP/TyTCxV+Wy++cjjAUehq19e/LdQ2orgofqpAFKjqT1nSkteA\n" +
            "==\n" + 
            "-----END CERTIFICATE-----\n"
        
        
        static let clientCertificateChainTwoBundle =
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIDkjCCAnqgAwIBAgIEXnQF2jANBgkqhkiG9w0BAQsFADBnMQswCQYDVQQGEwJU\n" +
            "VzEQMA4GA1UECAwHUm9vdFR3bzEQMA4GA1UEBwwHUm9vdFR3bzEQMA4GA1UECgwH\n" +
            "Um9vdFR3bzEQMA4GA1UECwwHUm9vdFR3bzEQMA4GA1UEAwwHUm9vdFR3bzAeFw0y\n" +
            "MDAzMTkyMzUyNThaFw0yMTAzMTkyMzUyNThaMIGPMQswCQYDVQQGEwJUVzEYMBYG\n" +
            "A1UECAwPSW50ZXJtZWRpYXRlVHdvMRgwFgYDVQQHDA9JbnRlcm1lZGlhdGVUd28x\n" +
            "GDAWBgNVBAoMD0ludGVybWVkaWF0ZVR3bzEYMBYGA1UECwwPSW50ZXJtZWRpYXRl\n" +
            "VHdvMRgwFgYDVQQDDA9JbnRlcm1lZGlhdGVUd28wggEiMA0GCSqGSIb3DQEBAQUA\n" +
            "A4IBDwAwggEKAoIBAQDVJEP4dvW0xHOeMB0MRygxXOm4hEVE+A37BC3bxNgiJ1Fs\n" +
            "4s64C04WozcGnbN299tAe8WQtz4pF6f1GO7747YaxPOYRPYF9lmdYml6VGked44H\n" +
            "2/dbREDQzY8ky5oBNzuXe//rrFBRr7TIBycWM8a8f8zqkp+qRNDDMyzGMLRpz1V4\n" +
            "JhnOOZIeGHz18r9VD+EHJqX3XTBLmaM4LpEmu96BzVtfIRaFaHSn3uaki/xTGbs1\n" +
            "FzjST9PBfRdjdOT07ggpVi0SDSeGMZksZaPxVB8pdhlg28tXC6Jg8iiJ9oRZbD27\n" +
            "kJxjSxjMasSKm4y9jGyWZXP8ykk1vUaOceE+I5T5AgMBAAGjHTAbMAwGA1UdEwQF\n" +
            "MAMBAf8wCwYDVR0PBAQDAgEGMA0GCSqGSIb3DQEBCwUAA4IBAQBjEBeablJOLo+8\n" +
            "2f+FCvM4Bm7xGR6rZEkWWva6hW5IUF63V3/a5dOyLbhTlOMYC24DnKL79oofFQHC\n" +
            "Ow2efBBn17wd3YaY7wcXda7fKZSxnzVnJslkPUBap9HwhCE8Betqu1kGZ8/5O9g7\n" +
            "7z79MqA5hIy42RYwK24Ha4TGqWyrzdsc9M+RBox20Gxsl7GY2wYN43GNgL224AYu\n" +
            "RfTeb0eTdQmyrusy4my732tAbodeiCQWwxQb/x8p2TbS7prPv7YKN0HjZjsGett6\n" +
            "Q77cTzYd5oAWSmNC7w9ujS5MwCfb/fYhYV116iiYSps+85TFDT2M2llxjnAZiIe7\n" +
            "+3W2KK5G\n" +
            "-----END CERTIFICATE-----\n" +
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIDfTCCAmWgAwIBAgIEXnQF+TANBgkqhkiG9w0BAQsFADCBjzELMAkGA1UEBhMC\n" +
            "VFcxGDAWBgNVBAgMD0ludGVybWVkaWF0ZVR3bzEYMBYGA1UEBwwPSW50ZXJtZWRp\n" +
            "YXRlVHdvMRgwFgYDVQQKDA9JbnRlcm1lZGlhdGVUd28xGDAWBgNVBAsMD0ludGVy\n" +
            "bWVkaWF0ZVR3bzEYMBYGA1UEAwwPSW50ZXJtZWRpYXRlVHdvMB4XDTIwMDMxOTIz\n" +
            "NTMyOVoXDTIxMDMxOTIzNTMyOVowcTELMAkGA1UEBhMCVFcxEjAQBgNVBAgMCUNs\n" +
            "aWVudFR3bzESMBAGA1UEBwwJQ2xpZW50VHdvMRIwEAYDVQQKDAlDbGllbnRUd28x\n" +
            "EjAQBgNVBAsMCUNsaWVudFR3bzESMBAGA1UEAwwJQ2xpZW50VHdvMIIBIjANBgkq\n" +
            "hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjZS7RaWbKl/daUEPSqOk6JPjnKV84LAf\n" +
            "Sw+EhvdRxO324FgvjhWfWnXMyehPzaM53qahJmtDQTg6qdi1PmikoM2dZLypzYik\n" +
            "xJTvK+Siot/uPny5Chtt7w079ejOoEKem7tZVo7fJwp6BfvObXLt6BRJdXX20Mmy\n" +
            "0zJH6sDGL0EZ/qJgvT3y1jdgnF/vOiqfwouCeCqtzntdEh9ryYrfiDY7bmFm8Imu\n" +
            "2q7d50PuB2o0dq4oFUt6AML6mSgKmS2ihKCKdifvQHzdySsvIMPMTqW4KViFTxiu\n" +
            "V+We412BNHvxUUm5WBozEutzmKpLV2R5+ckvbvsLQ9U1L6DA6nf2jQIDAQABMA0G\n" +
            "CSqGSIb3DQEBCwUAA4IBAQB+Dfgw9N7jXsrnisk+qOH9p82FjMHyc0/R6W6PFdU2\n" +
            "3BXWhvQTZmkDui046odoa/UB7+ia+7q3xWVYjGR898pFSkqXAcy7GMQ6+ueMFo1W\n" +
            "Qdxg8daY5hUGJxvw6XP9POM9nABYdbmm1xyi9wg2vULoGtVfK0VSEDCFmEzcxYzO\n" +
            "Q+Cb6Zr637DKZm1JRPloIORkIewKSc9vBw9W2IEzlgfT3fVAgmBmFlJhfn9OkdDF\n" +
            "RPDatFu5D271ai0cZgp2nJ0OajqCi37czy5fF2KZ/RMg7sj5PwRcnLKgaieYck+Z\n" +
            "JcbgrTguZRQi0GI2V24OiEzuGRLxQIgHuFBHUR7B820f\n" +
            "-----END CERTIFICATE-----\n"
        
        
        static let clientCertificateRandom =
            "-----BEGIN CERTIFICATE-----\n" +
            "MIIDODCCAiCgAwIBAgIEXkrp+zANBgkqhkiG9w0BAQsFADBeMQswCQYDVQQGEwJV\n" +
            "UzEOMAwGA1UECAwFU3RhdGUxDjAMBgNVBAcMBUxvY2FsMQ4wDAYDVQQKDAVOZXRr\n" +
            "aTEOMAwGA1UECwwFTmV0a2kxDzANBgNVBAMMBlJvb3RDQTAeFw0yMDAyMTcxOTMx\n" +
            "MDdaFw0yMTAyMTYxOTMxMDdaMF4xCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJDQTEL\n" +
            "MAkGA1UEBwwCTEExDjAMBgNVBAoMBW5ldGtpMQ4wDAYDVQQLDAVOZXRraTEVMBMG\n" +
            "A1UEAwwMSW50ZXJtZWRpYXRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
            "AQEAzKJrRrpp87AeHPrBNLe6xJE347KzhQwmNubbgUtdLKkhM1CDVaYBIJH3w5yX\n" +
            "3YFy3QGoiLscfiNGCBT7770IKOE221xUvYZxvbJ7NW244yKmy+qqnMWgNIfnoYj9\n" +
            "ns1W2iWHlJ6PMtpGBx87bYjwOaAWIfO0imF/4pDm6ncqeIkGlUDBqRzbTvlT41SX\n" +
            "oadpKlckgeKo8g6CpRtmXC3ExLL7sr2kByrbnkmVD8Uuny/stnSFFm4MR6j673IA\n" +
            "pWykF3xJCj82NHiky+FiUUqgFkVfsyQNgmslj8rycPKUu4JJPghm21MO7Q5/jvZo\n" +
            "78Q6foIrYqDB7SobCRwROTg7pQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQClgqAR\n" +
            "DcIWmEsOwoUbdgcrhPR/OPOBlRPW69KFZ6WC5nJO6nZ0uN+f+pB75e/g2+p4YrYk\n" +
            "ZMauJyQbj3H9Aff8MN5G/zrHZLEiPeWj2Bub7jnYHjlIPU8r2mmZbhTFmZEqoBLe\n" +
            "1o3maTe9jk1B3uabZQA5MrkZjTG8ZXxALGmvKAmGqqpMvVyN/EEge4bjtwS5cK9E\n" +
            "WeCdur5Pw+N2P9UrPCd4MruOvRUBA3BJYOdFEwBs5C3+qze05n+mnOIhQZlahk+T\n" +
            "gk6jjkVPemLUkvvEoKwfGGbBvS8ypzUNdk38NzHhJQW6RPkq5lXRvlNsW/OBaBcb\n" +
            "YdVfDDGxbfz8wx8m\n" +
            "-----END CERTIFICATE-----"
        
    }
    
    struct Originators {
        static let primaryOriginatorPkiX509SHA256 = OriginatorParameters(isPrimaryForTransaction: true,
                                                                         pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                 TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let primaryOriginatorPkiX509SHA256BundledCertificate = OriginatorParameters(isPrimaryForTransaction: true,
                                                                                           pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256BundleCertificate,
                                                                                                                   TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let primaryOriginatorPkiNone = OriginatorParameters(isPrimaryForTransaction: true, pkiDataParametersSets: [TestData.PkiData.pkiDataOwnerNone])
        
        static let primaryOriginatorPkiX509SHA256InvalidCertificate = OriginatorParameters(isPrimaryForTransaction: true,
                                                                                           pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256InvalidCertificate,
                                                                                                                   TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let noPrimaryOriginatorPkiX509SHA256 = OriginatorParameters(isPrimaryForTransaction: false,
                                                                           pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                   TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let noPrimaryOriginatorPkiNone = OriginatorParameters(isPrimaryForTransaction: false, pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                                             TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        
    }
    
    struct PkiData {
        
        static let pkiDataOneOwnerX509SHA256 = PkiDataParameters(attestation: Attestation.legalPersonSecondaryName,
                                                                 privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainOne,
                                                                 certificatePem: TestData.Certificates.clientCertificateChainOne,
                                                                 type: .x509sha256)
        
        static let pkiDataOneOwnerX509SHA256InvalidCertificate = PkiDataParameters(attestation: TestData.Attestations.invalidAttestation,
                                                                                   privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainOne,
                                                                                   certificatePem: TestData.Certificates.clientCertificateRandom,
                                                                                   type: .x509sha256)
        
        static let pkiDataTwoOwnerX509SHA256 = PkiDataParameters(attestation: Attestation.legalPersonPrimaryName,
                                                                 privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainTwo,
                                                                 certificatePem: TestData.Certificates.clientCertificateChainTwo,
                                                                 type: .x509sha256)
        
        static let pkiDataOwnerNone = PkiDataParameters(attestation: nil,
                                                        privateKeyPem: "",
                                                        certificatePem:  "",
                                                        type: .none)
        
        static let pkiDataSenderX509SHA256 = PkiDataParameters(attestation: nil,
                                                               privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainTwo,
                                                               certificatePem: TestData.Certificates.clientCertificateChainTwo,
                                                               type: .x509sha256)
        
        static let pkiDataOneOwnerX509SHA256BundleCertificate = PkiDataParameters(attestation: .legalPersonPrimaryName,
                                                                                  privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainTwo,
                                                                                  certificatePem: TestData.Certificates.clientCertificateChainTwoBundle,
                                                                                  type: .x509sha256)
        
        static let pkiDataSenderNone = PkiDataParameters(attestation: nil,
                                                         privateKeyPem: "",
                                                         certificatePem:  "",
                                                         type: .none)
        
        static let pkiDataSenderX509SHA256InvalidCertificate = PkiDataParameters(attestation: nil,
                                                                                 privateKeyPem: TestData.ClientKeys.clientPrivateKeyChainTwo,
                                                                                 certificatePem: TestData.Certificates.clientCertificateRandom,
                                                                                 type: .x509sha256)
        
    }
    
    // MARK: Encryptions
    
    struct Encryptions {
        
        static let senderPrivateKeyPem =
            "-----BEGIN PRIVATE KEY-----\n" +
            "MD4CAQAwEAYHKoZIzj0CAQYFK4EEAAoEJzAlAgEBBCDmzegt2/QGTfn0M+BL398D\n" +
            "RwzaPGd2F04yfFqXxRPJKg==\n" +
            "-----END PRIVATE KEY-----"
        
        static let senderPublicKeyPem =
            "-----BEGIN PUBLIC KEY-----\n" +
            "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEKK1shlRCVNixhwWMpLSP3e0vPy/yHMZg\n" +
            "+DnZFAQF1v2KEnNqCJjIux8x1JQV8T5zbHysaTJHT1B7ylNI4UpHYA==\n" +
            "-----END PUBLIC KEY-----"
        
        
        static let senderEncryptionParameters = EncryptionParameters(privateKeyPem: senderPrivateKeyPem, publicKeyPem: senderPublicKeyPem)
        
        static let recipientPrivateKeyPem =
            "-----BEGIN PRIVATE KEY-----\n" +
            "MD4CAQAwEAYHKoZIzj0CAQYFK4EEAAoEJzAlAgEBBCCvwcD4YayXhwOfHRZmNksy\n" +
            "x+ZTDLDIxYIaTFo9Xvb/fA==\n" +
            "-----END PRIVATE KEY-----"
        
        
        static let recipientPublicKeyPem =
            "-----BEGIN PUBLIC KEY-----\n" +
            "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEylgwe/hPFvwbe5esXnjDjhxQgbTRO8P/\n" +
            "WTePbk3Mhqr9SH8xKkXc2E8JJCabbNjAuN4fnMDr6se6IgwSZ5r5Ow==\n" +
            "-----END PUBLIC KEY-----"
        
        static let recipientEncryptionParameters = EncryptionParameters(privateKeyPem: recipientPrivateKeyPem, publicKeyPem: recipientPublicKeyPem)
        
    }
    
    // MARK: Outputs
    
    struct Outputs {
        static let outputs = [Output(amount: 1000, script: "Script 1", currency: .bitcoin),
                              Output(amount: 2000, script: "Script 2", currency: .bitcoin)]
        
    }
    
    // MARK: Beneficiaries
    
    struct Beneficiaries {
        
        static let noPrimaryBeneficiaryParametersPkiX509SHA256 = BeneficiaryParameters(isPrimaryForTransaction: false,
                                                                                       pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                               TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let noPrimaryBeneficiaryParametersPkiNone = BeneficiaryParameters(isPrimaryForTransaction: false,
                                                                                 pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                         TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let primaryBeneficiaryParametersPkiX509SHA256BundledCertificate =  BeneficiaryParameters(isPrimaryForTransaction: true,
                                                                                                        pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256BundleCertificate,
                                                                                                                                TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let primaryBeneficiaryParametersPkiNone = BeneficiaryParameters(isPrimaryForTransaction: true,
                                                                               pkiDataParametersSets: [TestData.PkiData.pkiDataOwnerNone])
        
        static let primaryBeneficiaryParametersPkiX509SHA256 = BeneficiaryParameters(isPrimaryForTransaction: true,
                                                                                     pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256,
                                                                                                             TestData.PkiData.pkiDataTwoOwnerX509SHA256])
        
        static let primaryBeneficiaryParametersPkiX509SHA256InvalidCertificate = BeneficiaryParameters(isPrimaryForTransaction: true,
                                                                                                       pkiDataParametersSets: [TestData.PkiData.pkiDataOneOwnerX509SHA256InvalidCertificate,
                                                                                                                               TestData.PkiData.pkiDataTwoOwnerX509SHA256])
    }
    
    // MARK: Senders
    
    struct Senders {
        
        static let senderPkiNone = SenderParameters(pkiDataParameters: TestData.PkiData.pkiDataSenderNone)
        
        static let senderPkiX509SHA256 = SenderParameters(pkiDataParameters: TestData.PkiData.pkiDataSenderX509SHA256,
                                                          evCertificatePem: TestData.Certificates.evCert)
        
        static let senderPkiX509SHA256WithEncryption = SenderParameters(pkiDataParameters: TestData.PkiData.pkiDataSenderX509SHA256,
                                                                        evCertificatePem: nil,
                                                                        encryptionParameters: TestData.Encryptions.senderEncryptionParameters)
        
        static let senderPkiX509SHA256InvalidCertificate = SenderParameters(pkiDataParameters: TestData.PkiData.pkiDataOneOwnerX509SHA256InvalidCertificate)
        
    }
    
    // MARK: Recipients
    
    struct Recipients {
        
        static let recipientsParameters = RecipientParameters(vaspName: "VASP_1",
                                                              chainAddress: "1234567890ABCD")
        
        static let recipientsParametersWithEncryption = RecipientParameters(vaspName: "VASP_1",
                                                                            chainAddress: "1234567890ABCD",
                                                                            encryptionParameters: TestData.Encryptions.recipientEncryptionParameters)
    }
    
    // MARK: Attestations
    
    struct Attestations {
        
        static let invalidAttestation = Attestation.addressDistinctName
        
        static let requestedAttestations = [Attestation.legalPersonPrimaryName,
                                            Attestation.legalPersonSecondaryName,
                                            Attestation.addressDepartament,
                                            Attestation.addressPostbox]
    }
    
    //MARK: MessageInformation
    
    struct MessageInformationData {
        
        static let messageInformationCancel = MessageInformation(statusCode: .cancel, statusMessage: "Cancel for testing")
        
        static let messageInformationEncryption = MessageInformation(encryptMessage: true)
        
    }
}
