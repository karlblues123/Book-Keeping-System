<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportSales2.aspx.cs" Inherits="Book_Keeping_System.ReportSales2" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        $(function calendarInput() {
            $('.calendarInput').datepicker({ maxDate: 30 });
        });

    </script>

    <div class="container-fluid">
        
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Selection Card --%>
                        <div class="card">
                            <%-- Selection Card Body --%>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="input-group input-group-sm">
                                            <span class="input-group-text"><span class="fa fa-calendar"></span>From:</span>
                                            <asp:TextBox runat="server" ID="txtDateFrom" placeholder="Select Date" CssClass="form-control calendarInput"></asp:TextBox>

                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="input-group input-group-sm">
                                            <span class="input-group-text"><span class="fa fa-calendar"></span>To:</span>
                                            <asp:TextBox runat="server" ID="txtDateTo" placeholder="Select Date" CssClass="form-control calendarInput"></asp:TextBox>

                                        </div>
                                    </div>
                                </div>

                                <%-- Dropdown --%>
                                <div class="input-group">
                                    <span class="input-group-text">Company</span>
                                    <asp:DropDownList runat="server" ID="ddDropdown" CssClass="form-control"></asp:DropDownList>
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
                                WIP
                                <%-- Crystal Report goes here --%>
                                <CR:CrystalReportViewer ID="CRV" runat="server" AutoDataBind="true" 
                                    PageZoomFactor="75"
                                    HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="False" DisplayToolbar="True" ToolPanelView="None" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
