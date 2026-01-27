unit iRestClientService;

interface

uses
  cItemUser, cItemWeighing;

type
  TApiResponse = record
    ResponseCode : Integer;
    ErrMsg : String;
  end;

  IRestClientApi = interface
    ['{9B91E2FA-1DA0-4512-907B-C9E06B7B456D}']
      function LogInUser(const pUser : TItemUser) : TApiResponse;
      function GetProducts() : TApiResponse;
      function GetCustomers() : TApiResponse;
      function GetWeighings() : TApiResponse;
      function GetWeighingData(const pIdErpWeighing : Integer) : TApiResponse;
      function PostWeighing(const pWeighing : TItemWeighing) : TApiResponse;
  end;

implementation

end.
