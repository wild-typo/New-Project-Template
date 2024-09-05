#!/bin/sh

SUCCESS=0
FAIL=1

ME=$(basename "$0")
if [ $# != 2 ]; then
    echo "Usage: $ME <project> <directory>"
    exit $FAIL
fi

PROJ_NAME=$1
if [ -z $PROJ_NAME ]; then
    echo "project could not be $PROJ_NAME"
    exit $FAIL
fi

OUT_DIR=$2
if [ ! -d $OUT_DIR ]; then
    echo "Directory $OUT_DIR not found"
    exit $FAIL
fi

PROJ_DIR=$OUT_DIR/$PROJ_NAME
if [ -d $PROJ_DIR ]; then
    echo "Directory $PROJ_DIR already exists"
    exit $FAIL
fi

BASE_DIR=$(dirname "$0")
C_TEMPLATE_DIR=$BASE_DIR/c_tpl

cp -r $C_TEMPLATE_DIR $PROJ_DIR
if [ $? -ne 0 ]; then
    echo "Failed to copy $C_TEMPLATE_DIR to $1"
    exit $FAIL
fi

C_TEMPLATE_FILENAME=$PROJ_DIR/src/proj.c.tpl
MK_TEMPLATE_FILENAME=$PROJ_DIR/Makefile.tpl
C_FILENAME=$PROJ_DIR/src/$PROJ_NAME.c
MK_FILENAME=$PROJ_DIR/Makefile

sed "s/%proj%/$1/g" <$MK_TEMPLATE_FILENAME >$MK_FILENAME
if [ $? -ne 0 ]; then
    echo "Failed to replace text for $MK_TEMPLATE_FILENAME"
    exit $FAIL
fi

rm $MK_TEMPLATE_FILENAME
if [ $? -ne 0 ]; then
    echo "Failed to remove $MK_TEMPLATE_FILENAME"
    exit $FAIL
fi

mv $C_TEMPLATE_FILENAME $C_FILENAME
if [ $? -ne 0 ]; then
    echo "Failed to move $C_TEMPLATE_FILENAME to $1"
    exit $FAIL
fi

echo "Created project: $PROJ_NAME"

exit 0
