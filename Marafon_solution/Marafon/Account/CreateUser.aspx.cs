using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Marafon.Account
{
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string fnSetQueryFilter()
        {
            string strFind="";
            if((this.tboxFindCenter.Text != "") || (this.tboxFindLastName.Text != "") || (this.tboxFindRoleName.Text != "") || (this.tboxFindUserName.Text != ""))
            {
                if(this.tboxFindCenter.Text!="")
                {
                    strFind += string.Format("center_description like '%{0}%'",this.tboxFindCenter.Text);
                }
                if(this.tboxFindLastName.Text!="")
                {
                    if(strFind!="")
                    {
                        strFind+=" AND ";
                    }
                    strFind += string.Format("LastName like '%{0}%'", this.tboxFindLastName.Text);
                }
                if(this.tboxFindRoleName.Text!="")
                {
                    if(strFind!="")
                    {
                        strFind+=" AND ";
                    }
                    strFind += string.Format("RoleName like '%{0}%'", this.tboxFindRoleName.Text);
                }
                if(this.tboxFindUserName.Text!="")
                {
                    if(strFind!="")
                    {
                        strFind+=" AND ";
                    }
                    strFind += string.Format("UserName like '%{0}%'", this.tboxFindUserName.Text);
                }
            }
            return strFind;

        }

        protected void btnFindUser_Click(object sender, EventArgs e)
        {
            try
            {
                this.SqlDataSource1.FilterExpression = fnSetQueryFilter();
                this.SqlDataSource1.DataBind();
                this.DetailsView1.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshUser_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindCenter.Text = "";
                this.tboxFindLastName.Text = "";
                this.tboxFindRoleName.Text = "";
                this.tboxFindUserName.Text = "";
                this.SqlDataSource1.FilterExpression = fnSetQueryFilter();
                this.SqlDataSource1.DataBind();
                this.DetailsView1.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

    }
}