import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_lover_clone/features/common/common.dart';
import 'package:money_lover_clone/features/transaction/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountCtrlr = TextEditingController(text: "0");
  final TextEditingController _categoryCtrlr = TextEditingController();
  final TextEditingController _dateCtrlr = TextEditingController();

  final FocusNode _amountFocus = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
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
                    const TextField(
                      maxLength: 150,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
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
          Container(
            padding: AppPaddings.large,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                foregroundColor: AppColors.neutral100,
                elevation: 0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.x3),
                width: 1.sw,
                child: const Text(
                  "Simpan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          if (_amountFocus.hasFocus)
            Calculator(
              controller: _amountCtrlr,
              onValueChanged: (amount) {},
            ),
        ],
      ),
    );
  }
}
