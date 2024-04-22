<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportSales2.aspx.cs" Inherits="Book_Keeping_System.ReportSales2" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<script type="text/javascript">

        //$(function calendarInput() {
        //    $('.calendarInput').datepicker({ maxDate: 30 });
        //});

    </script>--%>

    <div class="container-fluid">
        <div class="row mt-3 mx-1">
            <div class="col-4">
                <%-- Selection Card --%>
                <div class="card">
                    <%-- Selection Card Body --%>
                    <div class="card-body">
                        <div class="row my-2">
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtDateFrom" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtDateFrom.ClientID%>">From</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <asp:TextBox runat="server" ID="txtDateTo" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                    <label for="<%=txtDateTo.ClientID%>">To</label>
                                </div>
                            </div>
                        </div>

                        <%-- Dropdown --%>
                        <div class="form-floating my-2">
                            <asp:DropDownList runat="server" ID="ddCompany" CssClass="form-select"></asp:DropDownList>
                            <label for="<%=ddCompany.ClientID%>">Company</label>
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
                        <%-- Crystal Report goes here --%>
                        <CR:CrystalReportViewer ID="CRV" runat="server" AutoDataBind="true" 
                            PageZoomFactor="75"
                            HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="False" DisplayToolbar="True" ToolPanelView="None" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
