# Copyright (c) 2013-2016 The MKTcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS)
AM_CXXFLAGS = $(HARDENED_CXXFLAGS) $(ERROR_CXXFLAGS)
AM_CPPFLAGS = $(HARDENED_CPPFLAGS)
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

MKTCOIN_CONFIG_INCLUDES=-I$(builddir)/config
MKTCOIN_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

MKTCOIN_INCLUDES += -I$(srcdir)/secp256k1/include
MKTCOIN_INCLUDES += $(UNIVALUE_CFLAGS)

LIBMKTCOIN_SERVER=libmktcoin_server.a
LIBMKTCOIN_COMMON=libmktcoin_common.a
LIBMKTCOIN_CONSENSUS=libmktcoin_consensus.a
LIBMKTCOIN_CLI=libmktcoin_cli.a
LIBMKTCOIN_UTIL=libmktcoin_util.a
LIBMKTCOIN_CRYPTO=crypto/libmktcoin_crypto.a
LIBMKTCOINQT=qt/libmktcoinqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBMKTCOIN_ZMQ=libmktcoin_zmq.a
endif
if BUILD_MKTCOIN_LIBS
LIBMKTCOINCONSENSUS=libmktcoinconsensus.la
endif
if ENABLE_WALLET
LIBMKTCOIN_WALLET=libmktcoin_wallet.a
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBMKTCOIN_CRYPTO) \
  $(LIBMKTCOIN_UTIL) \
  $(LIBMKTCOIN_COMMON) \
  $(LIBMKTCOIN_CONSENSUS) \
  $(LIBMKTCOIN_SERVER) \
  $(LIBMKTCOIN_CLI) \
  $(LIBMKTCOIN_WALLET) \
  $(LIBMKTCOIN_ZMQ)

lib_LTLIBRARIES = $(LIBMKTCOINCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_MKTCOIND
  bin_PROGRAMS += mktcoind
endif

if BUILD_MKTCOIN_UTILS
  bin_PROGRAMS += mktcoin-cli mktcoin-tx
endif

.PHONY: FORCE check-symbols check-security
# mktcoin core #
MKTCOIN_CORE_H = \
  addrdb.h \
  addrman.h \
  base58.h \
  bloom.h \
  blockencodings.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  httprpc.h \
  httpserver.h \
  indirectmap.h \
  init.h \
  key.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  noui.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  pow.h \
  protocol.h \
  random.h \
  reverselock.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/register.h \
  scheduler.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  script/ismine.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util.h \
  utilmoneystr.h \
  utiltime.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h

obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libmktcoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between mktcoind and mktcoin-qt
libmktcoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libmktcoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_server_a_SOURCES = \
  addrman.cpp \
  addrdb.cpp \
  bloom.cpp \
  blockencodings.cpp \
  chain.cpp \
  checkpoints.cpp \
  httprpc.cpp \
  httpserver.cpp \
  init.cpp \
  dbwrapper.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/policy.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  script/ismine.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(MKTCOIN_CORE_H)

if ENABLE_ZMQ
libmktcoin_zmq_a_CPPFLAGS = $(MKTCOIN_INCLUDES) $(ZMQ_CFLAGS)
libmktcoin_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp
endif


# wallet: shared between mktcoind and mktcoin-qt, but only linked
# when wallet enabled
libmktcoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
libmktcoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_wallet_a_SOURCES = \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  policy/rbf.cpp \
  $(MKTCOIN_CORE_H)

# crypto primitives library
crypto_libmktcoin_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_CONFIG_INCLUDES) $(PIC_FLAGS)
crypto_libmktcoin_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) $(PIC_FLAGS)
crypto_libmktcoin_crypto_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/groestl.c \
  crypto/blake.c \
  crypto/blake2s-ref.c \
  crypto/bmw.c \
  crypto/cubehash.c \
  crypto/echo.c \
  crypto/jh.c \
  crypto/keccak.c \
  crypto/luffa.c \
  crypto/shavite.c \
  crypto/simd.c \
  crypto/skein.c \
  crypto/hamsi.c \
  crypto/whirlpool.c \
  crypto/shabal.c \
  crypto/fugue.c \
  crypto/sha2.c \
  crypto/haval.c \
  crypto/sph_sha2big.c \
  crypto/sph_types.h \
  crypto/sph_skein.h \
  crypto/sph_simd.h \
  crypto/sph_shavite.h \
  crypto/sph_shabal.h \
  crypto/sph_sha2.h \
  crypto/sph_luffa.h \
  crypto/sph_keccak.h \
  crypto/sph_jh.h \
  crypto/sph_haval.h \
  crypto/sph_hamsi.h \
  crypto/sph_groestl.h \
  crypto/sph_fugue.h \
  crypto/sph_echo.h \
  crypto/sph_cubehash.h \
  crypto/sph_bmw.h \
  crypto/sph_blake.h \
  crypto/sph_whirlpool.h \
  crypto/blake2.h \
  crypto/blake2-impl.h

