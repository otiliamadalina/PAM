import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Convertor moneda',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => //cream starea paginii
      _CurrencyConverterPageState(); //pt gestionarea starii
}

class _CurrencyConverterPageState
    extends State<CurrencyConverterPage> {

  final TextEditingController amountController =
      TextEditingController();

  final List<String> currencies = [
    'EUR',
    'USD',
    'MDL',
    'RON',
    'GBP',
  ];

  String fromCurrency = 'EUR';
  String toCurrency = 'MDL';

  String result = '';

  final Map<String, double> rates = {
    'EUR': 1.0,
    'USD': 1.17,
    'MDL': 19.50,
    'RON': 5.09,
    'GBP': 0.87,
  };

  void convertCurrency() {
    double? amount = double.tryParse(
      amountController.text.replaceAll(',', '.'),
    );

    if (amount == null) {
      setState(() { //ii spunem ca starea s a schimbat
        result = 'Introdu o suma valida';
      });
      return;
    }

    double amountInEuro =
        amount / rates[fromCurrency]!;

    double convertedAmount =
        amountInEuro * rates[toCurrency]!;

    setState(() { //actual. interfata dupa calcul
      result =
          '${amount.toStringAsFixed(2)} $fromCurrency = '
          '${convertedAmount.toStringAsFixed(2)} $toCurrency';
    });
  }

  void swapCurrencies() {
    setState(() {
      String temporary = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temporary;
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Convertor moneda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const Icon(
                Icons.currency_exchange_rounded,
                size: 60,
                color: Colors.indigo,
              ),

              const SizedBox(height: 10),

              const Text(
                'Converteste-ti banii',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Rapid si simplu',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(22),

                  child: Column(
                    children: [

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Suma',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: amountController,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          prefixIcon: const Icon(
                            Icons.payments_outlined,
                          ),
                          filled: true,
                          fillColor:
                              const Color(0xFFF5F7FB),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.indigo,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Din',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: fromCurrency,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.account_balance_wallet_outlined,
                          ),
                          filled: true,
                          fillColor:
                              const Color(0xFFF5F7FB),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: currencies.map(
                          (currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            );
                          },
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            fromCurrency = newValue!;
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      IconButton( //butonul pt schimbare moneda
                        onPressed: swapCurrencies,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Colors.indigo.shade50,
                          foregroundColor: Colors.indigo,
                        ),
                        icon: const Icon(
                          Icons.swap_vert_rounded,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'In',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: toCurrency,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.currency_exchange_rounded,
                          ),
                          filled: true,
                          fillColor:
                              const Color(0xFFF5F7FB),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: currencies.map(
                          (currency) {
                            return DropdownMenuItem<String>(
                              value: currency,
                              child: Text(currency),
                            );
                          },
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            toCurrency = newValue!;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

                      SizedBox( // butonul pt conversie
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: convertCurrency,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Converteste',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (result.isNotEmpty)
                Card(
                  elevation: 0,
                  color: Colors.indigo.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 35,
                          color: Colors.indigo,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Rezultat',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          result,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}