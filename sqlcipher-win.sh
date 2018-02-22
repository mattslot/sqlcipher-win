#!/bin/sh

# Configuration script to create sqlcipher amalgamation build for Windows on UNIX or Mac
# See LICENSE file for copyright details.
#
# CONFIGURATION:
#    1. Clone or checkout sqlcipher-win on UNIX
#    2. Run sqlcipher-win.sh from command line.
#    3. sqlite3.c and related headers will be generated and replaced.
#    4. Commit the updated sources to sqlcipher-win repository.
#
# BUILDING:
#    1. Clone or checkout sqlcipher-win on Windows
#    2. Include the sqlite3.c source and related headers in your project.
#    3. Build the project.


rm -fr sqlcipher
git clone https://github.com/sqlcipher/sqlcipher.git sqlcipher

pushd sqlcipher

./configure --with-crypto-lib=none --disable-tcl CFLAGS="-DSQLITE_HAS_CODEC -DSQLCIPHER_CRYPTO_OPENSSL"
make clean
make sqlite3.c

TAG=$( git describe --abbrev=0 )

popd

cp -f sqlcipher/sqlite3.c           .
cp -f sqlcipher/sqlite3.h           .
cp -f sqlcipher/sqlite3ext.h        .
cp -f sqlcipher/sqlite3session.h    .

git tag -a $TAG -m "Tagged $TAG"
