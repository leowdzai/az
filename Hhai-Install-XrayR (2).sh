clear
echo "----- 3107 ~ HHai -----"
echo "   1. Cài đặt"
echo "   2. update config"
echo "   3. thêm node"
read -p "  Vui lòng chọn một số và nhấn Enter (Enter theo mặc định Cài đặt):  " num
[ -z "${num}" ] && num="1"



install_1(){
  clear

  pre_install
}
pre_install(){
 clear
		read -p "Nhập số node cần cài và nhấn Enter (tối đa 2 node): " n
	 [ -z "${n}" ] && n="1"
    if [ "$n" -ge 2 ] ; then 
    n="2"
    fi
    a=0
  while [ $a -lt $n ]
do

 echo "--------Thuc Giac---------"
 echo "--------- HANG A HAI ---------"
 echo "-------------------------------"
 echo "VUI LÒNG CHỌN GIAO THỨC CẦN CÀI - V2board -"
 echo "-------------------------------"

echo -e "Chọn Giao Thức NODE Số $((a+1))"


 echo -e "[1] Vmess"
 echo -e "[2] Vless"
  echo -e "[3] trojan"
  read -p "Chọn Kiểu Giao Thức (Mặc Định Là Vmess):" NodeType
  if [ "$NodeType" == "1" ]; then
    NodeType="V2ray"
    NodeName="Vmess"
    EnableVless="false"
  elif [ "$NodeType" == "2" ]; then
    NodeType="V2ray"
    NodeName="Vless"
    EnableVless="true"
  elif [ "$NodeType" == "3" ]; then
    NodeType="Trojan"
    NodeName="Trojan"
    EnableVless="false"
  else
    NodeType="V2ray"
    EnableVless="false"
  fi
  echo "Bạn Đã Chọn Giao Thức $NodeName"
  echo "--------------------------------"


  #node id
    read -p " Nhập ID Nút (Node_ID):" node_id
  [ -z "${node_id}" ] && node_id=0
  echo "-------------------------------"
  echo -e "Node_ID: ${node_id}"
  echo "-------------------------------"



  

  

 config
  a=$((a+1))
done
}


#clone node
clone_node(){
  clear
#node type
 echo "---------- Xray-ServerVIP ----------"
 echo "--------- Hhai Siu Dz ---------"
 echo "-------------------------------"
 echo "VUI LÒNG CHỌN GIAO THỨC CẦN CÀI - V2board -"
 echo "-------------------------------"
 echo -e "[1] Vmess"
 echo -e "[2] Vless"
  echo -e "[3] trojan"
  read -p "Chọn Kiểu Giao Thức (Mặc Định Là Vmess):" NodeType
  if [ "$NodeType" == "1" ]; then
    NodeType="V2ray"
    EnableVless="false"
  elif [ "$NodeType" == "2" ]; then
    NodeType="V2ray"
    EnableVless="true"
  elif [ "$NodeType" == "3" ]; then
    NodeType="Trojan"
    EnableVless="false"
  else
    NodeType="V2ray"
    EnableVless="false"
  fi
  echo "Bạn Đã Chọn Giao Thức $NodeType"
  echo "--------------------------------"


  #node id
    read -p " Nhập ID Nút (Node_ID:" node_id
  [ -z "${node_id}" ] && node_id=0
  echo "-------------------------------"
  echo -e "Node_ID: ${node_id}"
  echo "-------------------------------"
  
  

  
#   #IP vps
#  read -p "Nhập domain :" CertDomain
#   [ -z "${CertDomain}" ] && CertDomain="0"
#  echo "-------------------------------"
#   echo "ip : ${CertDomain}"
#  echo "-------------------------------"


 config
  
 
}







