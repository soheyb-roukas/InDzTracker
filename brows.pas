unit brows;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Advertising;

type
  TForm2 = class(TForm)
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    WebBrowser1: TWebBrowser;
    SpeedButton2: TSpeedButton;
    Layout1: TLayout;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ScaledLayout1: TScaledLayout;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure WebBrowser1DidFailLoadWithError(ASender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses pktu1;

procedure TForm2.Button1Click(Sender: TObject);
begin
webbrowser1.Navigate('https://track.aftership.com/?tracking-numbers='+form1.ComboEdit1.Text)
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
webbrowser1.Navigate('https://global.cainiao.com/detail.htm?mailNoList='+form1.ComboEdit1.Text)
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
webbrowser1.Navigate('https://www.1tracking.net/en/detail?nums='+form1.ComboEdit1.Text)
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
hide;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
webbrowser1.GoBack;
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
webbrowser1.GoForward;
end;

procedure TForm2.WebBrowser1DidFailLoadWithError(ASender: TObject);
begin
webbrowser1.LoadFromStrings('Cant connect :(','Home') ;
end;

end.
