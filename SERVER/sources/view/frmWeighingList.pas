unit frmWeighingList;

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
  Vcl.StdCtrls, cxButtons, dxLayoutControl, cItemWeighing;

type
  TFormWeighingList = class(TFormBaseList)
    clmnIdErp: TcxGridColumn;
    clmnWeighingNo: TcxGridColumn;
    clmnCarNo: TcxGridColumn;
    clmnTrailerNo: TcxGridColumn;
    clmnDateIn: TcxGridColumn;
    clmnMassIn: TcxGridColumn;
    clmnDateOut: TcxGridColumn;
    clmnMassOut: TcxGridColumn;
    clmnMassTare: TcxGridColumn;
    clmnMassNet: TcxGridColumn;
    clmnCustomerIdErp: TcxGridColumn;
    clmnCustomerCode: TcxGridColumn;
    clmnCustomerName: TcxGridColumn;
    clmnProductIdErp: TcxGridColumn;
    clmnProductCode: TcxGridColumn;
    clmnProductName: TcxGridColumn;
    clmnUserInName: TcxGridColumn;
    clmnUserInId: TcxGridColumn;
    clmnUserOutName: TcxGridColumn;
    clmnUserOutId: TcxGridColumn;
    clmnIsDeleted: TcxGridColumn;
    clmnModifDT: TcxGridColumn;
    procedure FormDestroy(Sender: TObject);
    procedure gGridListTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actOkExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    FWeighing: TItemWeighing;

    procedure SelectWeighing();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
    class function CreateAndSelectOne(AOwner : TComponent) : TItemWeighing;

    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; AWeighing: TItemWeighing); overload;
  end;

var
  FormWeighingList: TFormWeighingList;

implementation

uses
  cHelpFunctions, cManagerWeighings;

{$R *.dfm}

constructor TFormWeighingList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FWeighing := nil;
  Self.gGridListTableView1.DataController.CustomDataSource := TManagerWeighings.Instance.WeighingDS;
  gGridListTableView1.OptionsView.CellAutoHeight := False;
  actRefreshExecute(nil);
end;

procedure TFormWeighingList.actOkExecute(Sender: TObject);
begin
  if Assigned(Self.FWeighing) then
  begin
    Self.SelectWeighing;
    Self.ModalResult := mrOk;
  end;
end;

procedure TFormWeighingList.actRefreshExecute(Sender: TObject);
begin
  TManagerWeighings.Instance.GetWeighingsFromDb;
  Self.gGridListTableView1.DataController.CustomDataSource.DataChanged;
end;

constructor TFormWeighingList.Create(AOwner: TComponent;
  AWeighing: TItemWeighing);
begin
  Self.Create(AOwner);
  Self.FWeighing := AWeighing;
end;

class function TFormWeighingList.CreateAndSelectOne(
  AOwner: TComponent): TItemWeighing;
begin
  Result := nil;

  if Assigned(FormWeighingList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  Result := TItemWeighing.Create;
  FormWeighingList := TFormWeighingList.Create(AOwner, Result);
  try
    if FormWeighingList.ShowModal <> mrOk then
      FreeAndNil(Result);
  finally
    FreeAndNil(FormWeighingList);
  end;
end;

class function TFormWeighingList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormWeighingList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormWeighingList := TFormWeighingList.Create(AOwner);
  try
    Result := FormWeighingList.ShowModal;
  finally
    FreeAndNil(FormWeighingList);
  end;
end;

procedure TFormWeighingList.FormDestroy(Sender: TObject);
begin
  FormWeighingList := nil;
end;

procedure TFormWeighingList.gGridListTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if Assigned(Self.FWeighing) then
    Self.SelectWeighing;
end;

procedure TFormWeighingList.SelectWeighing;
begin
  if (not Assigned(Self.FWeighing))
     or (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var idErp : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnIdErp.Index];
  for var weighing : TItemWeighing in TManagerWeighings.Instance.WeighingList do
  begin
    if idErp <> weighing.IdErp then
      Continue;

    Self.FWeighing.AssignValues(weighing);
    Break;
  end;
end;

end.
