class ApiResult {
  final String requestHash;
  final bool requestCached;
  final int requestCacheExpiry;
  final List<dynamic> results;

  ApiResult({
    required this.requestHash,
    required this.requestCached,
    required this.requestCacheExpiry,
    required this.results,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      requestHash: json['request_hash'],
      requestCached: json['request_cached'],
      requestCacheExpiry: json['request_cache_expiry'],
      results: json.containsKey('results') ? json['results'] :
               json.containsKey('top') ? json['top'] :
               json.containsKey('anime') ? json['anime'] :
               json.containsKey('manga') ? json['manga'] :
               json.containsKey('monday') ?
               [
                  json['monday'],
                  json['tuesday'],
                  json['wednesday'] ,
                  json['thursday'],
                  json['friday'],
                  json['saturday'],
                  json['sunday'],
               ]: [],
    );
  }
}