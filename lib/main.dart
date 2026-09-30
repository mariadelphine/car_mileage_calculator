import 'package:flutter/material.dart';

void main() {
  runApp(const CarMileageApp());
}

class CarMileageApp extends StatelessWidget {
  const CarMileageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Mileage Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CarMileageCalculator(),
    );
  }
}

class CarMileageCalculator extends StatefulWidget {
  const CarMileageCalculator({super.key});

  @override
  State<CarMileageCalculator> createState() =>
      _CarMileageCalculatorState();
}

class _CarMileageCalculatorState extends State<CarMileageCalculator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController distanceController =
      TextEditingController();

  final TextEditingController fuelController =
      TextEditingController();

  double? mileage;

  void calculateMileage() {
    if (_formKey.currentState!.validate()) {
      double distance = double.parse(distanceController.text);
      double fuel = double.parse(fuelController.text);

      setState(() {
        mileage = distance / fuel;
      });
    }
  }

  void clearForm() {
    setState(() {
      distanceController.clear();
      fuelController.clear();
      mileage = null;
    });
  }

  @override
  void dispose() {
    distanceController.dispose();
    fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Mileage Calculator'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Icon(
                Icons.directions_car,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 15),

              const Text(
                'Car Mileage Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Enter the distance travelled and fuel consumed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // Distance Input
              TextFormField(
                controller: distanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Distance Travelled',
                  hintText: 'Enter distance in kilometres',
                  prefixIcon: Icon(Icons.route),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the distance';
                  }

                  double? distance = double.tryParse(value);

                  if (distance == null) {
                    return 'Please enter a valid number';
                  }

                  if (distance <= 0) {
                    return 'Distance must be greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Fuel Input
              TextFormField(
                controller: fuelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Fuel Consumed',
                  hintText: 'Enter fuel in litres',
                  prefixIcon: Icon(Icons.local_gas_station),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fuel consumed';
                  }

                  double? fuel = double.tryParse(value);

                  if (fuel == null) {
                    return 'Please enter a valid number';
                  }

                  if (fuel <= 0) {
                    return 'Fuel must be greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Calculate Button
              ElevatedButton.icon(
                onPressed: calculateMileage,
                icon: const Icon(Icons.calculate),
                label: const Text(
                  'Calculate Mileage',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Clear Button
              OutlinedButton(
                onPressed: clearForm,
                child: const Text('Clear'),
              ),

              const SizedBox(height: 30),

              // Result
              if (mileage != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),

                  child: Column(
                    children: [
                      const Icon(
                        Icons.speed,
                        size: 50,
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Your Car Mileage',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '${mileage!.toStringAsFixed(2)} km/L',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}