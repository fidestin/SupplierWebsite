using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace supplierData
{
    public partial class serviceAvailability : System.Web.UI.Page
    {
        public serviceWeek wk32;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack){
               
              //  BindData();
            }
        }

        protected void BindData()
        {
            DataTable dt=new DataTable();
            DataTable dtRev = new DataTable();

            DataRow dr=null;


            dt.Columns.Add(new DataColumn("mondayAv",typeof(string)));
            dt.Columns.Add(new DataColumn("tuesdayAv",typeof(string)));
            dt.Columns.Add(new DataColumn("wednesdayAv",typeof(string)));
            dt.Columns.Add(new DataColumn("thursdayAv",typeof(string)));
            dt.Columns.Add(new DataColumn("fridaAv",typeof(string)));
            dt.Columns.Add(new DataColumn("satAv",typeof(string)));
            dt.Columns.Add(new DataColumn("sunAv",typeof(string)));
            dt.Columns.Add(new DataColumn("legend",typeof(string)));

            dr=dt.NewRow();
            dr["mondayAv"]="4";
            dr["tuesdayAv"]="4";
            dr["wednesdayAv"]="4";
            dr["thursdayAv"]="4";
            dr["fridaAv"]="4";
            dr["satAv"]="4";
            dr["sunAv"]="4";
            dr["legend"] = "Availability";

            dt.Rows.Add(dr);

            //Do revenue table...for a different week
            dtRev.Columns.Add(new DataColumn("mondayAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("tuesdayAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("wednesdayAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("thursdayAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("fridaAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("satAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("sunAv", typeof(string)));
            dtRev.Columns.Add(new DataColumn("legend", typeof(string)));

            dr = dtRev.NewRow();
            dr["mondayAv"] = "2";
            dr["tuesdayAv"] = "4";
            dr["wednesdayAv"] = "6";
            dr["thursdayAv"] = "6";
            dr["fridaAv"] = "8";
            dr["satAv"] = "6";
            dr["sunAv"] = "4";
            dr["legend"] = "Availability";
            dtRev.Rows.Add(dr);

            //Add places taken row
            dr = dtRev.NewRow();
            dr["mondayAv"] = "2";
            dr["tuesdayAv"] = "1";
            dr["wednesdayAv"] = "2";
            dr["thursdayAv"] = "2";
            dr["fridaAv"] = "0";
            dr["satAv"] = "2";
            dr["sunAv"] = "2";
            dr["legend"] = "Places bought";
            dtRev.Rows.Add(dr);

            //Add revenue from those places
            dr = dtRev.NewRow();
            dr["mondayAv"] = "€40";
            dr["tuesdayAv"] = "0";
            dr["wednesdayAv"] = "€40";
            dr["thursdayAv"] = "€40";
            dr["fridaAv"] = "0";
            dr["satAv"] = "€40";
            dr["sunAv"] = "€40";
            dr["legend"] = "Revenue";
            dtRev.Rows.Add(dr);
            

            //Add
            //List<serviceWeek> serviceweeks = new List<serviceWeek>();
            //wk32 = new serviceWeek();

            //wk32.mondayAv = 2;
            //wk32.tuesdayAv = 4;
            //wk32.wednesdayAv = 6;
            //wk32.thursdayAv = 6;
            //wk32.fridaAv = 8;
            //wk32.satAv = 3;
            //wk32.sunAv = 3;

            //serviceweeks.Add(wk32);

           // ValidationDataType

            //GridView1.DataSource = dt;
            //GridView1.DataBind();

            //GridView2.DataSource = dtRev;
            //GridView2.DataBind();


        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}