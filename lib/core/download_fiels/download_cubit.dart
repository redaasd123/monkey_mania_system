import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  Future<void> downloadFile()async{

  }
}


//onPressed: () async {
//             final cubit = context.read<SchoolCubit>().state;
//             await requestStoragePermission();
//             final downloader = FileDownloaderUI();
//             final FetchBillsParam param = FetchBillsParam(
//               query: cubit.searchQuery
//             );
//
//             await downloader.downloadFile(
//               context,
//               '${kBaseUrl}school/all/?is_csv_response=true&${param.toQueryParams()}',
//               'schools.csv',
//             );
//           },
