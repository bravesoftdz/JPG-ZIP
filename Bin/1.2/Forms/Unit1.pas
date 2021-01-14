unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ComCtrls, ExtCtrls, XPMan;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    ListBox2: TListBox;
    Button3: TButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    Button4: TButton;
    Button6: TButton;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
var
  i : Integer = 0;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.Options:=OpenDialog1.Options+[ofAllowMultiSelect];
  OpenDialog1.Filter := '图片文件(.jpg)|*.jpg';
  OpenDialog1.Title := '选择图片';
  if OpenDialog1.Execute then
    ListBox1.Items :=OpenDialog1.Files
  else
  Exit;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.Options:=OpenDialog1.Options+[ofAllowMultiSelect];
  OpenDialog1.Filter := '压缩文件(.rar;.zip)|*.rar;*.zip';
  OpenDialog1.Title := '选择压缩文件';
  if OpenDialog1.Execute then
    ListBox2.Items :=OpenDialog1.Files
  else
  Exit;
end;

procedure TForm1.Button3Click(Sender: TObject);


begin
  Self.ProgressBar1.Step := ListBox2.Count;
  Self.ProgressBar1.Max := ListBox2.Count;
  //ShowMessage(IntToStr(Self.ProgressBar1.Step));
  if (ListBox1.Count < 1)or(ListBox2.Count < 1) then
  begin
    MessageBox(Handle,PChar('您还未添加任务文件！'), '提示', MB_OK + MB_ICONASTERISK + MB_TOPMOST);
  end
  else
  begin
    Timer1.Enabled := True;
    ShellExecute(Handle,nil,'cmd.exe',pchar('/c copy /b "' + ListBox1.Items.Strings[0] + '" + "'
    + ListBox2.Items.Strings[i] + '" "' + ListBox2.Items.Strings[i] + '.jpg"&Echo.>> "'
    + ListBox2.Items.Strings[i] + '.log"'),nil,SW_HIDE);
  end;


  {begin
    for i := 0 to ListBox2.Items.Count - 1 do
    begin
      ShellExecute(Handle,nil,'cmd.exe',pchar('/c copy /b "' + ListBox1.Items.Strings[0] + '" + "' + ListBox2.Items.Strings[i] + '" "' + ListBox2.Items.Strings[i] + '.jpg"&Echo.>> "' + ListBox2.Items.Strings[i] + '.log"'),nil,SW_SHOW);
      //ShowMessage(ListBox2.Items.Strings[i] + '.txt');
      if FileExists(ListBox2.Items.Strings[i] + '.txt') then
      begin
        DeleteFile(ListBox2.Items.Strings[i] + '.txt');
        case MessageBox(Handle,PChar('合并' + ListBox2.Items.Strings[i] + '.jpg' + '完成！' + #13 + #13 + '已经有' + IntToStr(i + 1) + '个文件完成合并，点击确定继续合并，点击取消结束合并。'), '提示',
        MB_OKCANCEL + MB_ICONINFORMATION + MB_TOPMOST) of
        IDOK:
          begin
          //ShellExecute(Handle,nil,'cmd.exe',pchar('/c copy /b "' + ListBox1.Items.Strings[0] + '" + "' + ListBox2.Items.Strings[i] + '" "' + ListBox2.Items.Strings[i] + '.jpg"'),nil,SW_HIDE);
          end;
        IDCANCEL:
          begin
          Break;
          end;
        end;
      end
      else
      begin
      end;
    end;
  end;}
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

//ShowMessage(ListBox2.Items.Strings[i] + '.log');
  if FileExists(ListBox2.Items.Strings[i] + '.log') then
  begin
    DeleteFile(ListBox2.Items.Strings[i] + '.log');

    if i < ListBox2.Items.Count - 1 then
    begin
      i := i + 1;
      Self.ProgressBar1.Visible := True;
      Self.ProgressBar1.StepBy(1);
      //ShowMessage(ListBox2.Items.Strings[i] + '.log');
      Button3.Click;
    end
    else
    begin
      Timer1.Enabled := False;
      Self.ProgressBar1.Visible := True;
      Self.ProgressBar1.StepBy(1);
      MessageBox(Handle,PChar('任务成功完成，共合并' + IntToStr(i + 1) + '个文件。'), '提示', MB_OK + MB_ICONASTERISK + MB_TOPMOST);
      Self.ProgressBar1.Visible := False;
      Self.ProgressBar1.Position := 0;
    end;

  end
  else
  begin
  
  end;

{  begin

  for i := 1 to ListBox2.Items.Count - 1 do
    begin
      ShellExecute(Handle,nil,'cmd.exe',pchar('/c copy /b "' + ListBox1.Items.Strings[0] + '" + "' + ListBox2.Items.Strings[i] + '" "' + ListBox2.Items.Strings[i] + '.jpg"&Echo.>> "' + ListBox2.Items.Strings[i] + '.txt"'),nil,SW_SHOW);
      //ShowMessage(ListBox2.Items.Strings[i] + '.txt');
      if FileExists(ListBox2.Items.Strings[i] + '.txt') then
      begin
        //j := True;
        DeleteFile(ListBox2.Items.Strings[i] + '.txt');
        case MessageBox(Handle,PChar('合并' + ListBox2.Items.Strings[i] + '.jpg' + '完成！' + #13 + #13 + '已经有' + IntToStr(i + 1) + '个文件完成合并，点击确定继续合并，点击取消结束合并。'), '提示',
        MB_OKCANCEL + MB_ICONINFORMATION + MB_TOPMOST) of
        IDOK:
          begin
          //ShellExecute(Handle,nil,'cmd.exe',pchar('/c copy /b "' + ListBox1.Items.Strings[0] + '" + "' + ListBox2.Items.Strings[i] + '" "' + ListBox2.Items.Strings[i] + '.jpg"'),nil,SW_HIDE);
          end;
        IDCANCEL:
          begin
          Break;
          end;
        end;
      end
      else
      begin
      //j := False;
      end;

    end;
  end;}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  Self.StatusBar1.Panels[2].Text := DateTimeToStr(Now);
  Self.StatusBar1.Panels[2].Text := '作者微博：http://weibo.com/zhugecaomao';
  Self.StatusBar1.Panels[1].Text := '软件作者：诸葛草帽';
  Self.StatusBar1.Panels[0].Text := '合并进度...';
  Form1.AlphaBlend := True;

  ProgressBar1.Parent:= StatusBar1;
//  ProgressBar1.Left:= StatusBar1.Panels[0].Width  + StatusBar1.BorderWidth + 2;
  ProgressBar1.Left:= StatusBar1.BorderWidth + 2;
  ProgressBar1.Top:= StatusBar1.BorderWidth + 2;
  ProgressBar1.Height:= StatusBar1.Height - (StatusBar1.BorderWidth + 2);
  ProgressBar1.Width:= StatusBar1.Panels[0].Width + StatusBar1.BorderWidth - 2;
  ProgressBar1.Position:= 0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : Integer;

begin
//  Form1.AlphaBlend := True;
  for i:=0 to 51 do
  begin
    Self.AlphaBlendValue := 255 - 5*i;
    Sleep(15);
    if Self.AlphaBlendValue < 150 then
    Application.Terminate;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i : Integer;

begin
//  Form1.AlphaBlend := True;
  for i:=0 to 51 do
  begin
    Self.AlphaBlendValue := 255 - 5*i;
    Sleep(15);
    if Self.AlphaBlendValue < 150 then
    Application.Terminate;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'explorer.exe',pchar('http://zhugecaomao.jimdo.com'),nil,SW_Hide);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
case MessageBox(Handle, 
  '本软件能够批量的将JPG图片格式文件与RAR|ZIP格式压缩文件' + #13#10#13#10
  + '进行合并，合并之后的文件默认存放在压缩文件所在文件夹中，' + #13#10 +
  #13#10 + '合并之后的文件后缀格式改为JPG则为之前正常的图片，改为' + #13#10 +
  #13#10 + 'RAR|ZIP即为之前正常的压缩文件，这个软件用处很多，其中' + #13#10#13#10
  + '一点是可以比较好的隐藏个人文件，充分发挥你的想象力吧...' + #13#10#13#10 +
   '点击【确定】访问我的微博，点击【取消】返回软件界面' + #13#10 + #13#10 +
   '                【By 诸葛草帽 2013.7】', '软件说明：', MB_OKCANCEL +
  MB_ICONINFORMATION + MB_TOPMOST) of
  IDOK:
    begin
    ShellExecute(Handle,nil,'explorer.exe',pchar('http://weibo.com/zhugecaomao'),nil,SW_Hide);
    end;
  IDCANCEL:
    begin

    end;
end;
end;

procedure TForm1.StatusBar1Click(Sender: TObject);
begin
    ShellExecute(Handle,nil,'explorer.exe',pchar('http://weibo.com/zhugecaomao'),nil,SW_Hide);
end;

end.
