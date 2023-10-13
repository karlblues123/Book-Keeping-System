<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Branch.aspx.cs" Inherits="Book_Keeping_System.Branch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
       
        //Search function
        $(function searchInput() {
            $('[id*=search-bar]').on("keyup", function () {
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
                        $('[id*=search-bar]').on("keyup", function () {
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

    <div class="container-fluid" style="padding-left:0;padding-right:0;">
        <asp:UpdatePanel runat="server" ID="upBranchList">
            <ContentTemplate>
                <asp:Panel runat="server" ID="panelBranchLists">
                    <div class="card" style="border:0;">
                        <%-- Header --%>
                        <div class="card-header bg-warning bg-opacity-25" style="height:57px">
                            <div class="row d-flex align-items-center">
                                <div class="col-8">
                                    <b class="fa fa-building text-info"></b>  <b>Branches Information</b>
                                </div>
                                <%-- Search Bar --%>
                                <div class="col-4">
                                    <div class="input-group">
                                        <input type="text" id="search-bar" placeholder="Search" 
                                            class="form-control form-control-sm" role="search"></input>
                                        <div class="btn-group">
                                            <asp:LinkButton runat="server" ID="lnkNew" CssClass="btn btn-sm btn-outline-success" OnClick="lnkNew_Click"><b class="fa fa-plus-circle"></b> New</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Body --%>
                        <div class="card-body ms-5 me-5">
                            <%-- Branch List --%>
                            <asp:Panel runat="server" ID="panelGridViewLists" Height="600px" ScrollBars="Vertical">
                                <%-- Branch GridView --%>
                                <asp:GridView runat="server" ID="gvBranchList" GridLines="Horizontal" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                    <Columns>
                                        <%-- <asp:BoundField DataField="BranchAddress" HeaderText="Address" />
                                        <asp:BoundField DataField="BranchStatus" HeaderText="Status" />--%>
                                        <asp:BoundField DataField="BranchID" />
                                        <asp:BoundField DataField="BranchCode" />
                                        <asp:BoundField DataField="Branch_Name" HeaderText="Branch" />
                                        <%--<asp:BoundField DataField="Supervisor_Name" HeaderText="Supervisor" />--%>
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
                </asp:Panel>
                <%-- Branch Data Panel --%>
                <asp:Panel runat="server" ID="panelBranchInputForm" Visible="false">
                    <div class="card" style="border:0;">
                        <%-- Header --%>
                        <div class="card-header bg-warning bg-opacity-25" style="height:57px">
                            <h5>Branch Details</h5>
                            <asp:Label runat="server" ID="lblBranchName"></asp:Label>
                        </div>
                        <%-- Body --%>
                        <div class="card-body ms-5 me-5">
                            <div class="row">
                                <div class="col-6">
                                    <%-- Branch Name --%>
                                    <div class="row mt-2">
                                        <div class="col">
                                            <div class="form-floating small">
                                                <asp:TextBox runat="server" ID="txtBranchName" CssClass="form-control" placeholder="Branch Name"></asp:TextBox>
                                                <label for="txtBranchName">Branch Name</label>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Branch Address --%>
                                    <div class="row mt-2">
                                        <div class="col">
                                            <div class="form-floating small">
                                                <asp:TextBox runat="server" ID="txtBranch_Address" CssClass="form-control"
                                                    placeholder="Address"></asp:TextBox>
                                                <label for="txtBranchName">Branch Address</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <%-- Supervisor --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="ddSupervisorLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                                <label for="ddSupervisorLists">Supervisor</label>
                                            </div>
                                        </div>
                                        <%-- Company --%>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <asp:DropDownList runat="server" ID="ddCompanyLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                                <label for="ddCompanyLists">Company</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <%-- Back --%>
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" OnClick="lnkBack_Click">
                                                            <b class="fa fa-arrow-circle-left"></b> Back
                                            </asp:LinkButton>
                                        </div>
                                        <%-- Save --%>
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-outline-primary">
                                                            <b class="fa fa-save"></b> Save
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-6">
                                <asp:Panel runat="server" ID="panelSideInputs" Enabled="false" CssClass="card">
                                    <%-- Tabs --%>
                                    <div class="card-header-tabs">
                                        <ul class="nav nav-tabs ms-2" id="myTab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" 
                                                    data-bs-target="#profile-tab-pane" type="button" role="tab" 
                                                    aria-controls="profile-tab-pane" aria-selected="false">
                                                    <b class="fa fa-rotate-right text-warnin"></b>
                                                    Default Utilities Provider
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="contact-tab" data-bs-toggle="tab" 
                                                    data-bs-target="#contact-tab-pane" type="button" role="tab" 
                                                    aria-controls="contact-tab-pane" aria-selected="false">
                                                    Rental Information
                                                </button>
                                            </li>
                                           
                                        </ul>
                                    </div>
                                    <div class="card-body tab-content" id="myTabContent">
                                        <div class="tab-pane fade show active" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                                            <%-- New Provider Form --%>
                                            <asp:Panel runat="server" ID="pNewProvider" Visible="false">
                                                <div class="row mt-2">
                                                    <div class="col-6">
                                                        <div class="form-floating">
                                                                <asp:TextBox runat="server" ID="txtProvider" CssClass="form-control"
                                                                    placeholder="Provider"></asp:TextBox>
                                                                <label for="txtProvider">Provider</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="form-floating">
                                                                <asp:TextBox runat="server" ID="txtProviderAcctNumber" CssClass="form-control"
                                                                    placeholder="Account Number"></asp:TextBox>
                                                                <label for="txtProviderAcctNumber">Account Number</label>
                                                        </div>
                                                    </div>
                                                 </div>
                                                <div class="row mt-2">
                                                     <div class="col-6">
                                                        <div class="form-floating">
                                                                <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control"
                                                                    placeholder="TIN Number"></asp:TextBox>
                                                                <label for="txtTIN">TIN Number</label>
                                                        </div>
                                                    </div>
                                                     <div class="col-6">
                                                        <div class="form-floating">
                                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control"
                                                                    placeholder="Remarks"></asp:TextBox>
                                                                <label for="txtRemarks">Remarks</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col-2">
                                                        <asp:LinkButton runat="server" ID="lnkProviderBack" CssClass="btn btn-outline-warning" 
                                                            OnClick="lnkProviderBack_Click">Back</asp:LinkButton>
                                                    </div>
                                                    <div class="col-2">
                                                        <asp:LinkButton runat="server" ID="lnkSaveProvider" OnClick="lnkSaveProvider_Click" CssClass="btn btn-outline-primary">
                                                            <b class="fa fa-save"></b> Save
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <%-- Provider List --%>
                                            <asp:Panel runat="server" ID="pProviderList" Visible="true">
                                                <div class="row m-2">
                                                    <div class="card" style="padding-left:0;padding-right:0;">
                                                        <div class="card-header bg-info bg-opacity-25">
                                                            <div class="row">
                                                                <div class="col-9">
                                                                    List of Assigned Provider
                                                                </div>
                                                                <div class="col-3">
                                                                    <asp:LinkButton runat="server" ID="lnkAddNewProvider" OnClick="lnkAddNewProvider_Click"  CssClass="btn btn-outline-primary btn-sm">
                                                                        New Provider
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-body">
                                                            <asp:GridView runat="server" ID="gvBranchDefaultUtilities" AutoGenerateColumns="false" CssClass="table table-responsive table-light">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ProviderName" HeaderText="Provider" />
                                                                    <asp:BoundField DataField="AccountNumber" HeaderText="Account #" />
                                                                    <asp:BoundField DataField="TIN" HeaderText="TIN" />
                                                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks"/>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                        <%--<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">...</div>
                                        <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">...</div>--%>
                                    </div>
                                </asp:Panel>
                            </div>     
                        </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>  
    </div>    
</asp:Content>
