unit eBayConfig;

interface

uses ERPDBComponents, sysutils;

(*var
  conn : TERPConnection;*)

const
(*  Conn_UserName = 'P_One';
  Conn_Password = '1w$p&LD07';
  Conn_Server = 'Localhost';
  Conn_Port = 3309;         *)
  Conn_Databse = 'Aus_Sample_Company';
  ebayUserTocken        = 'AgAAAA**AQAAAA**aAAAAA**3p/HUQ**nY+sHZ2PrBmdj6wVnY+s'+
        'EZ2PrA2dj6wFlIahAZCKog6dj6x9nY+seQ**i+EBAA**AAMAAA**OJCHRVzUDDPoFLMZR/c'+
        'fFyfs/UIE+5cDjhyfkDFBQnSh2EyAIEhMu4A+uGwEgftcBD1jmqwqkEtqrW0GPHenv5svZz'+
        'GcBkXrYUElwhEc3jV9XDYKeRfgMmuTgDhtfDmvRk8m73Ihsa/F8zdhiyb7uplFUti08y6YN'+
        'dF4MWUJ4vH7MSe7vqjBKRgXXZDWEjxgF4icUcqm+QAzq6+lSDEsPYR39higzsnuRK5n9k0V'+
        'wkBuYMU2LGVj4v88Dqp/4vgqwg5/uPO4981bw9/kEcJUwVmMKtXEnOSInZaAGTV5NtQRsaG'+
        'IFymxUx9cMG7Ks4t8Uv9W9KtLPiiF9b29vM04IKRDkl9ToEvBXXv0PkIByplh3b3oc//bfQ'+
        'sEZKye9/UgPDJj71q8qdKoBSlFKGZQ+ibeE4lLzZHFyji+TH26quqS9wYnH7x74KKYBNAB2'+
        'b718OHVDUSZ4FBQj15Q1/7XWeUJ24ulsAmvbrtbsxVc3EuS1APDyrzSsfxYtKuxhpq2oGR6'+
        'oYthyONo8OW72IYFC6zuvSig7hB3p0SWWcLQnyBqXUlfDDev8Ejz1JlTpij4R6xbkf0osqH'+
        'm8Yd/E+xL18fXI6B3wkZ5b5d1CqnQT6mTApvPYxB2rk3QaQ2ucyGw7baDSI/1KYu60JH76K'+
        'M3dx0x0ADFrGvTip8z62zRZpLsr/mXyZsgpXoEvWHxXF7WwjDGa5k5Gn+gp842Lh/g3JV6Z'+
        'PiTsNN2zc9r5ukg/CIyLTpF1mTCr5/iJ9L7LCNM';
  ebayTeclatocken = 'AgAAAA**AQAAAA**aAAAAA**+ps2XA**nY+sHZ2PrBmdj6wVnY+sEZ2Pr'+
        'A2dj6ABloKoDpOBpwudj6x9nY+seQ**jcMFAA**AAMAAA**t1L85qrgYmQvzy5KtXuYUgLK'+
        'XHrNWOq2qwEo1ngk9EERv/NIy6TqJ5b9+0eXj/p9vmZXrzQk1NhM5yZqNQdpzJtjnoTmTpI'+
        't7Vt+bf49aA/Bm0xR86uG9yvYXJshOgH2ajqfSQZ9IPyT7K3eMrhP+4t88fTdKX57wxET5z'+
        '1G7EEj3uibZVNZNG1cbsa7sbOPZCpzqumtvXor6EKS0N5RtB3r8SloZht6O6BzYgGTcfqMT'+
        'ldDNOOGF6eyBNiXbhZH7tsotilPQTtr9533cYi2WR4VZSbEpoI1Zey5eAv0VvncSBfuooHg'+
        'PnX6AhrDIJPbWxjrcJeY/MpX9LRYD3ktw3l1pXfEGQaRX9IqnAbfhwAVotzHIJ4x/s5dK0B'+
        'Fo7rXI7/UBuyr4LnbWgTuZMwdBddtlsHCYyhZV8brLVbCpMpJg5PpCT+HHjX+MLzACoB6TT'+
        'E4oymO1hm6X9gquD4m/AOAktFFbaUj6AyypbFIHTZ/MlbOH1YSrD9jTk5/AfP/jp3pSts+F'+
        'Zzi6LkM7VqDg6AYhSlU3urPzIIDn/Pb9y+Oe/M5nz1xUlw9NyRQas/zHEHuNPZep1Gn+2FQ'+
        '1HCLi0wUWdjS+IBIF6W+xtY05pbd0eapebGLHGqe36JVx0g3bjfmrFRaDKs1jnQ10TeqPuL'+
        'oNWefqEhbjTiAdDGF1LkeUNpikDTxLzkBolPk1CjsTr8S3sEZadKBOppnOyuznBxJ4QQhIs'+
        'nZ0R6YL200N9YsiLcmKjHW6mLoNzd3LMZo';
   (*ebayAppId    = 'BinnyJac-9053-4f2c-ac9e-3b6bbdd420f2';
   ebayDevId    = 'cedf2e3d-6072-4283-a81c-dd6b5bc61efd';
   ebayCertId   = 'ad9f224e-7ee9-43b0-9c57-ba881a0a34b0';*)
   ebayAppId    = 'TrueERPS-TrueERP-SBX-f60b9b3c7-fb24695b';
   ebayDevId    = 'a19ba6c4-ccce-4682-9bc8-bc653dc011f0';
   ebayCertId   = 'SBX-60b9b3c72cbb-2b63-4d12-a059-8698';



   ebayReqVersion = '1145';
   ebaySiteID ='15';



implementation

initialization
(*  Conn :=TERPConnection.Create(nil);
  conn.Username := Conn_UserName;
  conn.Password := Conn_Password;
  Conn.Server := Conn_Server;
  Conn.Port := conn_port;
  conn.Database := Conn_Databse;
  Conn.Connect;*)

finalization
(*  Freeandnil(Conn);*)
end.

