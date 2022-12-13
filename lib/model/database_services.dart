import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'coin_data.dart';

class DBService {
  Future<Database> openDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(join(await getDatabasesPath(), 'xwallet.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE favorite_assets (id INTEGER , slug TEXT, name TEXT, image TEXT)');
      await db.execute(
          'CREATE TABLE wallets (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, filename TEXT, walletName TEXT)');
    }, version: 1);

    return database;
  }

  Future<bool> addFavoriteAsset(Map<String, dynamic> coinData) async {
    final db = await openDb();
    return await db.insert("favorite_assets", coinData) > 0;
  }

  Future<bool> addWallet(Map<String, dynamic> wallet) async {
    final db = await openDb();
    return await db.insert("wallets", wallet) > 0;
  }

  Future<bool> removeFavoriteAsset(int id) async {
    final db = await openDb();
    return await db
            .delete("favorite_assets", where: "id = ?", whereArgs: [id]) >
        0;
  }

  Future<List<CoinData>> getFavoriteAssets() async {
    final db = await openDb();
    List assets = await db.query("favorite_assets");
    return List.generate(assets.length, (index) {
      return CoinData(
          id: assets[index]['id'],
          slug: assets[index]['slug'],
          name: assets[index]['name'],
          image: assets[index]['image']);
    });
  }

  Future<List<Map<String, dynamic>>> getWallets({String name = ""}) async {
    final db = await openDb();
    List<Map<String, dynamic>> wallets = [];
    if (name.isEmpty) {
      wallets = await db.query("wallets");
    } else {
      wallets = await db.query("wallets", where: "walletName = ?", whereArgs: [name]);
    }
    return wallets;
  }
}
