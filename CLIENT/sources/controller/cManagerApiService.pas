unit cManagerApiService;

interface

uses
  cItemUser, cConfig, System.Generics.Collections, cItemProduct, cItemCustomer,
  cItemWeighing, cTypes;

type
  TManagerApiService = class
    private

      class var FInstance : TManagerApiService;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      function ApiDoLogin(const pUser: TItemUser) : Boolean;
      function CheckApi(const pConnConfig : TRestClientConfig) : Boolean;
      function GetProducts(pProductList : TObjectList<TItemProduct>) : Boolean;
      function GetCustomers(pCustomerList : TObjectList<TItemCustomer>) : Boolean;
      function GetWeighings(pWeighingList : TObjectList<TItemWeighing>; const pSearchFilter : TSearchFilters) : Boolean;
      function PostWeighing(pWeighing : TItemWeighing) : TApiResponse;

      constructor Create(); overload;
      class function Instance : TManagerApiService;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, iApiClient, cRestClient;

{ TManagerApiService }

function TManagerApiService.ApiDoLogin(const pUser: TItemUser): Boolean;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.LogInUser(pUser).ResponseCode = 200;
end;

function TManagerApiService.CheckApi(const pConnConfig : TRestClientConfig): Boolean;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.CheckApi(pConnConfig).ResponseCode = 200;
end;

constructor TManagerApiService.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerApiService.CreateInstance;
begin
  inherited Create;
end;

destructor TManagerApiService.Destroy;
begin
  inherited;
end;

function TManagerApiService.GetCustomers(
  pCustomerList: TObjectList<TItemCustomer>): Boolean;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.GetCustomers(pCustomerList).ResponseCode = 200;
end;

function TManagerApiService.GetProducts(
  pProductList: TObjectList<TItemProduct>): Boolean;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.GetProducts(pProductList).ResponseCode = 200;
end;

function TManagerApiService.GetWeighings(
  pWeighingList: TObjectList<TItemWeighing>;
  const pSearchFilter: TSearchFilters): Boolean;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.GetWeighings(pWeighingList, pSearchFilter).ResponseCode = 200;
end;

class function TManagerApiService.Instance: TManagerApiService;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerApiService.CreateInstance;

  Result := FInstance;
end;

function TManagerApiService.PostWeighing(pWeighing: TItemWeighing): TApiResponse;
begin
  var client : IClientApi := TRestClientApi.Create;

  Result := client.PostWeighing(pWeighing);
end;

class procedure TManagerApiService.ReleaseInstance;
begin
  FInstance.Free;
end;

end.
