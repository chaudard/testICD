unit UnitGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB
  , ICDsearcher
  ;

type
  TApplicationGUIForm = class(TForm)
    lbCriteria: TLabel;
    edCriteria: TEdit;
    btSearch: TButton;
    cbLng: TComboBox;
    lbResults: TLabel;
    memoResults: TMemo;
    ADOQuery1: TADOQuery;
    lbNResults: TLabel;
    edNResults: TEdit;
    lbxResults: TListBox;
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxResultsClick(Sender: TObject);
  private
    { Déclarations privées }
    FSearcher: TICDSearcher;
  public
    { Déclarations publiques }
  end;

var
  ApplicationGUIForm: TApplicationGUIForm;

implementation

uses
  ICDrecord;

{$R *.dfm}

procedure TApplicationGUIForm.btSearchClick(Sender: TObject);
var
  vnRecords: integer;
  vCriteria: string;
  vCode: string;
  vLng: string;
  vRec: TICDRecord;
begin
  //lbxResults.Clear;
  lbxResults.Items.Clear;
  if cbLng.ItemIndex = 0 then
  begin
    vLng := 'FR_DESCRIPTION';
  end
  else
  begin
    vLng := 'NL_DESCRIPTION';
  end;
  vnRecords := strtoint(edNResults.Text);
  vCriteria := edCriteria.Text;

  FSearcher.criteria := vCriteria;
  FSearcher.lng := vLng;
  FSearcher.top := vnRecords;

  FSearcher.ComputeResult;
  for vRec in FSearcher.results do
  begin
    lbxResults.AddItem(vRec.codeICD10, vRec);
  end;
end;

procedure TApplicationGUIForm.FormCreate(Sender: TObject);
begin
  FSearcher := TICDSearcher.Create(ADOQuery1, 'choléra', 'FR_DESCRIPTION', 10);
end;

procedure TApplicationGUIForm.FormDestroy(Sender: TObject);
begin
  FSearcher.Free;
end;

procedure TApplicationGUIForm.lbxResultsClick(Sender: TObject);
begin
  showmessage(FSearcher.results.Items[lbxResults.ItemIndex].codeICD10);
end;

end.
