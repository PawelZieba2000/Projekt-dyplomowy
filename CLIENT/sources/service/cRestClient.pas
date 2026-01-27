unit cRestClient;

interface

uses
  cItemUser, cItemWeighing, System.Generics.Collections, cItemProduct,
  cItemCustomer, cTypes, iApiClient;

type
  TRestClientApi = class(TInterfacedObject, IClientApi)
    private
    public
      function LogInUser(const pUser : TItemUser) : TApiResponse;
      function GetProducts(pProductList : TObjectList<TItemProduct>) : TApiResponse;
      function GetCustomers(pCustomerList : TObjectList<TItemCustomer>) : TApiResponse;
      function GetWeighings(pWeighingList : TObjectList<TItemWeighing>; const pSearchFilter : TWeihgingSearchFilters) : TApiResponse;
      function GetWeighingData(const pIdErpWeighing : Integer) : TApiResponse;
      function PostWeighing(const pWeighing : TItemWeighing) : TApiResponse;
  end;

implementation

{ TRestClientApi }

function TRestClientApi.GetCustomers(
  pCustomerList: TObjectList<TItemCustomer>): TApiResponse;
begin

end;

function TRestClientApi.GetProducts(
  pProductList: TObjectList<TItemProduct>): TApiResponse;
begin

end;

function TRestClientApi.GetWeighingData(
  const pIdErpWeighing: Integer): TApiResponse;
begin

end;

function TRestClientApi.GetWeighings(pWeighingList: TObjectList<TItemWeighing>;
  const pSearchFilter: TWeihgingSearchFilters): TApiResponse;
begin

end;

function TRestClientApi.LogInUser(const pUser: TItemUser): TApiResponse;
begin

end;

function TRestClientApi.PostWeighing(
  const pWeighing: TItemWeighing): TApiResponse;
begin

end;

end.
