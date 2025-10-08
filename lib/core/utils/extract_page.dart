int? extractPage(String? url) {
  if (url == null) return null;
  try {
    final uri = Uri.parse(url);
    return int.tryParse(uri.queryParameters['page'] ?? '');
  } catch (e) {
    return null;
  }
}