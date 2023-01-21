<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VATReport.aspx.cs" Inherits="Book_Keeping_System.VATReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-9">
                <div class="card m-2">
                    <div class="card-header">
                        <asp:Label runat="server" ID="lblForm" Visible="false"></asp:Label>
                        <asp:LinkButton runat="server" ID="lnkNew" CssClass="btn btn-primary d-flex justify-content-center float-end" 
                            data-bs-toggle="modal" data-bs-target="#formModal" Visible="false">
                            <object type="image/svg+xml" data="css/feather/plus-circle.svg"></object> 
                        </asp:LinkButton>
                    </div>
                    <div class="card-body">
                        <%-- Entry List --%>
                        <asp:GridView runat="server" ID="gvReportEntries" AutoGenerateColumns="false" CssClass="table">
                            <Columns>
                                <asp:BoundField DataField="Branch" HeaderText="Branch"/>
                                <asp:BoundField DataField="SupplierName" HeaderText="Supplier"/>
                                <asp:BoundField DataField="Amount" HeaderText="Amount"  />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="card m-2">
                    <div class="card-body">
                        <%-- Company List --%>
                        <div class="row m-2">
                            <asp:DropDownList runat="server" ID="ddCompanyList" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <%-- Month List --%>
                        <div class="row m-2">
                            <asp:DropDownList runat="server" ID="ddMonthList" CssClass="form-control" 
                                DataTextField="MonthTextField" DataValueField="MonthValueField"></asp:DropDownList>
                        </div>
                        <%-- Type List --%>
                        <div class="row m-2">
                            <asp:DropDownList runat="server" ID="ddReportTypeList" CssClass="form-control" 
                                DataTextField="TypeTextField" DataValueField="TypeValueField"></asp:DropDownList>
                        </div>
                    </div>
                    <%-- Button --%>
                    <div class="card-footer">
                        <asp:LinkButton runat="server" ID="lnkSelect" CssClass="btn btn-primary" OnClick="lnkSelect_Click">Select</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <%-- Form Modal --%>
        <div class="modal" tabindex="-1" id="formModal">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">New Entry</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <%-- Branch --%>
                  <div class="input-group m-2">
                      <span class="input-group-text">Branch</span>
                      <asp:TextBox runat="server" ID="txtBranch" CssClass="form-control"
                          placeholder="Branch Name" AutoCompleteType="Disabled"></asp:TextBox>
                  </div>
                  <%-- Supplier --%>
                  <div class="input-group m-2">
                      <span class="input-group-text">Supplier</span>
                      <asp:DropDownList runat="server" ID="ddSupplierName" CssClass="form-control"></asp:DropDownList>
                  </div>
                  <%-- Supplier Address --%>
                  <div class="input-group m-2">
                      <span class="input-group-text">Supplier Address</span>
                      <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" ReadOnly="true"
                          placeholder="Select a Supplier" AutoCompleteType="Disabled"></asp:TextBox>
                  </div>
                  <%-- TIN --%>
                  <div class="input-group m-2">
                      <span class="input-group-text">TIN</span>
                      <asp:TextBox runat="server" ID="txtTIN" CssClass="form-control"
                          placeholder="TIN" AutoCompleteType="Disabled"></asp:TextBox>
                  </div>
                  <%-- Amount --%>
                  <div class="input-group m-2">
                      <span class="input-group-text">Amount</span>
                      <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control" TextMode="Number"
                          placeholder="Amount" AutoCompleteType="Disabled"></asp:TextBox>
                  </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
              </div>
            </div>
          </div>
        </div>
    </div>
</asp:Content>