config(){
cd /etc/Xray-Server
cat >>config.yml<<EOF
  -
    PanelType: "ZicBoard" # Panel type: SSpanel, V2board, PMpanel, , Proxypanel
    ApiConfig:
      ApiHost: "https://sieu4g.com"
      ApiKey: "qdung_qdung_qdung_qdung"
      NodeID: $node_id
      NodeType: $NodeType # Node type: V2ray, Shadowsocks, Trojan, Shadowsocks-Plugin
      Timeout: 30 # Timeout for the api request
      EnableVless: $EnableVless # Enable Vless for V2ray Type
      EnableXTLS: false # Enable XTLS for V2ray and Trojan
      SpeedLimit: 0 # Mbps, Local settings will replace remote settings, 0 means disable
      DeviceLimit: 0 # Local settings will replace remote settings, 0 means disable
      RuleListPath: # /etc/Xray-Server/rulelist Path to local rulelist file
    ControllerConfig:
      ListenIP: 0.0.0.0 # IP address you want to listen
      SendIP: 0.0.0.0 # IP address you want to send pacakage
      UpdatePeriodic: 60 # Time to update the nodeinfo, how many sec.
      EnableDNS: false # Use custom DNS config, Please ensure that you set the dns.json well
      DNSType: AsIs # AsIs, UseIP, UseIPv4, UseIPv6, DNS strategy
      DisableSniffing: True # Disable domain sniffing
      EnableProxyProtocol: false # Only works for WebSocket and TCP
      EnableFallback: false # Only support for Trojan and Vless
      FallBackConfigs:  # Support multiple fallbacks
        -
          SNI: # TLS SNI(Server Name Indication), Empty for any
          Alpn: # Alpn, Empty for any
          Path: # HTTP PATH, Empty for any
          Dest: 80 # Required, Destination of fallback, check https://xtls.github.io/config/features/fallback.html for details.
          ProxyProtocolVer: 0 # Send PROXY protocol version, 0 for dsable
      CertConfig:
        CertMode: file # Option about how to get certificate: none, file, http, dns. Choose "none" will forcedly disable the tls config.
        CertDomain: "punpn.net" # Domain to cert
        CertFile: /Xray-ServerVIP/cer.cer # Provided if the CertMode is file
        KeyFile: /Xray-ServerVIP/key.key
        Provider: alidns # DNS cert provider, Get the full support list here: https://go-acme.github.io/lego/dns/
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          ALICLOUD_ACCESS_KEY: aaa
          ALICLOUD_SECRET_KEY: bbb
EOF

#   sed -i "s|ApiHost: \"https://domain.com\"|ApiHost: \"${api_host}\"|" ./config.yml
 # sed -i "s|ApiKey:.*|ApiKey: \"${ApiKey}\"|" 
#   sed -i "s|NodeID: 41|NodeID: ${node_id}|" ./config.yml
#   sed -i "s|DeviceLimit: 0|DeviceLimit: ${DeviceLimit}|" ./config.yml
#   sed -i "s|SpeedLimit: 0|SpeedLimit: ${SpeedLimit}|" ./config.yml
#   sed -i "s|CertDomain:\"node1.test.com\"|CertDomain: \"${CertDomain}\"|" ./config.yml
 }

case "${num}" in
1) bash <(curl -Ls https://raw.githubusercontent.com/AikoPanel/Xray-Server/master/install.sh)             
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/Xray-Server/fastvnteam.crt -keyout /etc/Xray-Server/fastvnteam.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
cd /etc/Xray-Server
  cat >config.yml <<EOF
Log:
  Level: none # Log level: none, error, warning, info, debug 
  AccessPath: # /etc/Xray-Server/access.Log
  ErrorPath: # /etc/Xray-Server/error.log
DnsConfigPath: # /etc/Xray-Server/dns.json # Path to dns config, check https://xtls.github.io/config/dns.html for help
RouteConfigPath: # /etc/Xray-Server/route.json # Path to route config, check https://xtls.github.io/config/routing.html for help
InboundConfigPath: # /etc/Xray-Server/custom_inbound.json # Path to custom inbound config, check https://xtls.github.io/config/inbound.html for help
OutboundConfigPath: # /etc/Xray-Server/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/outbound.html for help
ConnetionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB 
Nodes:
EOF
install_1

cd /root
Xray-Server start
 ;;
 2) cd /etc/Xray-Server
cat >config.yml <<EOF
Log:
  Level: none # Log level: none, error, warning, info, debug 
  AccessPath: # /etc/Xray-Server/access.Log
  ErrorPath: # /etc/Xray-Server/error.log
DnsConfigPath: # /etc/Xray-Server/dns.json # Path to dns config, check https://xtls.github.io/config/dns.html for help
RouteConfigPath: # /etc/Xray-Server/route.json # Path to route config, check https://xtls.github.io/config/routing.html for help
InboundConfigPath: # /etc/Xray-Server/custom_inbound.json # Path to custom inbound config, check https://xtls.github.io/config/inbound.html for help
OutboundConfigPath: # /etc/Xray-Server/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/outbound.html for help
ConnetionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB 
Nodes:
EOF

install_1
cd /root
Xray-Server restart
 ;;
 3) cd /etc/Xray-Server
 clone_node
 cd /root
  Xray-Server restart
;;
esac