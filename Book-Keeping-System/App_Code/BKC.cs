using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace Book_Keeping_System
{
    public class BKC : baseC
    {
        #region "GET COMMAND"

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
        public void INSERT_BRANCH_UTILITY_TRANS(int _branchID, int _supplierID, string _TIN, string _rcptNum,
                                                double _vatableAmount, double _nonVat, double _vat, double _totalAmount,
                                                DateTime _dateFrom, DateTime _dateTo, string _particulars, string _remarks)

        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[BK].[spINSERT_BRANCH_UTILITY_EXPENSES_TRANS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@BRANCHID", _branchID);
                    cmd.Parameters.AddWithValue("@SUPPLIERID", _supplierID);
                    cmd.Parameters.AddWithValue("@TIN", _TIN);
                    cmd.Parameters.AddWithValue("@RCPTNUM", _rcptNum);
                    cmd.Parameters.AddWithValue("@VATABLE_AMOUNT", _vatableAmount);
                    cmd.Parameters.AddWithValue("@NON_VAT", _nonVat);
                    cmd.Parameters.AddWithValue("@VAT", _vat);
                    cmd.Parameters.AddWithValue("@TOTAL_AMOUNT", _totalAmount);
                    cmd.Parameters.AddWithValue("@DATE_FROM", _dateFrom);
                    cmd.Parameters.AddWithValue("@DATE_TO", _dateTo);
                    cmd.Parameters.AddWithValue("@PARTICULARS", _particulars);
                    cmd.Parameters.AddWithValue("@REMARKS", _remarks);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }

        }
        #endregion
    }
}