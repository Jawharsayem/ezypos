import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/Provider/product_provider.dart';
import 'package:mobile_pos/Screens/Customers/Model/customer_model.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/add_to_cart.dart';
import '../../currency.dart';
import '../../model/add_to_cart_model.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

// ignore: must_be_immutable
class SaleProducts extends StatefulWidget {
  SaleProducts({Key? key, @required this.catName, this.customerModel}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var catName;
  CustomerModel? customerModel;

  @override
  // ignore: library_private_types_in_public_api
  _SaleProductsState createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  String dropdownValue = '';
  String productCode = '0000';

  var salesCart = FlutterCart();
  String productPrice = '0';
  String sentProductPrice = '';

  String productName = '';

  TextEditingController scarchController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    widget.catName == null ? dropdownValue = 'Fashion' : dropdownValue = widget.catName;
    super.initState();
  }

  // Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     productCode = barcodeScanRes;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final providerData = ref.watch(cartNotifier);
      final productList = ref.watch(productProvider);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            lang.S.of(context).addItems,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          // actions: [
          //   PopupMenuButton(
          //     itemBuilder: (BuildContext bc) => [
          //       const PopupMenuItem(value: "/addPromoCode", child: Text('Add Promo Code')),
          //       const PopupMenuItem(value: "clear", child: Text('Cancel All Product')),
          //       const PopupMenuItem(value: "/settings", child: Text('Vat Doesn\'t Apply')),
          //     ],
          //     onSelected: (value) {
          //       value == 'clear'
          //           ? {
          //               providerData.clearCart(),
          //               providerData.clearDiscount(),
          //               const HomeScreen().launch(context, isNewTask: true)
          //             }
          //           : Navigator.pushNamed(context, '$value');
          //     },
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 56.0,
                      child: Form(
                        key: _key,
                        child: TextFormField(
                          controller: scarchController,
                          onChanged: (value) {
                            setState(() {
                              productCode = value;
                              productName = value;
                            });
                          },
                          onSaved: (newValue) {
                            setState(() {
                              productCode = newValue ?? '';
                              productName = newValue ?? '';
                            });
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //labelText: 'Product code/Name',
                            labelText: lang.S.of(context).productCode,
                            hintText: productCode.isEmpty ? 'Search by product or qr code' : productCode,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context1) {
                          MobileScannerController controller = MobileScannerController(
                            torchEnabled: false,
                            returnImage: false,
                          );
                          return Container(
                            decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(6.0)),
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor: Colors.transparent,
                                  iconTheme: const IconThemeData(color: Colors.white),
                                  leading: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.pop(context1);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: MobileScanner(
                                    fit: BoxFit.contain,
                                    controller: controller,
                                    onDetect: (capture) {
                                      final List<Barcode> barcodes = capture.barcodes;

                                      if (barcodes.isNotEmpty) {
                                        final Barcode barcode = barcodes.first;
                                        debugPrint('Barcode found! ${barcode.rawValue}');

                                        productCode = barcode.rawValue!;
                                        scarchController.text = productCode;
                                        _key.currentState!.save();

                                        Navigator.pop(context1);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: kGreyTextColor),
                      ),
                      child: Image.asset(
                        'images/barcode.png',
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              productList.when(data: (products) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) {
                      if (widget.customerModel!.type.contains('Retailer')) {
                        productPrice = products[i].productSalePrice;
                      } else if (widget.customerModel!.type.contains('Dealer')) {
                        productPrice = products[i].productDealerPrice;
                      } else if (widget.customerModel!.type.contains('Wholesaler')) {
                        productPrice = products[i].productWholeSalePrice;
                      } else if (widget.customerModel!.type.contains('Supplier')) {
                        productPrice = products[i].productPurchasePrice;
                      } else if (widget.customerModel!.type.contains('Guest')) {
                        productPrice = products[i].productSalePrice;
                      }
                      return GestureDetector(
                        onTap: () async {
                          if (products[i].productStock.toInt() <= 0) {
                            EasyLoading.showError('Out of stock');
                          } else {
                            if (widget.customerModel!.type.contains('Retailer')) {
                              sentProductPrice = products[i].productSalePrice;
                            } else if (widget.customerModel!.type.contains('Dealer')) {
                              sentProductPrice = products[i].productDealerPrice;
                            } else if (widget.customerModel!.type.contains('Wholesaler')) {
                              sentProductPrice = products[i].productWholeSalePrice;
                            } else if (widget.customerModel!.type.contains('Supplier')) {
                              sentProductPrice = products[i].productPurchasePrice;
                            } else if (widget.customerModel!.type.contains('Guest')) {
                              sentProductPrice = products[i].productSalePrice;
                            }

                            AddToCartModel cartItem = AddToCartModel(
                              productName: products[i].productName,
                              subTotal: sentProductPrice,
                              productId: products[i].productCode,
                              productBrandName: products[i].brandName,
                              productPurchasePrice: products[i].productPurchasePrice,
                              stock: int.parse(products[i].productStock),
                              uuid: products[i].productCode,
                            );
                            providerData.addToCartRiverPod(cartItem);
                            providerData.addProductsInSales(products[i]);
                            Navigator.pop(context);
                          }
                        },
                        child: ProductCard(
                          productTitle: products[i].productName,
                          productDescription: products[i].brandName,
                          productPrice: productPrice,
                          productImage: products[i].productPicture,
                        ).visible((products[i].productCode == productCode || productCode == '0000' || productCode == '-1') && productPrice != '0'),
                      );
                    });
              }, error: (e, stack) {
                return Text(e.toString());
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }),
            ],
          ),
        ),
        // bottomNavigationBar: ButtonGlobal(
        //   iconWidget: Icons.arrow_forward,
        //   buttontext: 'Sales List',
        //   iconColor: Colors.white,
        //   buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
        //   onPressed: () {
        //     // ignore: missing_required_param
        //     providerData.getTotalAmount() <= 0
        //         ? EasyLoading.showError('Cart Is Empty')
        //         : SalesDetails(
        //             customerName: widget.customerModel!.customerName,
        //           ).launch(context);
        //   },
        // ),
      );
    });
  }
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({Key? key, required this.productTitle, required this.productDescription, required this.productPrice, required this.productImage}) : super(key: key);

  // final Product product;
  String productImage, productTitle, productDescription, productPrice;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final providerData = ref.watch(cartNotifier);
      for (var element in providerData.cartItemList) {
        if (element.productName == widget.productTitle) {
          quantity = element.quantity;
        }
      }
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(widget.productImage), fit: BoxFit.cover),
          ),
        ),
        title: Text(
          widget.productTitle,
          style: GoogleFonts.jost(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          widget.productDescription,
          style: GoogleFonts.jost(
            fontSize: 15.0,
            color: kGreyTextColor,
          ),
        ),
        trailing: Text(
          '$currency${widget.productPrice}',
          style: GoogleFonts.jost(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      );
    });
  }
}