# consensus: shared between all executables that validate any consensus rules.
libmktcoin_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
libmktcoin_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/mktcoinconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  utilstrencodings.cpp \
  utilstrencodings.h \
  version.h

# common: shared between mktcoind, and mktcoin-qt and non-server tools
libmktcoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
libmktcoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_common_a_SOURCES = \
  amount.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  keystore.cpp \
  netaddress.cpp \
  netbase.cpp \
  protocol.cpp \
  scheduler.cpp \
  script/sign.cpp \
  script/standard.cpp \
  warnings.cpp \
  $(MKTCOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libmktcoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
libmktcoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(MKTCOIN_CORE_H)

if GLIBC_BACK_COMPAT
libmktcoin_util_a_SOURCES += compat/glibc_compat.cpp
endif

# cli: shared between mktcoin-cli and mktcoin-qt
libmktcoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
libmktcoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libmktcoin_cli_a_SOURCES = \
  rpc/client.cpp \
  $(MKTCOIN_CORE_H)

nodist_libmktcoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# mktcoind binary #
mktcoind_SOURCES = mktcoind.cpp
mktcoind_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
mktcoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
mktcoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
mktcoind_SOURCES += mktcoind-res.rc
endif

mktcoind_LDADD = \
  $(LIBMKTCOIN_SERVER) \
  $(LIBMKTCOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBMKTCOIN_UTIL) \
  $(LIBMKTCOIN_WALLET) \
  $(LIBMKTCOIN_ZMQ) \
  $(LIBMKTCOIN_CONSENSUS) \
  $(LIBMKTCOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

mktcoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# mktcoin-cli binary #
mktcoin_cli_SOURCES = mktcoin-cli.cpp
mktcoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES) $(EVENT_CFLAGS)
mktcoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
mktcoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
mktcoin_cli_SOURCES += mktcoin-cli-res.rc
endif

mktcoin_cli_LDADD = \
  $(LIBMKTCOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBMKTCOIN_UTIL) \
  $(LIBMKTCOIN_CRYPTO)

mktcoin_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# mktcoin-tx binary #
mktcoin_tx_SOURCES = mktcoin-tx.cpp
mktcoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(MKTCOIN_INCLUDES)
mktcoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
mktcoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
mktcoin_tx_SOURCES += mktcoin-tx-res.rc
endif

mktcoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBMKTCOIN_COMMON) \
  $(LIBMKTCOIN_UTIL) \
  $(LIBMKTCOIN_CONSENSUS) \
  $(LIBMKTCOIN_CRYPTO) \
  $(LIBSECP256K1)

mktcoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# mktcoinconsensus library #
if BUILD_MKTCOIN_LIBS
include_HEADERS = script/mktcoinconsensus.h
libmktcoinconsensus_la_SOURCES = $(crypto_libmktcoin_crypto_a_SOURCES) $(libmktcoin_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libmktcoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libmktcoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libmktcoinconsensus_la_LIBADD = $(LIBSECP256K1)
libmktcoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_MKTCOIN_INTERNAL
libmktcoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/mktcoin-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/mktcoin-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/mktcoin-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/mktcoin-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) -c -o $@ $<

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
