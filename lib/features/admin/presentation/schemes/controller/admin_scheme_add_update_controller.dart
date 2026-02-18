import 'package:digital_jeweller/features/admin/presentation/schemes/controller/scheme_controller.dart';
import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/delete_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/update_scheme_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminSchemeAddUpdateController extends BaseController {
  final CreateSchemeUseCase createSchemeUseCase;
  final UpdateSchemeUseCase updateSchemeUseCase;
  final DeleteSchemeUseCase deleteSchemeUseCase;

  AdminSchemeAddUpdateController({
    required this.createSchemeUseCase,
    required this.updateSchemeUseCase,
    required this.deleteSchemeUseCase,
  });

  List<Scheme> schemes = <Scheme>[].obs;
  final RxString error = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController emiAmountController = TextEditingController();
  TextEditingController durationMonthsController = TextEditingController();
  TextEditingController jewellerCodeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  var scheme = Rxn<Scheme>();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  RxBool isUpdate = false.obs;

  @override
  void onInit() {
    scheme.value = Get.arguments as Scheme?;
    isUpdate.value = scheme.value != null;
    if (scheme.value != null) {
      nameController.text = scheme.value!.name;
      descriptionController.text = scheme.value!.description;
      totalAmountController.text = scheme.value!.totalAmount.toString();
      emiAmountController.text = scheme.value!.emiAmount.toString();
      durationMonthsController.text = scheme.value!.durationMonths.toString();
      startDateController.text = dateFormat.format(scheme.value!.startDate);
      endDateController.text = dateFormat.format(scheme.value!.endDate);
    }
    super.onInit();
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = dateFormat.format(picked);
    }
  }

  Future<void> createScheme({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  }) async {
    try {
      showLoading();
      await createSchemeUseCase.execute(
        name: name,
        description: description,
        totalAmount: totalAmount,
        emiAmount: emiAmount,
        jewellerCode: jewellerCode,
        durationMonths: durationMonths,
        startDate: startDate,
        endDate: endDate,
      );
      Get.back();
      showSuccess('Scheme created successfully');
      if (Get.isRegistered<SchemeController>()) {
        Get.find<SchemeController>().refreshSchemes();
      }
    } catch (e) {
      showError('Failed to create scheme: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  Future<void> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
  }) async {
    try {
      showLoading();
      await updateSchemeUseCase.execute(id: id, updateData: updateData);
      Get.back();
      showSuccess('Scheme updated successfully');
      if (Get.isRegistered<SchemeController>()) {
        Get.find<SchemeController>().refreshSchemes();
      }
    } catch (e) {
      showError('Failed to update scheme: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteScheme() async {
    try {
      showLoading();
      await deleteSchemeUseCase.execute(scheme.value!.id);
      Get.back();
      Get.back();
      showSuccess('Scheme deleted successfully');
      if (Get.isRegistered<SchemeController>()) {
        Get.find<SchemeController>().refreshSchemes();
      }
    } catch (e) {
      showError('Failed to delete scheme: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  onTapUpdateCreate() {
    if (scheme.value != null) {
      updateScheme(
        id: scheme.value!.id,
        updateData: {
          "name": nameController.text,
          "description": descriptionController.text,
          "totalAmount": double.tryParse(totalAmountController.text),
          "emiAmount": double.tryParse(emiAmountController.text),
          "durationMonths": int.tryParse(durationMonthsController.text),
          "startDate": startDateController.text,
          "endDate": endDateController.text,
        },
      );
    } else {
      createScheme(
        name: nameController.text,
        description: descriptionController.text,
        totalAmount: double.tryParse(totalAmountController.text) ?? 0,
        emiAmount: double.tryParse(emiAmountController.text) ?? 0,
        jewellerCode: jewellerCodeController.text,
        durationMonths: int.tryParse(durationMonthsController.text) ?? 0,
        startDate: startDateController.text,
        endDate: endDateController.text,
      );
    }
  }
}
