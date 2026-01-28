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
  Vcl.StdCtrls, cxButtons, dxLayoutControl;

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
  private
    { Private declarations }
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;

    constructor Create(AOwner: TComponent); override;
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

  Self.gGridListTableView1.DataController.CustomDataSource := TManagerCustomers.Instance.CustomersDS;
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

end.
