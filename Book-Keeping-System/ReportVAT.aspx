<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportVAT.aspx.cs" Inherits="Book_Keeping_System.VATReport" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <h6 class="m-2">VAT Report</h6>
        <div class="row">
            <div class="col-4">
                <div class="card">
                    <div class="card-body">
                        <div class="row my-2">
                            <div class="col-6">
                                <div class="form-floating">
                                    <%-- From Date --%>
                                    <asp:TextBox runat="server" ID="txtFromDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtFromDate.ClientID%>">From</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <%-- To Date --%>
                                    <asp:TextBox runat="server" ID="txtToDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtToDate.ClientID %>">To</label>
                                </div>
                            </div>
                        </div>
                        <%-- Dropdown --%>
                        <div class="form-floating my-2">
                            <asp:DropDownList runat="server" ID="ddCompany" CssClass="form-select"></asp:DropDownList>
                            <label for="<%=ddCompany.ClientID%>">Company</label>
                        </div>
                        <div class="row my-2">
                            <div class="col">
                                <asp:RadioButtonList runat="server" ID="rbReportType" CssClass="form-check form-check-inline d-flex justify-content-lg-around" 
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="Purchase" Text="Purchase" class="mx-5"></asp:ListItem>
                                    <asp:ListItem Value="Utility" Text="Utility" class="mx-5"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>      
                    </div>
                    <%-- Selection Card Footer --%>
                    <div class="card-footer">
                        <%-- Select Button --%>
                        <asp:LinkButton runat="server" ID="lnkSelect" CssClass="btn btn-success" OnClick="lnkSelect_Click">Select</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <%-- Output Card --%>
                <div class="card">
                    <%-- Output Card Body --%>
                    <div class="card-body">
                        <asp:Label runat="server" ID="lblNoReport" CssClass="my-2"><p class="text-center">Select the parameters to display a report</p></asp:Label>
                        <CR:CrystalReportViewer ID="CRV" runat="server" AutoDataBind="true" 
                            PageZoomFactor="75"
                            HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="False" DisplayToolbar="True" ToolPanelView="None" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
