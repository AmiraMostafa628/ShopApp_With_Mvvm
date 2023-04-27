import 'package:clean_architecture/data/network/error_handler.dart';
import 'package:clean_architecture/data/response/responses.dart';


const cacheKey = "CACHE_KEY";
const storeDetailsKey = "STORE_KEY";

const cacheHomeInternalTime = 60*1000;
const cacheStoreInternalTime = 60*1000;


abstract class LocalDataSource{
  Future<HomeResponse>getHomeData();

  Future<StoreDetailsResponse>getStoreDetailsData();

  Future<void>saveDataToCache(HomeResponse homeResponse);

  Future<void>saveStoreDataToCache(StoreDetailsResponse storeDetailsResponse);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource{

  //run time cache

  Map<String,CacheItem> cacheMap= Map();

  @override
  Future<HomeResponse> getHomeData() async{
    CacheItem? cacheItem = cacheMap[cacheKey];

    if(cacheItem != null && cacheItem.isValid(cacheHomeInternalTime)) // return Response from cache
      {
         return cacheItem.data;
      }
    else //cache isn't valid or have no data
      {
       throw ErrorHandler.handle(DataSource.cacheError);
      }
  }

  @override
  Future<void> saveDataToCache(HomeResponse homeResponse) async {
    cacheMap[cacheKey] = CacheItem(homeResponse);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetailsData() {
    CacheItem? cacheItem = cacheMap[storeDetailsKey];

    if(cacheItem != null && cacheItem.isValid(cacheStoreInternalTime)) // return Response from cache
        {
      return cacheItem.data;
    }
    else //cache isn't valid or have no data
        {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDataToCache(StoreDetailsResponse storeDetailsResponse) async{
    cacheMap[storeDetailsKey] = CacheItem(storeDetailsResponse);
  }


  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CacheItem{
  dynamic data;

   int cachedTime = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}

extension CachedItemExtension on CacheItem{

  bool isValid(int expirationTime){
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTime - cachedTime <= expirationTime;
    return isValid;
  }

}