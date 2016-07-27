<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Presentacion.Login" %>

<!DOCTYPE html>

<html>
    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>For-BX .net</title>
    <link rel="stylesheet" type="text/css" href="StyleForm.css" />
        <style type="text/css">
            .auto-style1 {
                width: 100%;
            }
            .auto-style2 {
                width: 314px;
                height: 868px;
            }
            .auto-style3 {
                height: 313px;
                width: 226px;
            }
            .auto-style4 {
                width: 46px;
                height: 47px;
                display: block;
                position: absolute;
                left: 1px;
                z-index: -1;
                -moz-border-radius-topleft: 5px;
                -moz-border-radius-bottomleft: 5px;
                -webkit-border-top-left-radius: 5px;
                -webkit-border-bottom-left-radius: 5px;
                top: 473px;
                transition: all 0.5s ease;
                -moz-transition: all 0.5s ease;
                -webkit-transition: all 0.5s ease;
                -o-transition: all 0.5s ease;
                -ms-transition: all 0.5s ease;
                padding-right: 2px;
            }
            .auto-style5 {
                width: 46px;
                height: 36px;
                display: block;
                position: absolute;
                left: 4px;
                z-index: -1;
                -moz-border-radius-topleft: 5px;
                -moz-border-radius-bottomleft: 5px;
                -webkit-border-top-left-radius: 5px;
                -webkit-border-bottom-left-radius: 5px;
                top: 555px;
                transition: all 0.5s ease;
                -moz-transition: all 0.5s ease;
                -webkit-transition: all 0.5s ease;
                -o-transition: all 0.5s ease;
                -ms-transition: all 0.5s ease;
                padding-right: 2px;
            }
        </style>
    </head>
	<body>
        <div id="wrapper" class="auto-style2">
            <form id="Login" method="post" runat="server" class="login-form">
                <div class="header">
                    <div>

                        <table class="auto-style1">
                            <tr>
                                <td>
                                    <img src="images/RosetaInicio.png" style="text-align: center;" class="auto-style3" /></td>
                            </tr>
                        </table>

                    </div>
                    <span>
                    <br />
                        <center> 
                            <asp:Label ID="Label1" runat="server" Text="Para ingresar por favor digita las credenciales de red que habitualmente usas." Font-Names="Century Gothic" Font-Size="X-Small"></asp:Label>
                    
                            </center>
                    </span>
                </div>
                <div class="content">
                    <asp:TextBox ID="txtUsername" Runat="server" class="input username" placeholder="Usuario" Width="237px" Font-Names="Century Gothic"></asp:TextBox><br>
                    <div class="auto-style4"></div>
                    <asp:TextBox ID="txtPassword" Runat="server" TextMode="Password" class="input password" placeholder="Contraseña" Width="237px" Font-Names="Century Gothic"></asp:TextBox><br>
                    <div class="auto-style5"></div>
                </div>
                <div class="footer">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnLogin" Runat="server" Text="Login" OnClick="Login_Click" class="button" Font-Names="Century Gothic"></asp:Button>
                    <br /><br>
                <asp:CheckBox ID="CheckBox1" Runat="server" Text="Recordarme" style="color: #9D9E9E; font-size: x-small; font-weight: 400; font-family: 'Century Gothic" Font-Names="Century Gothic"></asp:CheckBox><br>
                    <br />
                <asp:Label ID="errorLabel" Runat="server" ForeColor="#FF3300" style="font-size: x-small; font-weight: 400; font-family: 'Century Gothic" Font-Names="Century Gothic"></asp:Label><br>
                </div>
        </form>
        </div>        
        <div class="gradient"></div>
	</body>
</html>

<script runat="server">
    Sub Login_Click(sender As Object, e As EventArgs)
        Dim adPath As String = "LDAP://DC=BANCOLDEX,DC=com"
        Dim adAuth As LdapAuthentication = New LdapAuthentication(adPath)
        Dim Domain As String = "BANCOLDEX"
        Try
            If (True = adAuth.IsAuthenticated(Domain, txtUsername.Text, txtPassword.Text)) Then
                Dim groups As String = adAuth.GetGroups()

                Dim isCookiePersistent As Boolean = CheckBox1.Checked
                Dim authTicket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, _
                     txtUsername.Text, DateTime.Now, DateTime.Now.AddMinutes(60), isCookiePersistent, groups)
	
                Dim encryptedTicket As String = FormsAuthentication.Encrypt(authTicket)
		
                Dim authCookie As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)

                If (isCookiePersistent = True) Then
                    authCookie.Expires = authTicket.Expiration
                End If

                Response.Cookies.Add(authCookie)

                Response.Redirect(FormsAuthentication.GetRedirectUrl(txtUsername.Text, False))
    
            Else
                errorLabel.Text = "Por favor verifica que el usuario y la contraseña sean correctos."
            End If
 
        Catch ex As Exception
            errorLabel.Text = "Error de autenticacion. "
        End Try
    End Sub
</script>

