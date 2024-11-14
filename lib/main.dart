import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.payment),
            onPressed: () {
              Navigator.pushNamed(context, '/payment');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // GIF Background
          Positioned.fill(
            child: Image.network(
              'https://media.giphy.com/media/IRBYun43yNSF8CSQkX/giphy.gif?cid=ecf05e47ifh2c9ps7k9nhtiiy9g39njh0mgnz1bg72hd66ng&ep=v1_gifs_search&rid=giphy.gif&ct=g', // Replace with your desired GIF URL
              fit: BoxFit.cover,
            ),
          ),
          // UI Content
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              child: const Text('Go to Payment'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Stack(
        children: [
          // GIF Background
          Positioned.fill(
            child: Image.network(
              'https://media.giphy.com/media/I90rL3aw7iwFNIu2qO/giphy.gif?cid=790b7611qp7tzjri7p31k6slg2v23jywn7gsdgy7q2793yvc&ep=v1_gifs_search&rid=giphy.gif&ct=g', // Replace with your desired GIF URL
              fit: BoxFit.cover,
            ),
          ),
          // UI Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    filled: true,
                    fillColor: Colors.white70, // Slightly transparent background
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _cardController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_amountController.text.isNotEmpty &&
                        _cardController.text.isNotEmpty) {
                      final amount = _amountController.text;
                      final cardNumber = _cardController.text;

                      Navigator.pushNamed(
                        context,
                        '/confirmation',
                        arguments: {
                          'amount': amount,
                          'card': cardNumber,
                        },
                      );
                    }
                  },
                  child: const Text('Proceed to Confirmation'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final amount = arguments?['amount'] ?? 'N/A';
    final card = arguments?['card'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Stack(
        children: [
          // Full-Screen GIF Background
          Positioned.fill(
            child: Image.network(
              'https://media.giphy.com/media/orfUFtOqPZSHfzYfpE/giphy.gif?cid=790b7611bfi1ovb5zjulrrygev229bc8aqzsofifszouvyua&ep=v1_gifs_search&rid=giphy.gif&ct=g', // Confirmation Screen Background GIF URL
              fit: BoxFit.cover,
            ),
          ),
          // UI Content inside a scrollable area
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjust to allow content to fit
                children: [
                  Text(
                    'Amount: \$${amount}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Card: **** **** **** ${card.substring(card.length - 4)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Here you would trigger the payment process.
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Payment Successful'),
                          content: const Text('Your payment has been processed.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Confirm Payment'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
