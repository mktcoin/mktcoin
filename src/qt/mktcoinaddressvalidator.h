// Copyright (c) 2011-2014 The MKTcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef MKTCOIN_QT_MKTCOINADDRESSVALIDATOR_H
#define MKTCOIN_QT_MKTCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class MKTcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MKTcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** MKTcoin address widget validator, checks for a valid mktcoin address.
 */
class MKTcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit MKTcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // MKTCOIN_QT_MKTCOINADDRESSVALIDATOR_H
