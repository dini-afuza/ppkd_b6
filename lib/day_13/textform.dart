import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ppkd_b6/day_13/pop.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class TextFormDay13 extends StatefulWidget {
  const TextFormDay13({super.key});

  @override
  State<TextFormDay13> createState() => _TextFormDay13State();
}

class _TextFormDay13State extends State<TextFormDay13> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Text Form Day 13"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Masukkan Email",

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!value.contains('@')) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Masukkan Password",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  } else if (value.length < 6) {
                    return "Password terlalu singkat";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: "Masukkan Nomor Handphone",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor telepon tidak boleh kosong";
                  } else if (value.length < 9 || value.length > 14) {
                    return "Nomor telepon tidak valid";
                  }
                  return null;
                },
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Sudah memenuhi syarat");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Berhasil"),
                            content: Text("Anda berhasil login"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.push(NavigatorPopDay13());
                                },
                                child: Text("Lanjut"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Silakan periksa kembali",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Silakan periksa kembali")),
                      // );
                    }
                  },
                  child: Text("LOGIN"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
