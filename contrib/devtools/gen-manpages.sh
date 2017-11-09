#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

MKTCOIND=${MKTCOIND:-$SRCDIR/mktcoind}
MKTCOINCLI=${MKTCOINCLI:-$SRCDIR/mktcoin-cli}
MKTCOINTX=${MKTCOINTX:-$SRCDIR/mktcoin-tx}
MKTCOINQT=${MKTCOINQT:-$SRCDIR/qt/mktcoin-qt}

[ ! -x $MKTCOIND ] && echo "$MKTCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
MLMVER=($($MKTCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for mktcoind if --version-string is not set,
# but has different outcomes for mktcoin-qt and mktcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$MKTCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $MKTCOIND $MKTCOINCLI $MKTCOINTX $MKTCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MLMVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MLMVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
