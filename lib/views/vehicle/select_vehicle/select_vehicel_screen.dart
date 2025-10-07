import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/views/vehicle/add_brand/add_brand_screen.dart';
import 'package:frontend_bisarj/views/vehicle/select_model_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../graphql/graphql_client.dart';

class SelectVehicelScreen extends StatefulWidget {
  const SelectVehicelScreen({super.key});

  @override
  State<SelectVehicelScreen> createState() => _SelectVehicelScreenState();
}

class _SelectVehicelScreenState extends State<SelectVehicelScreen> {
  List<dynamic> brandList = [];
  bool isLoading = false;
  int currentPage = 1;
  final int limit = 20;
  bool hasNextPage = true;

  final ScrollController _scrollController = ScrollController();
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchBrands();
    _loadAd();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          hasNextPage &&
          !isLoading) {
        currentPage++;
        fetchBrands(page: currentPage);
      }
    });
  }

  Future<void> fetchBrands({int page = 1}) async {
    setState(() => isLoading = true);
    try {
      final client = await buildGraphQLClient();
      final result = await client.value.query(
        QueryOptions(
          document: gql(getCarBrandsQuery),
          variables: {'page': page, 'limit': limit},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        _showSnackBar("Hata: ${result.exception.toString()}", Colors.red);
        return;
      }

      final docs = result.data?['CarBrands']?['docs'] ?? [];
      hasNextPage = result.data?['CarBrands']?['hasNextPage'] ?? false;

      setState(() {
        if (page == 1) {
          brandList = docs;
        } else {
          brandList.addAll(docs);
        }
      });
    } catch (e) {
      _showSnackBar("Hata: $e", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  ///  Marka ekle
  Future<void> addBrand(String name) async {
    try {
      final client = await buildGraphQLClient();
      final result = await client.value.mutate(
        MutationOptions(
          document: gql(createCarBrandMutation),
          variables: {"name": name},
        ),
      );

      if (result.hasException) {
        _showSnackBar("Ekleme hatası", Colors.red);
      } else {
        _showSnackBar("Marka eklendi", Colors.green);
        await fetchBrands(page: 1);
      }
    } catch (e) {
      _showSnackBar("Hata: $e", Colors.red);
    }
  }

  //  Marka güncelle
  Future<void> updateBrand(int id, String newName) async {
    try {
      final client = await buildGraphQLClient();
      final result = await client.value.mutate(
        MutationOptions(
          document: gql(updateCarBrandMutation),
          variables: {"id": id, "name": newName},
        ),
      );

      if (result.hasException) {
        _showSnackBar("Güncelleme hatası", Colors.red);
      } else {
        _showSnackBar("Güncellendi", Colors.green);
        await fetchBrands(page: 1);
      }
    } catch (e) {
      _showSnackBar("Hata: $e", Colors.red);
    }
  }

  // Marka sil
  Future<void> deleteBrand(int id) async {
    try {
      final client = await buildGraphQLClient();
      final result = await client.value.mutate(
        MutationOptions(
          document: gql(deleteCarBrandMutation),
          variables: {"id": id},
        ),
      );

      if (result.hasException) {
        _showSnackBar("Silme hatası", Colors.red);
      } else {
        setState(() => brandList.removeWhere((b) => b['id'] == id));
        _showSnackBar("Silindi", Colors.green);
      }
    } catch (e) {
      _showSnackBar("Hata: $e", Colors.red);
    }
  }

  // Kopyala
  Future<void> duplicateBrand(String name) async {
    final newName = "${name}_copy";
    await addBrand(newName);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _loadAd() async {
    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid ? androidBannerAdsKey : iOSBannerAdsKey,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isLoaded = true),
      ),
    );
    _anchoredAdaptiveAd!.load();
  }

  void openAddBrandDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Yeni Marka Ekle'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Marka Adı'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              addBrand(controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void openEditBrandDialog(dynamic brand) {
    final controller = TextEditingController(text: brand['name']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Markayı Güncelle'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              updateBrand(int.parse(brand['id'].toString()), controller.text);
              Navigator.pop(context);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marka Seç'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: openAddBrandDialog,
          ),
        ],
      ),
      body: isLoading && brandList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => fetchBrands(page: 1),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: brandList.length,
                itemBuilder: (_, i) {
                  final brand = brandList[i];
                  final brandId = int.tryParse(brand['id'].toString()) ?? 0;

                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SelectModelScreen(brandId: brandId),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.directions_car, color: Colors.green),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              brand['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, color: Colors.blue),
                            onPressed: () => duplicateBrand(brand['name']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => openEditBrandDialog(brand),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                deleteBrand(int.parse(brand['id'].toString())),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
