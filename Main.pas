unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    ProgressBar1: TProgressBar;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure decoder( const AName: String; const SExist: String );
type
  PByteArray = Array of Byte;
var
  ii: Integer;
begin
  with TMemoryStream.Create do
  try
    LoadFromFile( AName );
    if (UpperCase(ExtractFileName(AName)) <> 'I_STA.DBF') then
    begin
    for ii := 0 to Size - 1 do
       PByteArray( Memory )[ ii ] := PByteArray( Memory )[ ii ] xor 65 {p};
    end;
    createDir('decoded');
    SaveToFile( ChangeFileExt( 'decoded\'+AName, SExist ));

  finally
    Free;
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
var
  SR: TSearchRec;
  SR2: TSearchRec;
  SR3: TSearchRec;
begin
  Form1.ProgressBar1.Min := 1;
  Form1.ProgressBar1.Max := 75;
  Form1.ProgressBar1.Step := 1;
  Form1.ProgressBar1.StepBy(1);

  if FindFirst('*.dbf', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        decoder(SR.Name, '.dbf');
        Form1.ProgressBar1.StepIt;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;


  if FindFirst('*.cdx', faAnyFile, SR2) = 0 then
  begin
    repeat
      if (SR2.Attr <> faDirectory) then
      begin
        decoder(SR2.Name, '.cdx');
        Form1.ProgressBar1.StepIt;
      end;
    until FindNext(SR2) <> 0;
    FindClose(SR2);
  end;

  if FindFirst('*.fpt', faAnyFile, SR3) = 0 then
  begin
    repeat
      if (SR3.Attr <> faDirectory) then
      begin
        decoder(SR3.Name, '.fpt');
        Form1.ProgressBar1.StepIt;
      end;
    until FindNext(SR3) <> 0;
    FindClose(SR3);
  end;

  Form1.ProgressBar1.StepBy(75);
  ShowMessage('Decoded completed!');
end;


end.
