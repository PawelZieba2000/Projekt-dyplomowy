unit iApiClient;

interface

uses
  cItemUser, cItemWeighing, System.Generics.Collections, cItemProduct,
  cItemCustomer, cTypes, cConfig;

type
  IClientApi = interface
    ['{9B91E2FA-1DA0-4512-907B-C9E06B7B456D}']
      function LogInUser(const pUser : TItemUser) : TApiResponse;
      function GetProducts(pProductList : TObjectList<TItemProduct>) : TApiResponse;
      function GetCustomers(pCustomerList : TObjectList<TItemCustomer>) : TApiResponse;
      function GetWeighings(pWeighingList : TObjectList<TItemWeighing>; const pSearchFilter : TSearchFilters) : TApiResponse;
      function GetWeighingData(const pIdErpWeighing : Integer) : TApiResponse;
      function PostWeighing(pWeighing : TItemWeighing) : TApiResponse;
      function CheckApi(const pConnConfig : TRestClientConfig) : TApiResponse;
  end;

implementation

end.
