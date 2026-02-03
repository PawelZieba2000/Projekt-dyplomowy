unit frmCustomerList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData,
  dxLayoutControlAdapters, dxLayoutContainer, cxTextEdit, System.Actions,
  Vcl.ActnList, dxBar, cxBarEditItem, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxButtons, dxLayoutControl, cItemCustomer;

type
  TFormCustomerList = class(TFormBaseList)
    clmnIdErp: TcxGridColumn;
    clmnCustomerCode: TcxGridColumn;
    clmnCustomerName: TcxGridColumn;
    clmnCustomerNIP: TcxGridColumn;
    clmnAddressStreet: TcxGridColumn;
    clmnAddressHouseNo: TcxGridColumn;
    clmnAddressLocalNo: TcxGridColumn;
    clmnAddressPostCode: TcxGridColumn;
    clmnAddressCity: TcxGridColumn;
    clmnCustomerPhoneNo: TcxGridColumn;
    clmnCustomerLocationId: TcxGridColumn;
    clmnCustomerModifDT: TcxGridColumn;
    procedure FormDestroy(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure gGridListTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    FCustomer: TItemCustomer;

    procedure SelectCustomer();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
    class function CreateAndSelectOne(AOwner : TComponent) : TItemCustomer;

    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; ACustomer: TItemCustomer); overload;
  end;

var
  FormCustomerList: TFormCustomerList;

implementation

uses
  cHelpFunctions, cManagerCustomers;

{$R *.dfm}

constructor TFormCustomerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FCustomer := nil;
  Self.gGridListTableView1.DataController.CustomDataSource := TManagerCustomers.Instance.CustomersDS;
end;

procedure TFormCustomerList.actOkExecute(Sender: TObject);
begin
  if Assigned(Self.FCustomer) then
  begin
    Self.SelectCustomer;
    Self.ModalResult := mrOk;
  end;
end;

constructor TFormCustomerList.Create(AOwner: TComponent;
  ACustomer: TItemCustomer);
begin
  Self.Create(AOwner);
  Self.FCustomer := ACustomer;
end;

class function TFormCustomerList.CreateAndSelectOne(
  AOwner: TComponent): TItemCustomer;
begin
  Result := nil;

  if Assigned(FormCustomerList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  Result := TItemCustomer.Create;
  FormCustomerList := TFormCustomerList.Create(AOwner, Result);
  try
    if FormCustomerList.ShowModal <> mrOk then
      FreeAndNil(Result);
  finally
    FreeAndNil(FormCustomerList);
  end;
end;

class function TFormCustomerList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormCustomerList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormCustomerList := TFormCustomerList.Create(AOwner);
  try
    Result := FormCustomerList.ShowModal;
  finally
    FreeAndNil(FormCustomerList);
  end;
end;

procedure TFormCustomerList.FormDestroy(Sender: TObject);
begin
  FormCustomerList := nil;
end;

procedure TFormCustomerList.gGridListTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if Assigned(Self.FCustomer) then
    Self.SelectCustomer;
end;

procedure TFormCustomerList.SelectCustomer;
begin
  if (not Assigned(Self.FCustomer))
     or (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var idErp : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnIdErp.Index];
  for var customer in TManagerCustomers.Instance.CustomerList do
  begin
    if idErp <> customer.IdErp then
      Continue;

    Self.FCustomer.AssignValues(customer);
    Break;
  end;
end;

end.
