class FetchChildrenParam{
  final String? query;
  final int? pageNumber;

  FetchChildrenParam({ this.query,  this.pageNumber});


  Map<String,dynamic> toJson(){
    return{
      "page":pageNumber??1,
      "search":query??'',
  };

}
}