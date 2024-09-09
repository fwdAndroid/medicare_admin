import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final String address, name, orderName, price, quantity, photoURL;

  OrderDetail({
    super.key,
    required this.price,
    required this.address,
    required this.name,
    required this.orderName,
    required this.photoURL,
    required this.quantity,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  price: widget.price,
                  address: widget.address,
                  name: widget.name,
                  orderName: widget.orderName,
                  quantity: widget.quantity,
                  photoURL: widget.photoURL,
                ),
                const _ImageSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final String price, address, name, orderName, quantity, photoURL;

  FormSection({
    Key? key,
    required this.orderName,
    required this.address,
    required this.name,
    required this.price,
    required this.quantity,
    required this.photoURL,
  }) : super(key: key);

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 448,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.photoURL),
            ),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.name),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Address:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.address),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Order Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.orderName),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Quantity:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.quantity),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Price:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.price),
            ]),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
