


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app/core/helper/auth_helper.dart';

import '../../../../../main_bills/domain/use_case/param/fetch_bills_param.dart';
import '../../../../domain/entity/layers_entity.dart';
import '../../../manager/coffee_bills/layers_cubit.dart';
class Layer1A2GridView extends StatelessWidget {
  const Layer1A2GridView({
    super.key,
    required this.category,
    required this.images,
    required this.state,
  });

  final List<LayersEntity> category;
  final List<String> images;
  final LayersState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: category.length,
          itemBuilder: (context, index) {
            final item = category[index];
            final imagePath = images[index % images.length];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  final branch = AuthHelper.getBranch();
                  if (state.status == LayersStatus.getLayerOneSuccess ||
                      state.status == LayersStatus.cashedLayerOne) {
                    context.read<LayersCubit>().getLayerTow(
                      FetchBillsParam(
                        layer1: item.name,
                        branch: [branch],
                      ),
                    );
                  } else {
                    context.read<LayersCubit>().getAllLayer(
                      FetchBillsParam(
                        layer1: state.selectedLayer1,
                        layer2: item.name,
                        branch: [branch],
                      ),
                    );
                  }
                },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9), // خلفية فاتحة شفافة
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: LinearGradient(
                        //0xFFF4EDF6
                        colors: [colorScheme.primary,colorScheme.primary,],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الصورة مع انحناء أعلى وأنيق
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // النص مع خلفية شفافة فوق gradient
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                          ),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

              ),
            );
          },
        ),
        if (state.status == LayersStatus.getLayerTowSuccess ||
            state.status == LayersStatus.cashedLayerTow)
          Align(
            alignment: Alignment.center,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                context.read<LayersCubit>().getLayerOneCashed();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF004953), Color(0xFF004953)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      "الرجوع إلى المنيو",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

      ],
    );
  }
}