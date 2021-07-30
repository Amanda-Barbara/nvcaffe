#!/usr/bin/env sh
# This script converts the cifar data into leveldb format.

EXAMPLE=examples/cifar10
DATA=data/cifar10
DBTYPE=lmdb

echo "Creating $DBTYPE..."

rm -rf $EXAMPLE/cifar10_train_$DBTYPE $EXAMPLE/cifar10_test_$DBTYPE

./cmake-build-debug/examples/cifar10/convert_cifar_data-d.bin $DATA $EXAMPLE $DBTYPE

echo "Computing image mean..."

./cmake-build-debug/tools/compute_image_mean-d -backend=$DBTYPE \
  $EXAMPLE/cifar10_train_$DBTYPE $EXAMPLE/mean.binaryproto

echo "Done."
