// import 'package:digital_jeweller/core/base/base_controller.dart';
// import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
// import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
// import 'package:digital_jeweller/features/admin/domain/usecases/create_scheme_usecase.dart';
// import 'package:digital_jeweller/features/admin/domain/usecases/update_scheme_usecase.dart';
// import 'package:digital_jeweller/features/admin/domain/usecases/delete_scheme_usecase.dart';
// import 'package:get/get.dart';

import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/delete_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/update_scheme_usecase.dart';
import 'package:get/get.dart';

class SchemeController extends BaseController {
  final GetSchemesUseCase getSchemesUseCase;
  final CreateSchemeUseCase createSchemeUseCase;
  final UpdateSchemeUseCase updateSchemeUseCase;
  final DeleteSchemeUseCase deleteSchemeUseCase;

  SchemeController({
    required this.getSchemesUseCase,
    required this.createSchemeUseCase,
    required this.updateSchemeUseCase,
    required this.deleteSchemeUseCase,
  });

  final schemes = <Scheme>[].obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSchemes();
  }

  Future<void> loadSchemes() async {
    try {
      showLoading();
      error.value = '';
      final result = await getSchemesUseCase.execute();
      schemes.assignAll(result);
    } catch (e) {
      error.value = e.toString();
      showError('Failed to load schemes');
    } finally {
      hideLoading();
    }
  }

  Future<void> refreshSchemes() async {
    await loadSchemes();
  }

  // Future<void> createScheme({
  //   required String name,
  //   required String description,
  //   required double totalAmount,
  //   required double emiAmount,
  //   required String jewellerCode,
  //   required int durationMonths,
  //   required String startDate,
  //   required String endDate,
  // }) async {
  //   try {
  //     showLoading();
  //     await createSchemeUseCase.execute(
  //       name: name,
  //       description: description,
  //       totalAmount: totalAmount,
  //       emiAmount: emiAmount,
  //       jewellerCode: jewellerCode,
  //       durationMonths: durationMonths,
  //       startDate: startDate,
  //       endDate: endDate,
  //     );
  //     showSuccess('Scheme created successfully');
  //     await refreshSchemes();
  //     Get.back();
  //   } catch (e) {
  //     showError('Failed to create scheme: ${e.toString()}');
  //   } finally {
  //     hideLoading();
  //   }
  // }

  // Future<void> updateScheme({
  //   required String id,
  //   Map<String, dynamic>? updateData,
  // }) async {
  //   try {
  //     showLoading();
  //     await updateSchemeUseCase.execute(id: id, updateData: updateData);
  //     showSuccess('Scheme updated successfully');
  //     await refreshSchemes();
  //     Get.back();
  //   } catch (e) {
  //     showError('Failed to update scheme: ${e.toString()}');
  //   } finally {
  //     hideLoading();
  //   }
  // }
  //
  // Future<void> deleteScheme(String id) async {
  //   try {
  //     showLoading();
  //     await deleteSchemeUseCase.execute(id);
  //     showSuccess('Scheme deleted successfully');
  //     await refreshSchemes();
  //   } catch (e) {
  //     showError('Failed to delete scheme: ${e.toString()}');
  //   } finally {
  //     hideLoading();
  //   }
  // }
}
