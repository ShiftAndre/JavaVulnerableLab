#!/bin/sh
set -e
 
# Provide your API public token
PUBLIC_TOKEN=$SHIFTLEFT_API_TOKEN

# Provide your organization ID public token
ORGID=$SHIFTLEFT_ORG_ID
echo $ORGID: $ORGID

# Provide your application ID
APPID=$1
echo APPID: $APPID

# Assume this is the "tag_key=tag_value" use case "branch=branch_name"
TAG_KEY='branch'
TAG_VALUE=$2  

SL_PROTO='https'
SL_HOST='www.shiftleft.io'

if [ -z "$TAG_VALUE" ]
then
   SL_URL="$SL_PROTO://$SL_HOST/api/v3/public/org/$ORGID/app/$APPID/build"
else
   SL_URL="$SL_PROTO://$SL_HOST/api/v3/public/org/$ORGID/app/$APPID/tag/$TAG_KEY/$TAG_VALUE/build"
fi 

echo ##############
echo $SL_URL
echo ##############

BEARER='Authorization: Bearer '$PUBLIC_TOKEN
BUILD_RESULT=$(curl --fail --show-error -X GET \
   $SL_URL \
  -H 'Accept: */*' \
  -H "$BEARER" \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H "Host: $SL_HOST" \
  -H 'accept-encoding: text/plain, deflate' \
  -H 'cache-control: no-cache' \
  -H 'cookie: Cookie_3=value' \
  -s -b Cookie_3=value)

echo $BUILD_RESULT

SUCCESS=$(echo $BUILD_RESULT | grep "success")
if [ -z "$SUCCESS" ]; then
    exit 1;
fi
exit 0
