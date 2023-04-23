// 本地测试URL
const baseURL = "http://localhost:8080";
// const baseURL = "http://192.168.1.2:8080";

const String clothesImageURL = '/get_clothes_image';

const String suitImageURL = '/get_suit_image';

const String userIdParam = 'userId';

const String clothesIdParam = 'clothesId';

const String suitIdParam = "suitId";

String getClothesImageURL(int clothesId, int userId) {
  return '$baseURL$clothesImageURL'
      '?$userIdParam=$userId'
      '&$clothesIdParam=$clothesId';
}

String getSuitImageURL(int suitId, int userId) {
  return '$baseURL$suitImageURL'
      '?$userIdParam=$userId'
      '&$suitIdParam=$suitId';
}

// 需要当前ipv4地址
