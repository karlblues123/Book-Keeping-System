<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BranchMonthlyExpenses.aspx.cs" Inherits="Book_Keeping_System.BranchMonthlyExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function ShowToast(msg) {
            document.getElementById('toast-message').textContent = msg;
            var toast = new bootstrap.Toast(document.getElementById('success-toast'));
            toast.show();
        };

        function ShowError(msg) {
            document.getElementById('error-message').textContent = msg;
            var toast = new bootstrap.Toast(document.getElementById('error-toast'));
            toast.show();
        }

        //Search function
        $(function searchInput() {
            $('[id*=txtBranchSearch]').on("keyup", function () {
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
                        $('[id*=txtBranchSearch]').on("keyup", function () {
                            var value = $(this).val().toLowerCase();
                            $('[id*=gvBranchList] tr').filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                }
            });
        }
    </script>
    <div class="container-fluid">
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Header --%>
            <div class="card-header">
                Branch - Monthly Expenses
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <div class="col-4">
                        <%-- Branch Card --%>
                        <div class="card">
                            <%-- Branch Dropdown --%>
                            <div class="card-header">
                                <div class="row m-2">
                                    <div class="input-group">
                                        <span class="input-group-text"><b class="fa fa-building"></b></span>
                                        <asp:TextBox runat="server" ID="txtBranchSearch" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Branch Select Button --%>

      <%--                       <div class="card-body">
                               <asp:Panel runat="server" ID="panelGridViewLists" Height="600px" ScrollBars="Vertical">
                                <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                    <Columns>
                                        <asp:BoundField DataField="BranchCode" />
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                               <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm"><b class="fa fa-arrow-right"></b></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                    </asp:Panel>--%>

                            <div class="card-body" style="max-height:550px;overflow-y:scroll;">
                                <asp:Panel runat="server" ID="panelGridViewLists">
                                    <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                        <Columns>
                                            <asp:BoundField DataField="BranchCode" />
                                            <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                   <asp:LinkButton runat="server" ID="lnkEdit" CssClass="btn btn-outline-primary btn-sm"><b class="fa fa-pencil"></b> Select</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </div>
                    
                    </div>
                    <div class="col-8">
                        <%-- Form Card --%>
                        <div class="card">
                            <%-- Form Card Header --%>
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-7">
                                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                                            <%-- Electricity Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-electricity" 
                                                    type="button" role="tab" aria-controls="tab-electricity" aria-selected="false">Electricity</button>
                                            </li>
                                            <%-- Water Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-water" 
                                                    type="button" role="tab" aria-controls="tab-water" aria-selected="false">Water</button>
                                            </li>
                                            <%-- Rental Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-rental" 
                                                    type="button" role="tab" aria-controls="tab-rental" aria-selected="false">Rental</button>
                                            </li>
                                            <%-- Misc. Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-misc" 
                                                    type="button" role="tab" aria-controls="tab-miscs" aria-selected="false">Misc.</button>
                                            </li>
                                            <%-- New Supplier Tab --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-new-supplier" 
                                                    type="button" role="tab" aria-controls="tab-new-supplier" aria-selected="false">New Supplier</button>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-5">
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%-- Form Card Body --%>
                            <div class="card-body tab-content">
                                <%-- Electricity Bill Form --%>
                                <div class="tab-pane fade" id="tab-electricity" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upElectricity" UpdateMode="Conditional" 
                                        ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:DropDownList runat="server" ID="ddElecSupplier" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtElecTIN" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Receipt No.</span>
                                                    <asp:TextBox runat="server" ID="txtElecReceipt" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Coverage --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">From</span>
                                                    <asp:TextBox runat="server" ID="txtElecFrom" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <span class="input-group-text">To</span>
                                                    <asp:TextBox runat="server" ID="txtElecTo" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount and VAT--%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtElectricVATAmount" 
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtElectricNonVATAmount"
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtElectricVAT" 
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkElectricRecord" 
                                                        CssClass="btn btn-success" OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Water Bill Form --%>
                                <div class="tab-pane fade" id="tab-water" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upWater" UpdateMode="Conditional" 
                                        ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:DropDownList runat="server" ID="ddWaterSupplier" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtWaterTIN" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Receipt No.</span>
                                                    <asp:TextBox runat="server" ID="txtWaterReceipt" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Coverage --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">From</span>
                                                    <asp:TextBox runat="server" ID="txtWaterFrom" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <span class="input-group-text">To</span>
                                                    <asp:TextBox runat="server" ID="txtWaterTo" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount and VAT --%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtWaterVATAmount" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtWarerNonVATAmount"
                                                            CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtWaterVAT" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkWaterRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Rental Form --%>
                                <div class="tab-pane fade" id="tab-rental" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upRental" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Rental</span>
                                                    <asp:TextBox runat="server" ID="txtRental" CssClass="form-control" 
                                                        TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="col-6">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Check Number</span>
                                                        <asp:TextBox runat="server" ID="txtRentalCheck" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Check Amount</span>
                                                        <asp:TextBox runat="server" ID="txtCheckAmount" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkRentalRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Misc Form --%>
                                <div class="tab-pane fade" id="tab-misc" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upMisc" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Amount</span>
                                                    <asp:TextBox runat="server" ID="txtMiscAmount" CssClass="form-control" 
                                                        TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Label</span>
                                                    <asp:TextBox runat="server" ID="txtMiscLabel" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Record Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkMiscRecord" CssClass="btn btn-success" 
                                                        OnClick="Show_Toast">Record</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- New Supplier Form --%>
                                <div class="tab-pane fade" id="tab-new-supplier" role="tabpanel">
                                    <asp:UpdatePanel runat="server" ID="upNewSupplier" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers></Triggers>
                                        <ContentTemplate>
                                            <%-- Supplier Name --%>
                                            <div class="row m-2">
                                                <div class="col">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=txtSupplierName.ClientID%>">Name</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Supplier Address --%>
                                            <div class="row m-2">
                                                <div class="col">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=txtSupplierAddress.ClientID%>">Address</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Supplier TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control" 
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=txtSupplierTIN.ClientID%>">TIN</label>
                                                    </div>
                                                    <div class="input-group-text d-flex align-items-center">
                                                        VAT
                                                        <asp:CheckBox runat="server" ID="cbVAT" CssClass="form-check"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Save Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-outline-success">Save</asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- Success Toast --%>
        <div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
            <div id="success-toast" class="toast hide text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-body">
                  <span id="toast-message"></span><button type="button" class="btn-close float-end" 
                      data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <%-- Error Toast --%>
        <div class="position-fixed bottom-0 end-0 p-3 " style="z-index: 11">
            <div class="toast hide text-bg-danger border-0" id="error-toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-body">
                    <span id="error-message"></span><button type="button" class="btn-close float-end" 
                        data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
