#!/bin/bash

HOSTNAME=$1
OUTPUTDIR=$2
COUNTRY=$3
STATE=$4
CITY=$5
KEYSIZE=$6
VALIDTIME=$7

openssl req -new -newkey rsa:$KEYSIZE -days $VALIDTIME -nodes -x509 \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=Dis/CN=$HOSTNAME" \
    -keyout $OUTPUTDIR/$HOSTNAME.key -out $OUTPUTDIR/$HOSTNAME.cert > /dev/null

RET=$?

if [ $RET -ne 0 ];then
 	echo 'failed to generate ssl cert'
 	exit 126
else
	echo 'Generated Keys'
fi

openssl dhparam -out /$OUTPUTDIR/dhparam.pem $KEYSIZE > /dev/null
RET=$?

if [ $RET -ne 0 ];then
 	echo 'failed to generate Diffie-Hellman group'
 	exit 126
else
	echo 'successfully generated keys'
fi

exit 0
