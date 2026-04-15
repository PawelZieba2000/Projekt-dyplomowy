unit frmProtocolsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, dxLayoutControlAdapters,
  dxLayoutContainer, cxTextEdit, System.Actions, Vcl.ActnList, dxBar,
  cxBarEditItem, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGrid, Vcl.StdCtrls, cxButtons,
  dxLayoutControl, cItemTranssProtocol;

type
  TFormProtocolsList = class(TFormBaseList)
    clmnId: TcxGridColumn;
    clmnName: TcxGridColumn;
    clmnMsgToDevice: TcxGridColumn;
    clmnFrameBegin: TcxGridColumn;
    clmnFrameEnd: TcxGridColumn;
    actAdd: TAction;
    actEdit: TAction;
    actRemove: TAction;
    btnAddNew: TdxBarLargeButton;
    btnEdit: TdxBarLargeButton;
    btnRemove: TdxBarLargeButton;
    procedure FormDestroy(Sender: TObject);
    procedure gGridListTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actOkExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    FProtocol: TItemTranssProtocol;

    procedure SelectProtocol();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
    class function CreateAndSelectOne(AOwner : TComponent) : TItemTranssProtocol;

    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; AProtocol: TItemTranssProtocol); overload;
  end;

var
  FormProtocolsList: TFormProtocolsList;

implementation

uses
  cManagerConfig, cHelpFunctions, frmTranssProtocolAddEdit, cTypes,
  frmAppMessage;

{$R *.dfm}

{ TFormProtocolsList }

constructor TFormProtocolsList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FProtocol := nil;
  Self.gGridListTableView1.DataController.CustomDataSource := TManagerConfig.Instance.TranssProtocolDS;
  actRefreshExecute(nil);
end;

procedure TFormProtocolsList.actAddExecute(Sender: TObject);
begin
  var tmpProtocol : TItemTranssProtocol := TItemTranssProtocol.Create();

  if TFormTranssProtocolAddEdit.CreateAndShowModal(nil, tmpProtocol, fetAddNew) = mrOk then
  begin
    tmpProtocol.Id := TManagerConfig.Instance.TranssProtocolList.Count;
    TManagerConfig.Instance.TranssProtocolList.Add(tmpProtocol);
  end else
    tmpProtocol.Free;

  actRefreshExecute(nil);
end;

procedure TFormProtocolsList.actEditExecute(Sender: TObject);
begin
  if (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  for var protocol : TItemTranssProtocol in TManagerConfig.Instance.TranssProtocolList do
  begin
    if tmpID <> protocol.Id then
      Continue;

    TFormTranssProtocolAddEdit.CreateAndShowModal(nil, protocol, fetEdit);
    Break;
  end;
end;

procedure TFormProtocolsList.actOkExecute(Sender: TObject);
begin
  if Assigned(Self.FProtocol) then
  begin
    Self.SelectProtocol;
    Self.ModalResult := mrOk;
  end;
end;

procedure TFormProtocolsList.actRefreshExecute(Sender: TObject);
begin
  Self.gGridListTableView1.DataController.CustomDataSource.DataChanged;
end;

procedure TFormProtocolsList.actRemoveExecute(Sender: TObject);
begin
  if (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  for var I : Integer := 0 to TManagerConfig.Instance.TranssProtocolList.Count - 1 do
  begin
    if tmpID <> TManagerConfig.Instance.TranssProtocolList.Items[I].Id then
      Continue;

    if not TFormAppMessage.ShowQusetion('Czy na pewno chcesz usun¹æ protokó³ ' + TManagerConfig.Instance.TranssProtocolList.Items[I].Name + '?') then
      Exit;

    TManagerConfig.Instance.TranssProtocolList.Delete(I);
    Break;
  end;

  actRefreshExecute(nil);
end;

constructor TFormProtocolsList.Create(AOwner: TComponent;
  AProtocol: TItemTranssProtocol);
begin
  Self.Create(AOwner);
  Self.FProtocol := AProtocol;
end;

class function TFormProtocolsList.CreateAndSelectOne(
  AOwner: TComponent): TItemTranssProtocol;
begin
  Result := nil;

  if Assigned(FormProtocolsList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  Result := TItemTranssProtocol.Create;
  FormProtocolsList := TFormProtocolsList.Create(AOwner, Result);
  try
    if FormProtocolsList.ShowModal <> mrOk then
      FreeAndNil(Result);
  finally
    FreeAndNil(FormProtocolsList);
  end;
end;

class function TFormProtocolsList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormProtocolsList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormProtocolsList := TFormProtocolsList.Create(AOwner);
  try
    Result := FormProtocolsList.ShowModal;
  finally
    FreeAndNil(FormProtocolsList);
  end;
end;

procedure TFormProtocolsList.FormDestroy(Sender: TObject);
begin
  FormProtocolsList := nil;
end;

procedure TFormProtocolsList.gGridListTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
   if Assigned(Self.FProtocol) then
    Self.SelectProtocol;
end;

procedure TFormProtocolsList.SelectProtocol;
begin
  if (not Assigned(Self.FProtocol))
     or (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  for var protocol : TItemTranssProtocol in TManagerConfig.Instance.TranssProtocolList do
  begin
    if tmpID <> protocol.Id then
      Continue;

    Self.FProtocol.AssignValues(protocol);
    Break;
  end;
end;

end.
