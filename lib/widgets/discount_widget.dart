// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:real_world_provider/providers/discount_provider.dart';
//
// import '../providers/cart_provider.dart';
//
// class DiscountWidget extends StatefulWidget {
//   const DiscountWidget({super.key});
//
//   @override
//   State<DiscountWidget> createState() => _DiscountWidgetState();
// }
//
// class _DiscountWidgetState extends State<DiscountWidget> {
//   final TextEditingController _codeController = TextEditingController();
//
//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DiscountProvider>(
//       builder: (context, discountProvider, child) {
//         return Card(
//           margin: EdgeInsets.all(16),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Discount Code',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 SizedBox(height: 12),
//                 // Input field para el código
//                 if (!discountProvider.hasDiscount) ...[
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _codeController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter discount code',
//                             border: OutlineInputBorder(),
//                             errorText:
//                                 discountProvider.status == DiscountStatus.invalid || discountProvider.status == DiscountStatus.expired
//                                 ? discountProvider.errorMessage
//                                 : null,
//                             errorStyle: TextStyle(
//                               fontSize: 10,
//                             )
//                           ),
//                           textCapitalization: TextCapitalization.characters,
//                           enabled:
//                               discountProvider.status != DiscountStatus.loading,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed:
//                             discountProvider.status == DiscountStatus.loading
//                             ? null
//                             : () => _applyDiscount(context, discountProvider),
//                         child: discountProvider.status == DiscountStatus.loading
//                             ? SizedBox(
//                                 width: 16,
//                                 height: 16,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : Text('Apply'),
//                       ),
//                     ],
//                   ),
//                 ],
//
//                 // 🎉 Descuento aplicando exitosamente
//                 if (discountProvider.hasDiscount) ...[
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.green[50],
//                       border: Border.all(color: Colors.green[200]!),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.check_circle, color: Colors.green),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Discount Applied!',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green[800],
//                                 ),
//                               ),
//                               Text(
//                                 discountProvider
//                                     .appliedDiscount!
//                                     .discountCode
//                                     .description,
//                                 style: TextStyle(color: Colors.green[700],),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: discountProvider.removeDiscount,
//                           icon: Icon(Icons.close),
//                           color: Colors.green[700],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//
//                 // 🎁 Mostrar códigos disponibles
//                 if (!discountProvider.hasDiscount &&
//                     discountProvider.status != DiscountStatus.loading) ...[
//                   SizedBox(height: 12),
//                   Text(
//                     'Available codes: ',
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 4),
//                   Wrap(
//                     spacing: 8,
//                     children: discountProvider.availableCodes.map((code) {
//                       return InkWell(
//                         onTap: () {
//                           _codeController.text = code.code;
//                         },
//                         child: Chip(
//                           label: Text(
//                             '${code.code} (${code.percentage}%)',
//                             style: TextStyle(fontSize: 10),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _applyDiscount(BuildContext context, DiscountProvider discountProvider) {
//     final code = _codeController.text.trim();
//     print('[Discount Widget] - Code: ${code}');
//     if (code.isNotEmpty) {
//       discountProvider.applyDiscountCode(code);
//     }
//   }
// }
