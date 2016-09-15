INTERVAL="1"  # update interval in seconds
 
if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        echo shows packets-per-second
        exit
fi
 
IF=$1
 
while true
do
        R1=`cat /sys/class/net/$1/statistics/rx_packets`
	D1=`cat /sys/class/net/$1/statistics/rx_dropped`
        T1=`cat /sys/class/net/$1/statistics/tx_packets`
	X1=`cat /sys/class/net/$1/statistics/tx_dropped`
	
        sleep $INTERVAL
        R2=`cat /sys/class/net/$1/statistics/rx_packets`
	D2=`cat /sys/class/net/$1/statistics/rx_dropped`
        T2=`cat /sys/class/net/$1/statistics/tx_packets`
        X2=`cat /sys/class/net/$1/statistics/tx_dropped`

        TXPPS=`expr $T2 - $T1`
        RXPPS=`expr $R2 - $R1`
	DXPPS=`expr $D2 - $D1`
	XXPPS=`expr $X2 - $X1`

        echo "TX $1: $TXPPS pkts/s $XXPPS dropped/s  RX $1: $RXPPS pkts/s $DXPPS dropped/s"
done

