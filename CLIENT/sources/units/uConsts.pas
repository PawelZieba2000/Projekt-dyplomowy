unit uConsts;

interface

const
  APP_NAME = 'Central weigher';

  EMPTY_STR = '';
  EMPTY_INT = 0;

  SCALE_WRONG_MASS = -999999999;
  SCALE_TIMER_SEND_INTERVAL = 300;
  SCALE_TIMER_TIME_OUT_INTERVAL = 1000;
  SCALE_STATUS_SEPARATOR = ';';
  SCALE_MIN_STABLE_TIME_SEC = 3;

  HTTP_OK = 200;

  API_END_POINT_LOGIN : String = '/login';
  API_END_POINT_GET_PRODUCTS : String = '/products';
  API_END_POINT_GET_CUSTOMERS : String = '/customers';
  API_END_POINT_GET_WEIGHINGS : String = '/weighings';
  API_END_POINT_SEND_WEIGHING : String = '/weighings';

implementation

end.
