import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';
import 'package:money_lover_clone/service_locator/service_locator.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountCtrlr = TextEditingController(text: "0");
  final TextEditingController _categoryCtrlr = TextEditingController();
  final TextEditingController _dateCtrlr = TextEditingController();
  final TextEditingController _descCtrlr = TextEditingController();

  final FocusNode _amountFocus = FocusNode();

  final TransactionBloc _transactionBloc = getIt.get<TransactionBloc>();

  int? amount;
  TransactionCategory? transactionCategory;
  DateTime dateTime = DateTime.now();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _amountFocus.requestFocus();
    _amountFocus.addListener(() {
      debugPrint("amountFocus listener ${_amountFocus.hasFocus}");
      setState(() {});
    });

    _dateCtrlr.text = dateTime.toString();
  }

  @override
  void dispose() {
    _amountCtrlr.dispose();
    _amountFocus.dispose();
    _categoryCtrlr.dispose();
    _dateCtrlr.dispose();
    _descCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: const Text(
          "Tambah transaksi",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.large,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _amountCtrlr,
                      focusNode: _amountFocus,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.none,
                      style: const TextStyle(
                        color: AppColors.primary500,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: AppColors.primary500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary500,
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary500,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Gap.vLarge,
                    TextField(
                      controller: _categoryCtrlr,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectCategoryScreen(
                              currentCategory: transactionCategory,
                              onSelectedCategory: (category) {
                                setState(() {
                                  transactionCategory = category;
                                  _categoryCtrlr.text = category.name;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: "Pilih Kategori",
                        hintStyle: TextStyle(
                          color: AppColors.neutral200,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.neutral400,
                          ),
                        ),
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                    ),
                    Gap.vLarge,
                    TextField(
                      controller: _descCtrlr,
                      maxLength: 150,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: "Keterangan",
                        hintStyle: TextStyle(
                          color: AppColors.neutral200,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary500,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.note_outlined,
                        ),
                      ),
                    ),
                    Gap.vLarge,
                    TextField(
                      controller: _dateCtrlr,
                      onTap: () {
                        AppDateUtils.pickDate(
                          context,
                          initialDate: dateTime,
                          onSelectedDate: (selectedDate) {
                            setState(() {
                              dateTime = selectedDate;
                              _dateCtrlr.text = selectedDate.toString();
                            });
                          },
                        );
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: "Tanggal",
                        hintStyle: TextStyle(
                          color: AppColors.neutral200,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.neutral400,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                        ),
                      ),
                    ),
                    Gap.vLarge,
                    if (imageFile != null) Image.file(imageFile!),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary100.withOpacity(0.5),
                        borderRadius: AppBorderRadiuses.small,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  ImageUtils.pickImage(
                                    context,
                                    onSelectedImage: (selectedImage) {
                                      setState(() {
                                        imageFile = File(selectedImage!.path);
                                      });
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: AppPaddings.vMedium,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                ImageUtils.pickImage(
                                  context,
                                  openCamera: false,
                                  onSelectedImage: (selectedImage) {
                                    setState(() {
                                      imageFile = File(selectedImage!.path);
                                    });
                                  },
                                );
                              },
                              child: const Padding(
                                padding: AppPaddings.vMedium,
                                child: Icon(
                                  Icons.image_outlined,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SaveNewTransactionButton(
            amount: amount,
            transactionCategory: transactionCategory,
            transactionBloc: _transactionBloc,
            dateTime: dateTime,
            descCtrlr: _descCtrlr,
            imageFile: imageFile,
          ),
          if (_amountFocus.hasFocus)
            Calculator(
              controller: _amountCtrlr,
              initialAmount: amount,
              onValueChanged: (value) {
                amount = value;
              },
            ),
        ],
      ),
    );
  }
}
