import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class RSAHelper {
  AsymmetricKeyPair<PublicKey, PrivateKey> generateRSAKeyPair(
      SecureRandom secureRandom,
      {int bitLength = 2048}) {
    // Generate an RSA key pair
    var rsapars =
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64);
    var params = ParametersWithRandom(rsapars, secureRandom);
    var keyGenerator = RSAKeyGenerator();
    keyGenerator.init(params);
    return keyGenerator.generateKeyPair();
  }

  SecureRandom exampleSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  Uint8List rsaEncrypt(RSAPublicKey publicKey, Uint8List dataToEncrypt) {
    var encryptor = OAEPEncoding(RSAEngine())
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey)); // true=encrypt
    return _processInBlocks(encryptor, dataToEncrypt);
  }

  Uint8List rsaDecrypt(RSAPrivateKey privateKey, Uint8List cipherText) {
    var decryptor = OAEPEncoding(RSAEngine())
      ..init(false,
          PrivateKeyParameter<RSAPrivateKey>(privateKey)); // false=decrypt
    return _processInBlocks(decryptor, cipherText);
  }

  Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
    var output = Uint8List(0);
    var inputOffset = 0;
    while (inputOffset < input.length) {
      var chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
          ? engine.inputBlockSize
          : input.length - inputOffset;
      var chunk = input.sublist(inputOffset, inputOffset + chunkSize);
      output = Uint8List.fromList(output + engine.process(chunk));
      inputOffset += chunkSize;
    }
    return output;
  }

  String rsaEncryptToBase64(RSAPublicKey publicKey, Uint8List dataToEncrypt) {
    var encryptedData = rsaEncrypt(publicKey, dataToEncrypt);
    return base64Encode(encryptedData);
  }

  Uint8List rsaDecryptFromBase64(
      RSAPrivateKey privateKey, String base64CipherText) {
    var cipherText = base64Decode(base64CipherText);
    return rsaDecrypt(privateKey, cipherText);
  }
}
