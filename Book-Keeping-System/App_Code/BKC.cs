using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace Book_Keeping_System
{
    public class BKC : baseC
    {
        #region GET

        public DataTable GET_EXPENSES_LISTS()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_EXPENSES_LISTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }

            return dt;

        }

        public DataTable GET_BRANCH_DEFAULT_UTILITIES()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_BRANCH_DEFAULT_EXPENSES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }

            return dt;

        }


        public DataTable GET_BRANCH_EXPENSES_RECORD_LISTS(int _branchID)
        {
            DataTable dt = new DataTable();

           
            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_BRANCH_EXPENSES_RECORD_LISTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BRANCHID", _branchID);
                    

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;

        }

        public DataTable GET_BRANCH_DAY_SALE(string branch_code, SqlDateTime date)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_BRANCH_DAY_SALE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@BRANCHCODE", branch_code);
                    cmd.Parameters.AddWithValue("@DATE", date);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_BRANCH_SALES(string branch_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_BRANCH_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@BRANCHCODE", branch_code);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_EXPENSE_TYPES()
        {
            return queryCommandDT_StoredProc("[BK].[spGET_TYPE_EXPENSE]");
        }

        public DataTable GET_LIST_EXPENSES(string account_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_LIST_EXPENSES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ACCOUNTCODE", account_code);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_SELECTED_EXPENSE(int id)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_SELECTED_EXPENSE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ID", id);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_RENTAL_CONTRACTS(string branch_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {

                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_RENTAL_CONTRACTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@BRANCHCODE", branch_code);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        #endregion



        #region "INSERT/UPDATE COMMAND"

        public void INSERT_DEFAULT_BRANCH_UTILITIES(string _branchCode, string _providerName, 
                                                    string _accountNumber, string _TIN, string _remarks)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_BRANCH_DEFAULT_UTILITIES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@BRANCHCODE", _branchCode);
                    cmd.Parameters.AddWithValue("@PROVIDERNAME", _providerName);
                    cmd.Parameters.AddWithValue("@ACCOUNTNUMBER", _accountNumber);
                    cmd.Parameters.AddWithValue("@TIN", _TIN);
                    cmd.Parameters.AddWithValue("@REMARKS", _remarks);
                    

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }


        //INSERT UTILITY EXPENSES TRANSACTION
        public void INSERT_BRANCH_UTILITY_TRANS(int _branchID, int _supplierID, string _supplierName, string _TIN, string _rcptNum,
                                                double _vatableAmount, double _nonVat, double _vat, double _totalAmount,
                                                DateTime _dateApplied, DateTime _dateFrom, DateTime _dateTo, string _particulars, string _remarks, int _expensesID)

        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_BRANCH_UTILITY_EXPENSES_TRANS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@BRANCHID", _branchID);
                    cmd.Parameters.AddWithValue("@SUPPLIERID", _supplierID);
                    cmd.Parameters.AddWithValue("@SUPPLIERNAME", _supplierName);
                    cmd.Parameters.AddWithValue("@TIN", _TIN);
                    cmd.Parameters.AddWithValue("@RCPTNUM", _rcptNum);
                    cmd.Parameters.AddWithValue("@VATABLE_AMOUNT", _vatableAmount);
                    cmd.Parameters.AddWithValue("@NON_VAT", _nonVat);
                    cmd.Parameters.AddWithValue("@VAT", _vat);
                    cmd.Parameters.AddWithValue("@TOTAL_AMOUNT", _totalAmount);
                    cmd.Parameters.AddWithValue("@APPLIED_DATE", _dateApplied);
                    cmd.Parameters.AddWithValue("@DATE_FROM", _dateFrom);
                    cmd.Parameters.AddWithValue("@DATE_TO", _dateTo);
                    cmd.Parameters.AddWithValue("@PARTICULARS", _particulars);
                    cmd.Parameters.AddWithValue("@REMARKS", _remarks);
                    cmd.Parameters.AddWithValue("@EXPENSESID", _expensesID);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }

        }

        //Insert Branch Sales
        public void INSERT_BRANCH_SALES(string branch_code, SqlDateTime date, string starting_invoice, string ending_invoice,
            int chicken_quantity, decimal chicken_price, decimal chicken_total, int atsara_quantity, decimal atsara_price,
            decimal atsara_total)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_BRANCH_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@BRANCHCODE",branch_code);
                    cmd.Parameters.AddWithValue("@DATE", date);
                    cmd.Parameters.AddWithValue("@STARTINGINVOICE", starting_invoice);
                    cmd.Parameters.AddWithValue("@ENDINGINVOICE", ending_invoice);
                    cmd.Parameters.AddWithValue("@CHICKENQUANTITY", chicken_quantity);
                    cmd.Parameters.AddWithValue("@CHICKENPRICE", chicken_price);
                    cmd.Parameters.AddWithValue("@CHICKENTOTAL", chicken_total);
                    cmd.Parameters.AddWithValue("@ATSARAQUANTITY", atsara_quantity);
                    cmd.Parameters.AddWithValue("@ATSARAPRICE", atsara_price);
                    cmd.Parameters.AddWithValue("@ATSARATOTAL", atsara_total);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        public void INSERT_PURCHASE_EXPENSE(string account_code, int supplier_id, string invoice, string po_code, int type,
            decimal vatable, decimal nonvat, decimal vat_amount,decimal total_amount, string remarks, decimal amount_tendered, 
            SqlDateTime date, string cheque_number)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_PURCHASE_EXPENSE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@ACCOUNTCODE", account_code);
                    cmd.Parameters.AddWithValue("@SUPPLIERID", supplier_id);
                    cmd.Parameters.AddWithValue("@INVOICE", invoice);
                    cmd.Parameters.AddWithValue("@POCODE", po_code);
                    cmd.Parameters.AddWithValue("@TYPE", type);
                    cmd.Parameters.AddWithValue("@VATABLE", vatable);
                    cmd.Parameters.AddWithValue("@NONVAT", nonvat);
                    cmd.Parameters.AddWithValue("@VATAMOUNT", vat_amount);
                    cmd.Parameters.AddWithValue("@TOTALAMOUNT", total_amount);
                    cmd.Parameters.AddWithValue("@REMARKS", remarks);
                    cmd.Parameters.AddWithValue("@AMOUNTTENDERED", amount_tendered);
                    cmd.Parameters.AddWithValue("@DATE", date);
                    cmd.Parameters.AddWithValue("@CHEQUENUMBER", cheque_number);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        public void INSERT_UTILITY_EXPENSE(string account_code, int supplier_id, string invoice, string po_code, int type,
            decimal vatable, decimal nonvat, decimal vat_amount, decimal total_amount, string remarks, decimal amount_tendered,
            SqlDateTime date, SqlDateTime from_date,SqlDateTime to_date, string account_number,string cheque_number)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_UTILITY_EXPENSE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@ACCOUNTCODE", account_code);
                    cmd.Parameters.AddWithValue("@SUPPLIERID", supplier_id);
                    cmd.Parameters.AddWithValue("@INVOICE", invoice);
                    cmd.Parameters.AddWithValue("@POCODE", po_code);
                    cmd.Parameters.AddWithValue("@TYPE", type);
                    cmd.Parameters.AddWithValue("@VATABLE", vatable);
                    cmd.Parameters.AddWithValue("@NONVAT", nonvat);
                    cmd.Parameters.AddWithValue("@VATAMOUNT", vat_amount);
                    cmd.Parameters.AddWithValue("@TOTALAMOUNT", total_amount);
                    cmd.Parameters.AddWithValue("@REMARKS", remarks);
                    cmd.Parameters.AddWithValue("@AMOUNTTENDERED", amount_tendered);
                    cmd.Parameters.AddWithValue("@DATE", date);
                    cmd.Parameters.AddWithValue("@FROMDATE", from_date);
                    cmd.Parameters.AddWithValue("@TODATE", to_date);
                    cmd.Parameters.AddWithValue("@ACCOUNTNUMBER", account_number);
                    cmd.Parameters.AddWithValue("@CHEQUENUMBER", cheque_number);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        public void INSERT_BRANCH_RENTAL_CONTRACT(int lessor, string lessee, DateTime from_date, DateTime to_date, 
            string branch_code, string remarks)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spGET_RENTAL_CONTRACTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@LESSOR", lessor);
                    cmd.Parameters.AddWithValue("@LESSEE", lessee);
                    cmd.Parameters.AddWithValue("@FROMDATE", from_date);
                    cmd.Parameters.AddWithValue("@TODATE", to_date);
                    cmd.Parameters.AddWithValue("@BRANCHCODE", branch_code);
                    cmd.Parameters.AddWithValue("@REMARKS", remarks);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }
        #endregion
    }
}