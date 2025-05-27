<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SC_PendientesPesada_Back.aspx.cs" Inherits="SintecromNet.Paginas.SC_PendientesPesada_Back" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Guardar la Modificación?')) return false;
    }
</script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Pendientes de Pesada<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
<asp:GridView ID="gwPendientesPesada" runat="server" AutoGenerateColumns="False" 
        Width="900px" onrowdatabound="gwPendientesPesada_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Retraso" HeaderText="Retraso" 
                DataFormatString="{0:0.00}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Semana1" HeaderText="Semana 1" 
                DataFormatString="{0:0.00}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Semana2" DataFormatString="{0:0.00}" 
                HeaderText="Semana 2">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Semana3" DataFormatString="{0:0.00}" 
                HeaderText="Semana 3">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Semana4" DataFormatString="{0:0.00}" 
                HeaderText="Semana 4">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Total" DataFormatString="{0:0.00}" 
                HeaderText="Total">
            <ItemStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
                VerticalAlign="Middle" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Chart ID="Chart1" 
        runat="server" Width="900px" BackColor="Maroon" 
            BackGradientStyle="DiagonalRight" Palette="Pastel" Height="550px">
            <Series>
                <asp:Series ChartType="StackedBar" Name="Series1" 
                    Font="Microsoft Sans Serif, 8.25pt" YValuesPerPoint="4">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="StackedBar" Name="Series2">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="StackedBar" Name="Series3">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="StackedBar" Name="Series4">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="StackedBar" Name="Series5">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" ChartType="StackedBar" Name="Series6">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY IntervalAutoMode="VariableCount" MaximumAutoSize="100" Title="Toneladas" 
                        TitleFont="Microsoft Sans Serif, 9.75pt">
                    </AxisY>
                    <AxisX IntervalAutoMode="VariableCount" MaximumAutoSize="100" Title="Clientes" 
                        TitleFont="Microsoft Sans Serif, 9.75pt">
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Pendientes de Pesada">
                </asp:Title>
            </Titles>
        </asp:Chart>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
    &nbsp;<p>
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="120px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar" style="margin-left: 124px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
</asp:Content>

