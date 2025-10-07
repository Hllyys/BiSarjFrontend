import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';
import 'package:frontend_bisarj/graphql/graphql_client.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

class SelectModelScreen extends StatefulWidget {
  final int brandId;
  const SelectModelScreen({super.key, required this.brandId});

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
  List<dynamic> modelList = [];
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchModels();
  }

  Future<void> fetchModels() async {
    setState(() => isLoading = true);
    try {
      final client = (await buildGraphQLClient()).value;

      final result = await client.query(
        QueryOptions(
          document: gql(getCarModelsQuery),
          variables: {'page': 1, 'limit': 50},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        _showSnackBar("Hata: ${result.exception.toString()}", Colors.red);
      } else {
        final docs = result.data?['CarModels']?['docs'] ?? [];

        // Markaya göre filtreleme
        final filtered = docs.where((m) {
          final brand = m['brand'];
          return brand != null && brand['id'] == widget.brandId;
        }).toList();

        setState(() => modelList = filtered);
      }
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  /*
  // 🟢 Yeni model ekleme
  Future<void> addModel() async {
    if (nameController.text.isEmpty || yearController.text.isEmpty) {
      _showSnackBar("Lütfen model adı ve yıl giriniz", Colors.orange);
      return;
    }

    try {
      setState(() => isLoading = true);
      final client = (await buildGraphQLClient()).value;

      final result = await client.mutate(
        MutationOptions(
          document: gql(createCarModelMutation),
          variables: {
            'name': nameController.text.trim(),
            'year': double.parse(yearController.text.trim()),
            'brand': widget.brandId,
          },
        ),
      );

      if (result.hasException) {
        _showSnackBar("Hata: ${result.exception.toString()}", Colors.red);
      } else {
        _showSnackBar("Model başarıyla eklendi", Colors.green);
        nameController.clear();
        yearController.clear();
        Navigator.pop(context);
        await fetchModels();
      }
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  // 🟢 Yeni model ekleme dialogu
  void openAddModelDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Yeni Model Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Model Adı'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Model Yılı'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(onPressed: addModel, child: const Text('Kaydet')),
        ],
      ),
    );
  }
  */

  // Güncelleme
  Future<void> updateModel(int id, String newName, double newYear) async {
    try {
      final client = (await buildGraphQLClient()).value;

      final result = await client.mutate(
        MutationOptions(
          document: gql(updateCarModelMutation),
          variables: {
            "id": id,
            "name": newName,
            "year": newYear,
            "brand": widget.brandId,
          },
        ),
      );

      if (result.hasException) {
        _showSnackBar(
          "Güncelleme hatası: ${result.exception.toString()}",
          Colors.red,
        );
        return;
      }

      _showSnackBar("Model güncellendi", Colors.green);
      await fetchModels();
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    }
  }

  // Silme
  Future<void> deleteModel(int id) async {
    try {
      final client = (await buildGraphQLClient()).value;
      final result = await client.mutate(
        MutationOptions(
          document: gql(deleteCarModelMutation),
          variables: {'id': id},
        ),
      );

      if (result.hasException) {
        _showSnackBar(
          "Silme hatası: ${result.exception.toString()}",
          Colors.red,
        );
        return;
      }

      _showSnackBar("Model silindi", Colors.green);
      await fetchModels();
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    }
  }

  // Kopyalama
  Future<void> duplicateModel(
    int id,
    String currentName,
    double currentYear,
  ) async {
    try {
      final client = (await buildGraphQLClient()).value;

      final newName =
          "${currentName}_copy_${DateTime.now().millisecondsSinceEpoch}";

      final result = await client.mutate(
        MutationOptions(
          document: gql(duplicateCarModelMutation),
          variables: {
            "id": id,
            "data": {
              "name": newName,
              "year": currentYear,
              "brand": widget.brandId,
            },
          },
        ),
      );

      if (result.hasException) {
        _showSnackBar(
          "Kopyalama hatası: ${result.exception.toString()}",
          Colors.red,
        );
        return;
      }

      _showSnackBar("Model başarıyla kopyalandı", Colors.green);
      await fetchModels();
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    }
  }

  // Tek model getir
  Future<void> fetchSingleModel(int id) async {
    try {
      final client = (await buildGraphQLClient()).value;

      final result = await client.query(
        QueryOptions(
          document: gql(getCarModelsByBrandQuery),
          variables: {'id': id},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        _showSnackBar(
          "Detay hatası: ${result.exception.toString()}",
          Colors.red,
        );
        return;
      }

      final model = result.data?['CarModel'];
      if (model != null && model['brand']?['id'] == widget.brandId) {
        _showSnackBar(
          "📘 ${model['name']} (${model['year']}) — Marka: ${model['brand']['name']}",
          Colors.blueAccent,
        );
      } else {
        _showSnackBar("Bu model seçili markaya ait değil.", Colors.orange);
      }
    } catch (e) {
      _showSnackBar("Bir hata oluştu: $e", Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Seç'),
        actions: [
          /*
          // 🟢 Ekleme butonu da devre dışı
          IconButton(
            onPressed: openAddModelDialog,
            icon: const Icon(Icons.add_circle_outline),
          ),
          */
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : modelList.isEmpty
          ? const Center(child: Text('Bu markaya ait model bulunamadı'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: modelList.length,
                itemBuilder: (_, index) {
                  final model = modelList[index];
                  final id = int.parse(model['id'].toString());
                  final name = model['name'];
                  final year = double.tryParse(model['year'].toString()) ?? 0.0;

                  return ListTile(
                    onTap: () => fetchSingleModel(id),
                    title: Text('$name (${year.toInt()})'),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => duplicateModel(id, name, year),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            final nameCtrl = TextEditingController(text: name);
                            final yearCtrl = TextEditingController(
                              text: year.toString(),
                            );
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Model Güncelle"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameCtrl,
                                        decoration: const InputDecoration(
                                          labelText: "Model Adı",
                                        ),
                                      ),
                                      TextField(
                                        controller: yearCtrl,
                                        decoration: const InputDecoration(
                                          labelText: "Model Yılı",
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text("İptal"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        updateModel(
                                          id,
                                          nameCtrl.text.trim(),
                                          double.tryParse(yearCtrl.text) ??
                                              year,
                                        );
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("Güncelle"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Modeli Sil"),
                                content: const Text(
                                  "Bu modeli silmek istediğinize emin misiniz?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("İptal"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      deleteModel(id);
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("Sil"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
