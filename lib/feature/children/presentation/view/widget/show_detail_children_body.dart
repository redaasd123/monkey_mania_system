import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monkey_app/core/utils/langs_key.dart';
import 'package:monkey_app/core/utils/styles.dart';
import 'package:monkey_app/feature/children/data/model/children_model.dart';

class ShowDetailChildrenBody extends StatelessWidget {
  const ShowDetailChildrenBody({super.key, required this.childrenModel});

  final ChildrenModel childrenModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    childrenModel.name ?? '',
                    style: Styles.textStyle20,
                  ),
                ),
              ),
              titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildSectionTitle(LangKeys.name.tr()),
              _buildInfoBox(childrenModel.name ?? ''),
              _buildSectionTitle(LangKeys.dateOfBirth.tr()),
              _buildInfoBox(childrenModel.birthDate ?? ''),
              _buildSectionTitle(LangKeys.age.tr()),
              _buildInfoBox(
                childrenModel.age != null
                    ? '${childrenModel.age!.years ?? 0}/${childrenModel.age!.months ?? 0}/${childrenModel.age!.days ?? 0}'
                    : 'غير محدد',
              ),

              _buildSectionTitle(LangKeys.address.tr()),
              _buildInfoBox(childrenModel.address ?? ''),
              _buildSectionTitle(LangKeys.school.tr()),
              _buildInfoBox(childrenModel.school.toString()),

              // تقدر تغير الاسم حسب الـ ID
              _buildSectionTitle(LangKeys.notes.tr()),
              _buildInfoBox(childrenModel.notes ?? ""),

              _buildSectionTitle(LangKeys.active.tr()),
              _buildInfoBox(childrenModel.isActive.toString()),
              _buildSectionTitle(LangKeys.specialNeeds.tr()),
              _buildInfoBox(childrenModel.specialNeeds.toString()),

              _buildSectionTitle(LangKeys.createdBy.tr()),
              _buildInfoBox(childrenModel.createdBy ?? ''),
              _buildSectionTitle(LangKeys.createdAt.tr()),
              _buildInfoBox(childrenModel.created ?? ''),
              _buildSectionTitle(LangKeys.lastUpdate.tr()),
              _buildInfoBox(childrenModel.updated ?? ''),

              _buildSectionTitle(LangKeys.phoneNumber.tr()),
              if (childrenModel.childPhoneNumbersSet != null)
                //دي اسمها Spread Operator، بتفرد قائمة عناصر داخل واجهة Flutter.
                //لأن map() بتمشي على العناصر واحد واحد، ومفيش أي لوب بيخليها تتكرر مرتين. فكل عنصر بيتعرض مرة واحدة فقط.
                ...childrenModel.childPhoneNumbersSet!.map((phone) {
                  return _buildPhoneBox(
                    phone.phoneNumber ?? LangKeys.notFound.tr(),
                    phone.relationship ?? LangKeys.notFound.tr(),
                  );
                }).toList(),

              _buildSectionTitle(LangKeys.notFound.tr()),
              _buildInfoBox("Child Updated successfully"),

              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}


Widget _buildInfoBox(String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 15),
        textAlign: TextAlign.right,
      ),
    ),
  );
}

Widget _buildPhoneBox(String phone, String relation) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Expanded(child: _buildInfoBox(phone)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(relation, style: const TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}
