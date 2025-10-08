import 'package:monkey_app/core/utils/api_serviece.dart';
import 'package:monkey_app/core/utils/service_locator.dart';
import 'package:monkey_app/feature/branch/data/model/branch_model.dart';
import 'package:monkey_app/feature/branch/domain/entity/branch_entity.dart';

abstract class BranchRemoteDataSource {
  Future<List<BranchEntity>> fetchBranch();
}

class BranchRemoteDataSourceImpl extends BranchRemoteDataSource {
  @override
  Future<List<BranchEntity>> fetchBranch() async {
    var result = await getIt.get<Api>().get(endPoint: 'branch/all/');
    List<BranchEntity> branchList = [];
    for (var item in result) {
      branchList.add(BranchModel.fromJson(item));
    }

    return branchList;
  }
}
