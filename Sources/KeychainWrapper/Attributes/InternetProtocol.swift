//
//  InternetProtocol.swift
//  
//
//  Created by Danny Gilbert on 7/26/22.
//

import Foundation

public enum InternetProtocol: RawRepresentable {
    case ftp,
         ftpAccount,
         http,
         irc,
         nntp,
         pop3,
         smtp,
         socks,
         imap,
         ldap,
         appleTalk,
         afp,
         telnet,
         ssh,
         ftps,
         https,
         httpProxy,
         httpsProxy,
         ftpProxy,
         smb,
         rtsp,
         rtspProxy,
         daap,
         eppc,
         ipp,
         nntps,
         ldaps,
         telnetS,
         imaps,
         ircs,
         pop3S
    
    public init?(rawValue: String) {
        switch rawValue {
        case kSecAttrProtocolFTP.string:        self = .ftp
        case kSecAttrProtocolFTPAccount.string: self = .ftpAccount
        case kSecAttrProtocolHTTP.string:       self = .http
        case kSecAttrProtocolIRC.string:        self = .irc
        case kSecAttrProtocolNNTP.string:       self = .nntp
        case kSecAttrProtocolPOP3.string:       self = .pop3
        case kSecAttrProtocolSMTP.string:       self = .smtp
        case kSecAttrProtocolSOCKS.string:      self = .socks
        case kSecAttrProtocolIMAP.string:       self = .imap
        case kSecAttrProtocolLDAP.string:       self = .ldap
        case kSecAttrProtocolAppleTalk.string:  self = .appleTalk
        case kSecAttrProtocolAFP.string:        self = .afp
        case kSecAttrProtocolTelnet.string:     self = .telnet
        case kSecAttrProtocolSSH.string:        self = .ssh
        case kSecAttrProtocolFTPS.string:       self = .ftps
        case kSecAttrProtocolHTTPS.string:      self = .https
        case kSecAttrProtocolHTTPProxy.string:  self = .httpProxy
        case kSecAttrProtocolHTTPSProxy.string: self = .httpsProxy
        case kSecAttrProtocolFTPProxy.string:   self = .ftpProxy
        case kSecAttrProtocolSMB.string:        self = .smb
        case kSecAttrProtocolRTSP.string:       self = .rtsp
        case kSecAttrProtocolRTSPProxy.string:  self = .rtspProxy
        case kSecAttrProtocolDAAP.string:       self = .daap
        case kSecAttrProtocolEPPC.string:       self = .eppc
        case kSecAttrProtocolIPP.string:        self = .ipp
        case kSecAttrProtocolNNTPS.string:      self = .nntps
        case kSecAttrProtocolLDAPS.string:      self = .ldaps
        case kSecAttrProtocolTelnetS.string:    self = .telnetS
        case kSecAttrProtocolIMAPS.string:      self = .imaps
        case kSecAttrProtocolIRCS.string:       self = .ircs
        case kSecAttrProtocolPOP3S.string:      self = .pop3S
        
        default:                return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .ftp:          return kSecAttrProtocolFTP.string
        case .ftpAccount:   return kSecAttrProtocolFTPAccount.string
        case .http:         return kSecAttrProtocolHTTP.string
        case .irc:          return kSecAttrProtocolIRC.string
        case .nntp:         return kSecAttrProtocolNNTP.string
        case .pop3:         return kSecAttrProtocolPOP3.string
        case .smtp:         return kSecAttrProtocolSMTP.string
        case .socks:        return kSecAttrProtocolSOCKS.string
        case .imap:         return kSecAttrProtocolIMAP.string
        case .ldap:         return kSecAttrProtocolLDAP.string
        case .appleTalk:    return kSecAttrProtocolAppleTalk.string
        case .afp:          return kSecAttrProtocolAFP.string
        case .telnet:       return kSecAttrProtocolTelnet.string
        case .ssh:          return kSecAttrProtocolSSH.string
        case .ftps:         return kSecAttrProtocolFTPS.string
        case .https:        return kSecAttrProtocolHTTPS.string
        case .httpProxy:    return kSecAttrProtocolHTTPProxy.string
        case .httpsProxy:   return kSecAttrProtocolHTTPSProxy.string
        case .ftpProxy:     return kSecAttrProtocolFTPProxy.string
        case .smb:          return kSecAttrProtocolSMB.string
        case .rtsp:         return kSecAttrProtocolRTSP.string
        case .rtspProxy:    return kSecAttrProtocolRTSPProxy.string
        case .daap:         return kSecAttrProtocolDAAP.string
        case .eppc:         return kSecAttrProtocolEPPC.string
        case .ipp:          return kSecAttrProtocolIPP.string
        case .nntps:        return kSecAttrProtocolNNTPS.string
        case .ldaps:        return kSecAttrProtocolLDAPS.string
        case .telnetS:      return kSecAttrProtocolTelnetS.string
        case .imaps:        return kSecAttrProtocolIMAPS.string
        case .ircs:         return kSecAttrProtocolIRCS.string
        case .pop3S:        return kSecAttrProtocolPOP3S.string
        }
    }
}
