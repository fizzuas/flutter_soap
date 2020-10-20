class Api {
  /// 生成器
  static const baseUrl = 'https://www.kydz.online/WebServices/WxAppService.svc';
  static const baseImageUrl = 'http://www.autorke.cn/update/pic/';
  /// 钥匙机
  static const keyMachineHost = "http://114.215.147.2:9355/";
  static const keyMachineBaseUrl = 'http://114.215.147.2:9355/WebServices/WebService.svc/';
  static const ApkHost = "http://192.168.0.111/";

  /// Sign In
  static const getSmsCode = '/SendSmsCode';
  static const signUp = '/RegisterUser';
  static const modifyPassword = '/SetNewPassword';
  static const signIn = '/Login';

  /// Mall
  static const purchaseProductList = '/FindGoodsForPurchaseShop';
  static const purchaseList = '/CreatePurchasingList';

  /// 智能卡
  static const findPkeAllAreas = '/FindPkeAllAreas';
  static const findPkeAllBrandsAndRemotes  = '/FindPkeAllBrandsAndRemotes ';
  static const uploadGeneratorPoints  = '/UploadMiniBoxScoreDetailsList ';

  static const specialRemoteData = '/FindSpecialRemoteTypes';
  static const vw5cServiceCode = '/FindCsCode';
  static const submitFeedback = '/SaveFeedbackData';

  //升级功能
  //主控升级
  static const findLastBleMasterInfo = '/FindLastBleMasterInfo';
  //app升级
  static const findLastBleAppInfo="/FindLastBleAppInfo";
  //自定义钥匙功能模块
  static const findSeriesAxisStorateShareInfoList="/FindSeriesAxisStorateShareInfoList";
  //分享自定义钥匙
  static const uploadSeriesAxisStorateShareInfoList="/UploadSeriesAxisStorateShareInfoList";

}