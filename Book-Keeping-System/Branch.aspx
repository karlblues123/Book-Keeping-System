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

        <asp:UpdatePanel runat="server" ID="upBranchList">
          
            <ContentTemplate>
                <asp:Panel runat="server" ID="panelBranchLists">
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
                                        <asp:LinkButton runat="server" ID="lnkNew" CssClass="btn btn-outline-success" OnClick="lnkNew_Click"><b class="fa fa-plus-circle"></b> New</asp:LinkButton>
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
                                        <asp:BoundField DataField="Supervisor_Name" HeaderText="Supervisor" />
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
 
                </asp:Panel>

        <%-- Branch Data Panel --%>
        <asp:Panel runat="server" ID="panelBranchInputForm" Visible="false">
   
                <div class="card m-2">
                    <%-- Header --%>
                    <div class="card-header">
                        <h5>Branch Details</h5>
                        <asp:Label runat="server" ID="lblBranchName"></asp:Label>
                    </div>
                    <%-- Body --%>
                    
                    <div class="card-body">
                       <div class="row">
                       <div class="col">


                           <table class="table table-responsive">
                               <tr>

                                   <td colspan="2">

                                       <div class="form-floating small">
                                           <asp:TextBox runat="server" ID="txtBranchName" CssClass="form-control" placeholder="Branch Name"></asp:TextBox>
                                           <label for="txtBranchName">Branch Name</label>
                                       </div>

                                   </td>

                               </tr>
                               <tr>
                                   <td colspan="2">
                                       <div class="form-floating small">
                                           <asp:TextBox runat="server" ID="txtBranch_Address" CssClass="form-control"
                                               placeholder="Address"></asp:TextBox>
                                           <label for="txtBranchName">Branch Address</label>
                                       </div>


                                   </td>
                               </tr>
                               <tr>
                                   <td>

                                       <div class="form-floating">
                                           <asp:DropDownList runat="server" ID="ddSupervisorLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                           <label for="ddSupervisorLists">Supervisor</label>
                                       </div>

                                   </td>

                                   <td>
                                       <div class="form-floating">
                                           <asp:DropDownList runat="server" ID="ddCompanyLists" CssClass="form-select" aria-label="Floating label select example"></asp:DropDownList>
                                           <label for="ddCompanyLists">Company</label>
                                       </div>


                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <div class="row">
                                           <div class="col">
                                               <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn btn-outline-warning" OnClick="lnkBack_Click">
                                                        <b class="fa fa-arrow-circle-left"></b> Back
                                               </asp:LinkButton>
                                           </div>
                                           <div class="col">
                                               <asp:LinkButton runat="server" ID="lnkSave" CssClass="btn btn-outline-primary">
                                                        <b class="fa fa-save"></b> Save
                                               </asp:LinkButton>
                                           </div>
                                       </div>
                                   </td>
                               </tr>

                           </table>
                                          
                                           
                   
                       </div>
                           <div class="col">
                               <asp:Panel runat="server" ID="panelSideInputs" Enabled="false">
                               <ul class="nav nav-tabs" id="myTab" role="tablist">

                                   <li class="nav-item" role="presentation">
                                       <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false"><b class="fa fa-rotate-right text-warning"></b> Default Utilities Details</button>
                                   </li>
                                   <li class="nav-item" role="presentation">
                                       <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">Rental Details</button>
                                   </li>
                                   <li class="nav-item" role="presentation">
                                       <button class="nav-link" id="disabled-tab" data-bs-toggle="tab" data-bs-target="#disabled-tab-pane" type="button" role="tab" aria-controls="disabled-tab-pane" aria-selected="false" disabled>Disabled</button>
                                   </li>
                               </ul>
                               <div class="tab-content" id="myTabContent">



                                   <div class="tab-pane fade show active" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                                    
                                       <div class="text-end">
                                    <asp:LinkButton runat="server" ID="lnkAddUtilities" data-bs-toggle="collapse" data-bs-target="#collapseDiv" role="button"  aria-expanded="false" aria-controls="collapseStored" CssClass="btn btn-outline-success btn-sm"> 
                                        <b class="fa fa-toggle-down"></b> Add Default Utilities</asp:LinkButton>
                                   </div>
                                        <div class="collapse" id="collapseDiv">
                                         <table class="table table-responsive table-hover">
                                           <tr>
                                               <td>
                                                   <div class="form-floating">
                                                       <asp:TextBox runat="server" ID="txtProviderName" CssClass="form-control"
                                                           placeholder="Provide Name"></asp:TextBox>
                                                       <label for="txtProviderName">Provider Name</label>
                                                   </div>
                                               </td>
                                               <td>
                                                   <div class="form-floating">
                                                       <asp:TextBox runat="server" ID="txtProviderAcctNumber" CssClass="form-control"
                                                           placeholder="Account Number"></asp:TextBox>
                                                       <label for="txtProviderAcctNumber">Account Number</label>
                                                   </div>
                                               </td>
                                                <td>
                                                   <div class="form-floating">
                                                       <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control"
                                                           placeholder="TIN Number"></asp:TextBox>
                                                       <label for="txtTIN">TIN Number</label>
                                                   </div>
                                               </td>
                                           </tr>
                                           <tr>
                                               <td>
                                                   <div class="form-floating">
                                                       <asp:TextBox runat="server" ID="txtAddInfo" CssClass="form-control"
                                                           placeholder="Additional Info"></asp:TextBox>
                                                       <label for="txtAddInfo">Additional Info</label>
                                                   </div>
                                               </td>
                                               <td colspan="2">
                                                   <div class="form-floating">
                                                       <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control"
                                                           placeholder="Remarks"></asp:TextBox>
                                                       <label for="txtRemarks">Remarks</label>
                                                   </div>
                                               </td>
                                              
                                           </tr>
                                           <tr>
                                           <td colspan="3" class="text-end">
                                               
                                              <asp:LinkButton runat="server" ID="lnkAddProvider" CssClass="btn btn-outline-primary" OnClick="lnkAddProvider_Click">
                                                        <b class="fa fa-plus"></b> Add
                                               </asp:LinkButton>
                                               
                                           </td>
                                               </tr>
                                       </table>


                                        </div>
                                        <!-- List of default utilities -->
                                       <div class="">
                                           <asp:GridView runat="server" ID="gvBranchDefaultUtilities" AutoGenerateColumns="false" CssClass="table table-responsive small">
                                               <Columns>
                                                  <asp:BoundField DataField="ID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                                                   <asp:BoundField DataField="ProviderName" HeaderText="Provider" />
                                                   <asp:BoundField DataField="AccountNumber" HeaderText="Account #" />
                                                   <asp:BoundField DataField="TIN"  HeaderText="TIN"/>
                                                   <asp:BoundField DataField="AdditionalDetail" />
                                                   <asp:BoundField DataField="Remarks" />

                                               </Columns>
                                           </asp:GridView>
                                       </div>
                                       </div>
                                   <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">...</div>
                                   <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">...</div>
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
