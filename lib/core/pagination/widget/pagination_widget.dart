import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/extension.dart';
import '../../utils/values/text_styles.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/text_form_field.dart';
import '../cubit/pagination_cubit.dart';
import '../entity/pagination_response.dart';
import '../usecase/additional_pagination_params.dart';
import '../usecase/pagination_usecase.dart';

class PaginationWidget<Data,
        Cubit extends PaginationCubit<Data, PaginationUseCase<Data>>>
    extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final Widget Function(Data item, int index) itemCardWidget;
  final List<Data>? items;
  final Widget? itemCardShimmerWidget;
  final bool isSearch;
  final TextEditingController? searchTextController;
  final String? hintText;
  final AdditionalPaginationParams? additionalParams;
  final int? perPage;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final Widget? emptyItemsWidget;
  final void Function(PaginationResponse<Data> response)? onSuccess;

  const PaginationWidget({
    this.title = '',
    required this.itemCardWidget,
    this.titleWidget,
    this.items,
    this.itemCardShimmerWidget,
    this.isSearch = false,
    this.searchTextController,
    this.hintText,
    this.additionalParams,
    this.perPage,
    this.padding,
    this.separator,
    this.emptyItemsWidget,
    this.onSuccess,
    super.key,
  });

  void initBuild(BuildContext context){
    context.read<Cubit>().addScrollListener();
    if(items == null){
      context.read<Cubit>().fPagination(
        page: 1,
        additionalParams: additionalParams,
        perPage: perPage,
        onSuccess: onSuccess,
      );
    } else {
      context.read<Cubit>().emitItems(items!);
    }
  }

  @override
  Widget build(BuildContext context) {
    initBuild(context);
    return Column(
      children: [
        titleWidget?? Padding(
          padding: EdgeInsets.all(16.r),
          child: Center(
            child: Text(
              title,
              style: TextStyles.semiBold16(),
            ),
          ),
        ),
        isSearch
            ? Padding(
                padding: EdgeInsets.all(16.r),
                child: AppTextFormField(
                  controller: searchTextController,
                  hintText: hintText,
                  focusNode: FocusNode(),
                  onChanged: (value) {
                    if (value?.isEmpty == true) {
                      context.read<Cubit>().emitAllData();
                    }
                    if(searchTextController != null &&
                        searchTextController!.text.trim().isNotEmpty){
                      context.read<Cubit>().fPaginationSearch(
                        page: 1,
                        term: searchTextController!.text.trim(),
                        additionalParams: additionalParams,
                        perPage: perPage,
                      );
                    }
                  },
                  onSubmit: (value) {
                    if (searchTextController != null &&
                        searchTextController!.text.trim().isNotEmpty) {
                      context.read<Cubit>().fPaginationSearch(
                        page: 1,
                        term: searchTextController!.text.trim(),
                        additionalParams: additionalParams,
                        perPage: perPage,
                      );
                    }
                  },
                ),
              )
            : const SizedBox(),
        Expanded(
          child: BlocConsumer<Cubit, PaginationState>(
            listener: (context, state) {
              if (state is PaginationErrorState) {
                showAppSnackBar(
                  context: context,
                  message: state.message,
                  type: ToastType.error,
                );
              }
            },
            buildWhen: (previous, current) {
              final bool previousLoading = previous is PaginationLoadingState
                  || previous is PaginationPaginationLoadingState;
                  final bool currentSuccess = current is PaginationSuccessState;
              return (previousLoading && currentSuccess)
                  || current is PaginationLoadingState;
            },
            builder: (context, state) {
              if(state is PaginationSuccessState && state.value.isEmpty && emptyItemsWidget != null){
                return emptyItemsWidget!;
              }
              return ListView.separated(
                controller: context.read<Cubit>().scrollController,
                padding: padding?? EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (state is PaginationSuccessState) {
                    /// Item
                    final item = state.value[index];
                    return itemCardWidget(item, index);
                  }

                  /// Shimmer
                  return itemCardShimmerWidget;
                },
                separatorBuilder: (context, index) => separator?? SizedBox(height: 16.h),
                itemCount: state is PaginationSuccessState ? state.value.length : 10,
              );
            },
          ),
        ),
        /// Pagination Loading
        BlocBuilder<Cubit, PaginationState>(
          buildWhen: (previous, current) =>
              (previous is PaginationPaginationLoadingState ||
                  previous is PaginationSuccessState) &&
              (current is PaginationPaginationLoadingState ||
                  current is PaginationSuccessState),
          builder: (context, state) {
            if (state is PaginationPaginationLoadingState) {
              return Center(
                child: const CircularProgressIndicator().appLoading,
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
