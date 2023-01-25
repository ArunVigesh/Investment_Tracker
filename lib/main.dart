import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:investment_tracker/buy_screen.dart';
import 'package:investment_tracker/sell_screen.dart';
import 'package:investment_tracker/track_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'invest_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'invest_database.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE invest (id INTEGER PRIMARY KEY AUTOINCREMENT, ingestedDate TEXT, investmentGoal TEXT, stockName TEXT,buyDate TEXT ,buyPrice DOUBLE,quantity DOUBLE ,sellDate TEXT,sellPrice DOUBLE);');
    },
    version: 2,
  );

  Future<void> insertInvest(Invest invest) async {
    final db = await database;

    await db.insert(
      'invest',
      invest.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateInvest(Invest invest) async {
    final db = await database;
    await db.update(
      'invest',
      invest.toMap(),
      where: 'id = ?',
      whereArgs: [invest.id],
    );
  }

  Future<List<Invest>> listInvest() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Invest');

    return List.generate(maps.length, (i) {
      return Invest(
          id: maps[i]['id'],
          ingestedDate: maps[i]['ingestedDate'],
          investmentGoal: maps[i]['investmentGoal'],
          stockName: maps[i]['stockName'],
          buyDate: maps[i]['buyDate'],
          buyPrice: maps[i]['buyPrice'],
          quantity: maps[i]['quantity'],
          sellDate: maps[i]['sellDate'],
          sellPrice: maps[i]['sellPrice']);
    });
  }

  var investData = Invest(
      id: 0,
      ingestedDate: DateTime.now().toString(),
      investmentGoal: "LongTerm",
      stockName: "ITC",
      buyDate: "2023-01-01",
      buyPrice: 1000.0,
      quantity: 1,
      sellDate: "",
      sellPrice: 0);

  await insertInvest(investData);

  print(await listInvest());

  investData = Invest(
      id: 3,
      ingestedDate: investData.ingestedDate,
      investmentGoal: investData.investmentGoal,
      stockName: investData.stockName,
      buyDate: investData.buyDate,
      buyPrice: investData.buyPrice,
      quantity: investData.quantity-1,
      sellDate: "2023-01-20",
      sellPrice: 4000
  );
  await updateInvest(investData);

  print(await listInvest());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Investment Tracker'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Buy'),
                Tab(text: 'Sell'),
                Tab(text: 'Track'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [Buy(), Sell(), Track()],
          )),
    );
  }
}
