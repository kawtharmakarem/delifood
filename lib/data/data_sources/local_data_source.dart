// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/app/failure.dart';
import '/data/response/response.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeRecipesResponse> getHomeData();
  Future<void> saveHomeToCache(HomeRecipesResponse homeRecipesResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedItem> _cacheMap = Map();

  @override
  void clearCache() {
    _cacheMap.clear();
  }

  @override
  Future<HomeRecipesResponse> getHomeData() async {
    CachedItem? cachedItem = _cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw Failure.fromCode(ResponseCode.cacheError);
    }
  }

  @override
  void removeFromCache(String key) {
    _cacheMap.remove(key);
  }

  @override
  Future<void> saveHomeToCache(HomeRecipesResponse homeRecipesResponse) async {
    _cacheMap[CACHE_HOME_KEY] = CachedItem(homeRecipesResponse);
  }
}

class CachedItem {
  final dynamic data;
  final int cacheTime;
  CachedItem(this.data) : cacheTime = DateTime.now().millisecondsSinceEpoch;
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillise) {
    int currntTimeInMilliSe = DateTime.now().millisecondsSinceEpoch;
    return currntTimeInMilliSe - cacheTime <= expirationTimeInMillise;
  }
}
