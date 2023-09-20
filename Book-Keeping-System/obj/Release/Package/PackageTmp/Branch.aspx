<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="Book_Keeping_System.Branch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <script type="text/javascript">
       
        //Search function
        $(function searchInput() {
            $('[id*=txtSearch]').on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvBranchList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });


        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {


                    //Search function
                    $(function searchInput() {
                        $('[id*=txtSearch]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvBranchList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        };

    </script>

    <div class="container-fluid">
<asp:Panel runat="server" ID="panelBranchLists">
        <%-- Branch List Panel 
        <asp:UpdatePanel runat="server" ID="upBranchList">
          
            <ContentTemplate>--%>
                <div class="card m-2">
                    <%-- Header --%>
                    <div class="card-header bg-warning bg-opacity-25">
                       <b class="fa fa-building text-info"></b>  <b>Branches Information</b>
                    </div>
                    <%-- Body --%>
                    <div class="card-body">
                        <%-- Branch List Card --%>
                        <div class="card">
                            <%-- Header --%>
                            <div class="card-header">
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtSearch" placeholder="Search" 
                                        AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                    <div class="btn-group">
                                        <asp:LinkButton runat="server" ID="lnkCreate" CssClass="btn btn-outline-success"><b class="fa fa-plus-circle"></b> New</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <%-- Body --%>
                            <div class="card-body">
                                <asp:Panel runat="server" ID="panelGridViewLists" Height="600px" ScrollBars="Vertical">
                                <%-- Branch GridView --%>
                                <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                    <Columns>
                                       <%-- <asp:BoundField DataField="BranchAddress" HeaderText="Address" />
                                       
                                        <asp:BoundField DataField="BranchStatus" HeaderText="Status" />--%>
                                        <asp:BoundField DataField="BranchID" />
                                        <asp:BoundField DataField="BranchCode" />
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                       <%-- <asp:BoundField DataField="Supervisor" HeaderText="Supervisor" />--%>
                                        <asp:BoundField DataField="Company_Name"  HeaderText="Company"/>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm" OnClick="lnkEdit_Click"><b class="fa fa-pencil"></b> Edit</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                    </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
           <%-- </ContentTemplate>
        </asp:UpdatePanel>--%>
</asp:Panel>

        <%-- Branch Data Panel --%>
        <asp:Panel runat="server" ID="panelBranchInputForm" Visible="false">
                     
        <asp:UpdatePanel runat="server" ID="upBranchData">
           
            <ContentTemplate>
                <div class="card m-2">
                    <%-- Header --%>
                    <div class="card-header">
                        <asp:Label runat="server" ID="lblBranchName"></asp:Label>
                    </div>
                    <%-- Body --%>
                    <div class="card-body">
                            <div class="card">
                                <div class="card-body">
                                   <%-- Branch Name --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">
                                            <object type="image/svg+xml" data="css/feather/edit-2.svg"></object>
                                        </span>
                                        <asp:TextBox runat="server" ID="txtBranchName" CssClass="form-control" 
                                            AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                                    </div>
                                    <%-- Branch Address --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">
                                            <object type="image/svg+xml" data="css/feather/home.svg"></object>  
                                        </span>
                                        <asp:TextBox runat="server" ID="txtBranch_Address" CssClass="form-control" 
                                            AutoCompleteType="Disabled" placeholder="Address"></asp:TextBox>
                                    </div>
                                    <%-- Supervisor --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">Supervisor</span>
                                       <asp:DropDownList runat="server" id="ddSupervisorLists" CssClass="dropdown"></asp:DropDownList>
                                    </div>
                                     <%-- Company --%>
                                    <div class="input-group m-2">
                                        <span class="input-group-text">Company</span>
                                        <asp:DropDownList runat="server" id="ddCompanyLists" CssClass="dropdown"></asp:DropDownList>

                                    </div>
                                    <div class="row">
                                        <div class="col-1">
                                            <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" 
                                                >
                                                Back
                                            </asp:LinkButton>
                                        </div>
                                        <div class="col-1">
                                            <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-outline-primary" 
                                               >
                                                Save
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        
                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                            <%-- Basic Tab --%>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-basic" type="button" 
                                    role="tab" aria-controls="nav-basic" aria-selected="false">
                                    Basic
                                </button>
                            </li>
                            <%-- Sales Tab --%>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-sales" type="button" 
                                    role="tab" aria-controls="nav-sales" aria-selected="false">
                                    Sales
                                </button>
                            </li>
                            <%-- Expenses Tab --%>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-expenses" type="button" 
                                    role="tab" aria-controls="nav-expenses" aria-selected="false">
                                    Expenses
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content mt-2" id="branch-data-content">
                            <%-- Basic Pane --%>
                            <div class="tab-pane fade" id="nav-basic">
                                <div class="row m-2">
                                    <%-- Branch Address --%>
                                    <div class="col-4">
                                        <label class="form-label">Address</label>
                                        <asp:TextBox runat="server" ID="txtBranchAddress" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <%-- Branch Supervisor --%>
                                    <div class="col-4">
                                        <label class="form-label">Supervisor</label>
                                        <asp:TextBox runat="server" ID="txtBranchSupervisor" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <%-- Branch Company --%>
                                    <div class="col-4">
                                        <label class="form-label">Company</label>
                                        <asp:TextBox runat="server" ID="txtBranchCompany" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Sales Pane --%>
                            <div class="tab-pane fade" id="nav-sales">
                                <div class="row">
                                    <%-- Monthly Sales Label --%>
                                    <div class="col-6">
                                        <asp:Label runat="server" ID="lblBranchMonthlySales"></asp:Label>
                                    </div>
                                    <%-- Time Period Selection --%>
                                    <div class="col-6">
                                        <div class="input-group">
                                            <span class="input-group-text">Month</span>
                                            <asp:DropDownList runat="server" ID="ddPeriodList1" CssClass="form-control"></asp:DropDownList>
                                            <asp:LinkButton runat="server" ID="btnPeriodButton1" CssClass="btn btn-success">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <%-- Sales List --%>
                                <div class="row">
                                    <asp:GridView runat="server" ID="gvBranchSalesList" CssClass="table table-hover" 
                                        AutoGenerateColumns="false"></asp:GridView>
                                </div>
                            </div>
                            <%-- Expenses Pane --%>
                            <div class="tab-pane fade" id="nav-expenses">
                                <div class="row">
                                    <div class="col-6 offset-6">
                                        <div class="input-group">
                                            <span class="input-group-text">Month</span>
                                            <asp:DropDownList runat="server" ID="ddPeriodList2" CssClass="form-control"></asp:DropDownList>
                                            <asp:LinkButton runat="server" ID="btnPeriodButton2" CssClass="btn btn-success">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <asp:GridView runat="server" ID="gvBranchExpensesList" CssClass="table table-hover" 
                                        AutoGenerateColumns="false"></asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

             </asp:Panel>
    </div>    
</asp:Content>
