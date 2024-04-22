using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace Book_Keeping_System
{
    public class MasterC : baseC
    {

        #region "GET COMMAND"

        public DataTable GET_SUPPLIER_LISTS()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spGET_SUPPLIER_LISTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }

            return dt;

        }


        public DataTable GET_BRANCH_LISTS()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spGET_BRANCH_LISTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }

            return dt;

        }

        public DataTable GET_COMPANY_LISTS()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spGET_COMPANY_LISTS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
            }

            return dt;

        }

        public DataTable GET_SUPERVISOR_LISTS()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spGET_SUPERVISOR_LISTS]", cn))
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


        #region "INSERT/UPDATE Area"

        public void INSERT_SUPPLIER_DATA(string _supplierName, string _supplierAddress, string _TIN, bool _isVat, 
            string contact_number, string contact_person)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spINSERT_SUPPLIER_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                 
                    cmd.Parameters.AddWithValue("@SUPPLIER_NAME", _supplierName);
                    cmd.Parameters.AddWithValue("@SUPPLIER_ADDRESS", _supplierAddress);
                    cmd.Parameters.AddWithValue("@TIN", _TIN);
                    cmd.Parameters.AddWithValue("@ISVAT", _isVat);
                    cmd.Parameters.AddWithValue("@CONTACTNUMBER", contact_number);
                    cmd.Parameters.AddWithValue("@CONTACTPERSON", contact_person);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }


        public void UPDATE_SUPPLIER_DATA(int _supplierID ,string _supplierName, string _supplierAddress, string _TIN, bool _isVat,
            string contact_number, string contact_person)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_SUPPLIER_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SUPPLIERID", _supplierID);
                    cmd.Parameters.AddWithValue("@SUPPLIER_NAME", _supplierName);
                    cmd.Parameters.AddWithValue("@SUPPLIER_ADDRESS", _supplierAddress);
                    cmd.Parameters.AddWithValue("@TIN", _TIN);
                    cmd.Parameters.AddWithValue("@ISVAT", _isVat);
                    cmd.Parameters.AddWithValue("@CONTACTNUMBER", contact_number);
                    cmd.Parameters.AddWithValue("@CONTACTPERSON", contact_person);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        internal void UPDATE_BRANCH(string branch_code, string branch_name, string branch_tin, string branch_address, string company_code,
            int supervisor_id, bool is_active)
        {
            using (SqlConnection cn = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_BRANCH]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@BRANCHCODE", branch_code);
                    cmd.Parameters.AddWithValue("@BRANCHNAME", branch_name);
                    cmd.Parameters.AddWithValue("@BRANCHTIN", branch_tin);
                    cmd.Parameters.AddWithValue("@BRANCHADDRESS", branch_address);
                    cmd.Parameters.AddWithValue("@COMPANYCODE", company_code);
                    cmd.Parameters.AddWithValue("@SUPERVISOR", supervisor_id);
                    cmd.Parameters.AddWithValue("@ACTIVE", is_active);


                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }
        #endregion
    }
}