<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CompanyExpenses.aspx.cs" Inherits="Book_Keeping_System.CompanyExpenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
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
    </script>
    <div class="containter-fluid">
        <%-- Main Card --%>
        <div class="card m-2">
            <%-- Main Card Header --%>
            <div class="card-header">
                Company - Expenses
            </div>
            <%-- Main Card Body --%>
            <div class="card-body">
                <div class="row">
                    <%-- Company Selection Card --%>
                    <div class="col-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="row m-2">
                                    <div class="input-group">
                                        <span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg></span>
                                        <%-- Company Dropdown List --%>
                                        <asp:DropDownList runat="server" ID="ddCompanyList" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <%-- Company Select Button --%>
                                <asp:LinkButton runat="server" ID="btnCompanySelect" CssClass="btn btn-success" 
                                    OnClick="btnCompanySelectButton_Click">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <%-- Form Card --%>
                        <div class="card">
                            <%-- Form Card Header --%>
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-8">
                                        <ul class="nav nav-pills" id="form-pills" role="tablist">
                                            <%-- Tab Link Electricity --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-utility"
                                                    type="button" role="tab" aria-controls="tab-utility" aria-selected="false">
                                                    Utility
                                                </button>
                                            </li>
                                            <%-- Tab Link Miscellaneous --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-misc" 
                                                    type="button" role="tab" aria-controls="tab-misc" aria-selected="false">
                                                    Miscellaneous
                                                </button>
                                            </li>
                                            <%-- Tab Link New Supplier --%>
                                            <li class="nav-item">
                                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-new-supplier" 
                                                   type="button" role="tab" aria-controls="tab-new-supplier" aria-selected="false">
                                                    New Supplier
                                                </button>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-4">
                                        <%-- Date --%>
                                        <asp:UpdatePanel runat="server" ID="upDate" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                            <Triggers>     
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <%-- Form Card Body --%>
                            <div class="card-body tab-content">
                                <%-- Utility Pane --%>
                                <div class="tab-pane fade" id="tab-utility">
                                    <asp:UpdatePanel runat="server" ID="upUtility" UpdateMode="Conditional" 
                                        ChildrenAsTriggers="false">
                                        <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:DropDownList runat="server" ID="ddUtilitySupplier" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtUtilityTIN" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="col-8">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Receipt No.</span>
                                                        <asp:TextBox runat="server" ID="txtUtilityReceipt" CssClass="form-control"
                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Type</span>
                                                        <asp:DropDownList runat="server" ID="ddUtilityType" CssClass="form-control"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Coverage --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">From</span>
                                                    <asp:TextBox runat="server" ID="txtUtilityFrom" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <span class="input-group-text">To</span>
                                                    <asp:TextBox runat="server" ID="txtUtilityTo" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount and VAT--%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtUtilityVATAmount" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtUtilityNonVATAmount" CssClass="form-control"
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtUtilityVAT" CssClass="form-control" 
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Submit Button --%>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkUtilitySubmit" 
                                                        CssClass="btn btn-success">
                                                        Submit
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <%-- Miscellaneous Pane --%>
                                <div class="tab-pane fade" id="tab-misc">
                                   <asp:UpdatePanel runat="server" ID="upMisc" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                       <ContentTemplate>
                                            <%-- Supplier --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Supplier</span>
                                                    <asp:TextBox runat="server" ID="txtMiscSupplier" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- TIN --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">TIN</span>
                                                    <asp:TextBox runat="server" ID="txtMiscTIN" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- PO Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">PO No.</span>
                                                    <asp:TextBox runat="server" ID="txtMiscPO" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Receipt Number --%>
                                            <div class="row m-2">
                                                <div class="input-group">
                                                    <span class="input-group-text">Receipt No.</span>
                                                    <asp:TextBox runat="server" ID="txtMiscReceipt" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%-- Amount & VAT --%>
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VATable</span>
                                                        <asp:TextBox runat="server" ID="txtMiscVATAmount" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">Non-VAT</span>
                                                        <asp:TextBox runat="server" ID="txtMiscNonVATAmount" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="input-group">
                                                        <span class="input-group-text">VAT</span>
                                                        <asp:TextBox runat="server" ID="txtMiscVAT" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                           <%-- Particulars --%>
                                           <div class="row m-2">
                                               <div class="input-group">
                                                   <span class="input-group-text">Particulars</span>
                                                   <asp:TextBox runat="server" ID="txtMiscParticulars" CssClass="form-control"></asp:TextBox>
                                               </div>
                                           </div>
                                            <div class="row m-2">
                                                <div class="col-2">
                                                    <asp:LinkButton runat="server" ID="lnkMiscSubmit" CssClass="btn btn-success" 
                                                        OnClick="lnkMiscSubmit_Click">Submit</asp:LinkButton>
                                                </div>
                                            </div>
                                       </ContentTemplate>
                                   </asp:UpdatePanel>
                                </div>
                                <%-- New Supplier Pane --%>
                                <div class="tab-pane fade" id="tab-new-supplier">
                                    <asp:UpdatePanel runat="server" ID="upNewSupplier" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                        <Triggers></Triggers>
                                        <ContentTemplate>
                                            <%-- Supplier Name --%>
                                            <div class="input-group m-2">
                                                <span class="input-group-text">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg>
                                                </span>
                                                <asp:TextBox runat="server" ID="txtSupplierName" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                                            </div>
                                            <%-- Supplier Address --%>
                                            <div class="input-group m-2">
                                                <span class="input-group-text">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>  
                                                </span>
                                                <asp:TextBox runat="server" ID="txtSupplierAddress" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" placeholder="Address"></asp:TextBox>
                                            </div>
                                            <%-- Supplier TIN --%>
                                            <div class="input-group m-2">
                                                <span class="input-group-text">TIN</span>
                                                <asp:TextBox runat="server" ID="txtSupplierTIN" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" placeholder="TIN"></asp:TextBox>
                                                <div class="input-group-text d-flex align-items-center">
                                                    VAT
                                                    <asp:CheckBox runat="server" ID="cbVAT" />
                                                </div>
                                            </div>
                                            <div class="input-group m-2">
                                                <asp:LinkButton runat="server" ID="lnkSupplierSave" CssClass="btn btn-success">Save</asp:LinkButton>
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
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
            <div id="success-toast" class="toast hide text-bg-success" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-body">
                  <span id="toast-message"></span><button type="button" class="btn-close float-end" data-bs-dismiss="toast" aria-label="Close"></button>
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
