unit UnitGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB
  , ICDsearcher
  , ICDtranslator
  ;

type
  TApplicationGUIForm = class(TForm)
    lbCriteria: TLabel;
    edCriteria: TEdit;
    btSearch: TButton;
    cbLng: TComboBox;
    lbResults: TLabel;
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
    function getLngChoosen: TICDlng;
    procedure fillComboLng;
  public
    { Déclarations publiques }
  end;

var
  ApplicationGUIForm: TApplicationGUIForm;

implementation

uses
  ICDrecord,
  TypInfo;

{$R *.dfm}

procedure TApplicationGUIForm.btSearchClick(Sender: TObject);
var
  vnRecords: integer;
  vCriteria: string;
  vCode: string;
  vLng: TICDlng;
  vRec: TICDRecord;
begin
  lbxResults.Items.Clear;
  vLng := getLngChoosen;
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

procedure TApplicationGUIForm.fillComboLng;
var
  iLng: integer;
begin
  cbLng.Items.Clear;
  for iLng := ord(Low(TICDlng)) to ord(high(TICDlng)) do
    cbLng.items.Add(TICDtranslator.GUItranslate(TICDlng(iLng)));
  cbLng.ItemIndex := 0;
end;

procedure TApplicationGUIForm.FormCreate(Sender: TObject);
begin
  edCriteria.Text := 'choléra'; // initialize to test
  fillComboLng;
  FSearcher := TICDSearcher.Create('', lng_fr, 10);
end;

procedure TApplicationGUIForm.FormDestroy(Sender: TObject);
begin
  FSearcher.Free;
end;

function TApplicationGUIForm.getLngChoosen: TICDlng;
begin
  result := TICDlng(cbLng.ItemIndex);
end;

procedure TApplicationGUIForm.lbxResultsClick(Sender: TObject);
var
  vcode: string;
  vDescription: string;
  vLng: TICDlng;
  vmes: string;
begin
  vcode := FSearcher.results.Items[lbxResults.ItemIndex].codeICD10;
  vLng := getLngChoosen;
  if vLng = lng_fr then
    vDescription := FSearcher.results.Items[lbxResults.ItemIndex].frDescription
  else
    vDescription := FSearcher.results.Items[lbxResults.ItemIndex].nlDescription;
  vmes := format('code %s = %s',[vcode, vDescription]);
  showmessage(vmes);
end;

end.
