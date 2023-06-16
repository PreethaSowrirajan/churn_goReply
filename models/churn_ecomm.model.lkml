connection: "churn_test"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: weekly_data_ecomm {
  from:  weekly_data_ecomm
  label: "Weekly Data ecomm"
}

# hidden explore - used to create the native derived table to create a latest transaction week field
explore: dynamic_staging {
  # start from dynamic churn view
  from:  churn_ecomm
  label: "Dynamic staging"
  hidden: yes
}

explore: churn_ecomm {
  from:  churn_ecomm
  label: "Churn ecomm"
  # add the transaction_week_max field
  join: latest_dynamic_run {
    type: inner
    sql_on: ${churn_ecomm.transaction_week}=${latest_dynamic_run.transaction_week};;
    relationship: one_to_one
  }
}
