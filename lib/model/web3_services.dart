import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

const sepolia = "https://sepolia.infura.io/v3/8cb4b2a04007438199f1c4ab72fc6324";
var httpClient = Client();
final web3Client = Web3Client(sepolia, httpClient);

class Web3Services {
  Wallet createNewWallet(String password) {
    var rng = Random.secure();
    return Wallet.createNew(EthPrivateKey.createRandom(rng), password, rng);
  }

  Wallet loadWalletFromJSON(File file, password) {
    String content = file.readAsStringSync();
    return Wallet.fromJson(content, password);
  }

  Wallet createWalletFromPK(String hex, password) {
    var rng = Random.secure();
    EthPrivateKey credentials = EthPrivateKey.fromHex(hex);
    return Wallet.createNew(credentials, password, rng);
  }

  Future<double> getBalance(Credentials creds) async {
    EtherAmount balance = await web3Client.getBalance(creds.address);
    return balance.getValueInUnit(EtherUnit.ether);
  }

  Future<String> sendTransaction(
      Credentials sender, String receiver, String amount) async {
    return await web3Client.sendTransaction(
      sender,
      Transaction(
        to: EthereumAddress.fromHex(receiver),
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
      ),
    );
  }
}
